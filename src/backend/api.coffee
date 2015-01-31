###
API
###

NAME = 'NickAndBora'

_             = require('lodash')
debug         = require('debug')(NAME)
router        = require('express').Router()
Googl         = require('goo.gl')
Styliner      = require('styliner')
{ ObjectID }  = require('mongoskin')

C         = require('./constants')
Enviro    = require('./lib/enviro')
Contact   = require('./model/contact')
Rsvp      = require('./model/rsvp')
Mandrill  = require('./mandrill')
Templates = require('./templates')


## Setup Goo.gl
Googl.setKey(C.GOOGLE_SERVER_API_KEY)

## GET Item
router.get "/:collection/:type/:value", (req, res, next) ->
  { collection, params: { type, value } } = req
  if type not in C.FIELDS
    res.send({status: 400, errors: ["#{type} is not a valid field."]})

  query = {}
  query[type] = value

  _findModel collection, query, (items) ->
    return next(e) if e
    res.send(items)


## POST Model
router.post "/:collection", (req, res, next) ->
  { body, headers, collection } = req

  collectionType = req.params.collection.toLowerCase()

  switch collectionType
    when 'contact'
      unless C.REFERER_REGEX.test headers?.referer
        return res.send({status: 401, message: C.TABLE_FLIP})
      { contact, valid, errors, fields } = _validateContact(body)
      model = contact
    when 'rsvp'
      unless C.REFERER_RSVP_REGEX.test headers?.referer
        return res.send({status: 401, message: C.TABLE_FLIP})
      { rsvp, valid, errors, fields } = _validateRsvp(body)
      rsvp.music ?= ''
      model = rsvp

  return res.send({ status: 400, errors, fields }) unless valid

  addCallback = (e, items) ->
    return res.send({ status: 500, error: e}) if e
    model = _.first(items)
    switch collectionType
      when 'contact'
        _sendThankYou(model)
        model = _.omit(model, '_id')
        res.send({ status: 200, message: "Contact saved.", contact: model })
      when 'rsvp'
        _sendRSVPThankYou(model)
        model = _.omit(model, '_id')
        res.send({ status: 200, message: "RSVP saved.", rsvp: model })

  { _id } = model
  _.extend model, submitted: _.now()

  unless _id
    return _addModel(collection, model, addCallback)

  _id = new ObjectID(_id)
  _findModel collection, { _id }, (e, items) ->
    return next(e) if e

    unless items.length
      return _addModel(collection, model, addCallback)

    previousModel = _.first(items)
    model.versions = _.cloneDeep(previousModel.versions ? {})
    model.versions[previousModel.submitted] = _.omit(previousModel, ['versions', '_id'])

    _updateModel collection, model, (e) =>
      return next(e) if e
      model = _.omit(model, ['versions', '_id'])
      switch collectionType
        when 'contact'
          _sendThankYou(model)
          res.send({ status: 200, message: "Contact updated.", contact: model })
        when 'rsvp'
          _sendRSVPThankYou(model)
          res.send({ status: 200, message: "RSVP updated.", rsvp: model })



_validateContact = (contact) ->
  (new Contact(contact)).validate()

_validateRsvp = (rsvp) ->
  (new Rsvp(rsvp)).validate()

# Save the Date - Thank you email
_sendThankYou = (contact) ->
  if Enviro.isLocal()
    return debug '[API] Local environment: Email not sent.'

  sendEmail = (html, text) ->
    { email, name } = contact
    options = { html, text, to: [{ email, name, type: 'to' }] }
    new Mandrill('Save the Date').send({message: options})

  inlineStyles = (editUrl) ->
    opts = _.extend(contact, { editUrl, _authenticated: true })
    html = Templates.thankYou(opts)
    text = Templates.thankYouText(opts)

    (new Styliner).processHTML(html)
      .then (inlinedHtml) -> sendEmail(inlinedHtml, text)
      .fail (err) ->
        debug "[Styliner] Failed to inline styles. Using original document."
        sendEmail(html, text)

  query = ['_authenticated=true']
  for key, value of _.omit(contact, 'submitted')
    query.push "#{key}=#{encodeURIComponent value}"
  editUrl = "#{C.URL}/?#{query.join('&')}"

  Googl.shorten(editUrl).then(inlineStyles).catch (err) ->
    debug "[GOO.GL] Error shortening #{editUrl}. Using original URL."
    inlineStyles(editUrl)


# RSVP - Thank you email
_sendRSVPThankYou = (model) ->
  if Enviro.isLocal()
    return debug '[API] Local environment: Email not sent.'

  sendEmail = (html, text) ->
    { email, name } = model
    options = { html, text, to: [{ email, name, type: 'to' }] }
    new Mandrill('RSVP').send({message: options})

  inlineStyles = (editUrl) ->
    opts = _.extend(model, { editUrl, __authenticated: true })
    html = Templates.rsvp(opts)
    text = Templates.rsvpText(opts)

    (new Styliner).processHTML(html)
      .then (inlinedHtml) ->
        sendEmail(inlinedHtml, text)
      .fail (err) ->
        debug "[Styliner] Failed to inline styles. Using original document."
        sendEmail(html, text)

  query = ['__authenticated=true']
  for key, value of _.omit(model, 'submitted')
    query.push "#{key}=#{encodeURIComponent value}"
  editUrl = "#{C.RSVP_URL}/?#{query.join('&')}"

  Googl.shorten(editUrl).then(inlineStyles).catch (err) ->
    debug "[GOO.GL] Error shortening #{editUrl}. Using original URL."
    inlineStyles(editUrl)


# Mongo Helpers
_findModel = (collection, query, callback) ->
  collection.find(query).toArray (e, items) ->
    callback(e, items)

_addModel = (collection, model, callback) ->
  model = _.omit(model, '_id')
  collection.insert model, {}, (e, items) =>
    callback(e,items)

_updateModel = (collection, model, callback) ->
  _id = new ObjectID(model._id)
  model = _.omit(model, '_id')
  collection.update { _id }, model, {upsert: true}, (e) ->
    callback(e)


## Export Router
module.exports = router
