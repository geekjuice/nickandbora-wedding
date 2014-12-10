###
Contact
###

_pick = (draft, players) ->
  team = {}
  for player in players when draft[player]
    team[player] = draft[player]
  team

_result = (obj, thing) ->
  if typeof obj[thing] is 'function' then obj[thing]() else obj[thing]

_uniq = (stuff) ->
  unique = []
  for thing in stuff when thing not in unique
    unique.push thing
  unique


_contact = ->

  REQUIRED_FIELDS = ['name', 'email', 'address']
  EMAIL_REGEX = /^[a-zA-Z0-9-+_.]+@[a-zA-Z0-9-+_.]+\.[a-zA-Z]{2,}$/

  class Contact

    constructor: (@contact) ->
      @sanitize()

    sanitize: ->
      @contact = _pick @contact, REQUIRED_FIELDS
      for key, value of @contact
        @contact[key] = value.trim()

    errorMessages: ->
      { contact } = @
      hasFields: ->
        missing = []
        for field in REQUIRED_FIELDS
          contactField = contact[field]
          missing.push(field) unless contactField? and contactField
        if missing.length
          plural = unless missing.length is 1 then "s" else ""
          message: "[#{missing}] field#{plural} must be provided."
          fields: missing
      validEmail: ->
        if contact.email
          message: "[#{contact.email}] is not a valid email"
          fields: ['email']

    validate: ->
      validations =
        hasFields: @hasFields()
        validEmail: @validEmail()

      errorFields = []
      errors = []
      for type, valid of validations when not valid
        { message, fields } = _result(@errorMessages(), type) or {}
        errors.push(message) if message
        errorFields.push(fields...) if fields

      contact: @contact
      valid: errors.length is 0
      errors: errors
      fields: _uniq(errorFields)

    hasFields: ->
      for field in REQUIRED_FIELDS when not @contact[field]
        return false
      true

    validEmail: ->
      { email } = @contact
      email? and EMAIL_REGEX.test(email)


if typeof module is "object"
  module.exports = _contact()
else
  define 'model/contact', [], _contact

