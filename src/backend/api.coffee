###
API
###

_         = require('lodash')
router    = require('express').Router()
Styliner  = require('styliner')

C         = require('./constants')
Contact   = require('./model/contact')
Mandrill  = require('./mandrill')
Templates = require('./templates')


## GET Item
router.get "/:collection/:type/:value", (req, res, next) ->
  { type, value } = req.params
  if type not in C.FIELDS
    res.send({status: 400, errors: ["#{type} is not a valid field."]})

  query = {}
  query[type] = value

  cursor = req.collection.find(query)
  cursor.toArray (e, items) ->
    return next(e) if e
    res.send(items)


## POST Contact
router.post "/:collection", (req, res, next) ->
  { body, headers, collection } = req

  unless C.REFERER_REGEX.test headers?.referer
    return res.send({status: 401, message: C.TABLE_FLIP})

  { contact, valid, errors, fields } = _validateContact(body)
  _.extend contact, submitted: _.now()

  if valid
    collection.insert contact, {}, (e, items) =>
      return next(e) if e
      item = _.omit(_.first(items), '_id')
      _sendThankYou(item)
      res.send({status: 200, message: "Contact saved.", contact: item})
  else
    res.send({status: 400, errors, fields})


_validateContact = (contact) ->
  (new Contact(contact)).validate()

_sendThankYou = (contact) ->
  { name, email, address } = contact
  editUrl = "#{C.URL}/?name=#{name}&email=#{email}&address=#{address}&_authenticated=true"
  _authenticated = true

  opts = _.extend(contact, { editUrl, _authenticated })
  html = Templates.thankYou(opts)
  text = Templates.thankYouText(opts)

  (new Styliner).processHTML(html).then (html) ->
    options = { html, text, to: [{ email, name, type: 'to' }] }
    Mandrill.send({message: options})


## Export Router
module.exports = router
