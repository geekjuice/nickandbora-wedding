###
API
###

KEY = 'NickAndBora-Env'

_             = require('lodash')
router        = require('express').Router()
Styliner      = require('styliner')
{ ObjectID }  = require('mongoskin')

C         = require('./constants')
Enviro    = require('./lib/enviro')
Contact   = require('./model/contact')
Mandrill  = require('./mandrill')
Templates = require('./templates')

## GET Item
router.get "/:collection/:type/:value", (req, res, next) ->
  { collection, params: { type, value } } = req
  if type not in C.FIELDS
    res.send({status: 400, errors: ["#{type} is not a valid field."]})

  query = {}
  query[type] = value

  _findContact collection, query, (items) ->
    return next(e) if e
    res.send(items)


## POST Contact
router.post "/:collection", (req, res, next) ->
  { body, headers, collection } = req

  unless C.REFERER_REGEX.test headers?.referer
    return res.send({status: 401, message: C.TABLE_FLIP})

  { contact, valid, errors, fields } = _validateContact(body)

  return res.send({ status: 400, errors, fields }) unless valid

  addCallback = (e, items) ->
    return next(e) if e
    contact = _.first(items)
    _sendThankYou(contact)
    contact = _.omit(contact, '_id')
    res.send({ status: 200, message: "Contact saved.", contact })

  { _id } = contact
  _.extend contact, submitted: _.now()

  return _addContact(collection, contact, addCallback) unless _id

  _id = new ObjectID(_id)
  _findContact collection, { _id }, (e, items) ->
    return next(e) if e

    return _addContact(collection, contact, addCallback) unless items.length

    previousContact = _.first(items)
    contact.versions = _.cloneDeep(previousContact.versions ? {})
    contact.versions[previousContact.submitted] = _.omit(previousContact, ['versions', '_id'])
    _updateContact collection, contact, (e) =>
      return next(e) if e
      _sendThankYou(contact)
      contact = _.omit(contact, ['versions', '_id'])
      res.send({ status: 200, message: "Contact updated.", contact })


_validateContact = (contact) ->
  (new Contact(contact)).validate()

_sendThankYou = (contact) ->
  return if Enviro.isLocal(KEY)
  { _id, name, email, address } = contact
  # Encode?
  editUrl = "#{C.URL}/?name=#{name}&email=#{email}&address=#{address}&_id=#{_id}&_authenticated=true"
  _authenticated = true

  opts = _.extend(contact, { editUrl, _authenticated })
  html = Templates.thankYou(opts)
  text = Templates.thankYouText(opts)

  (new Styliner).processHTML(html).then (html) ->
    options = { html, text, to: [{ email, name, type: 'to' }] }
    Mandrill.send({message: options})


# Mongo Helpers
_findContact = (collection, query, callback) ->
  collection.find(query).toArray (e, items) ->
    callback(e, items)

_addContact = (collection, contact, callback) ->
  collection.insert contact, {}, (e, items) =>
    callback(e,items)

_updateContact = (collection, contact, callback) ->
  _id = new ObjectID(contact._id)
  contact = _.omit(contact, '_id')
  collection.update { _id }, contact, {upsert: true}, (e) ->
    callback(e)


## Export Router
module.exports = router
