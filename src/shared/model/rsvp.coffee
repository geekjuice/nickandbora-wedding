###
RSVP
###

_pick = (draft, players) ->
  team = {}
  for player in players when draft[player]?
    team[player] = draft[player]
  team

_result = (obj, thing) ->
  if typeof obj[thing] is 'function' then obj[thing]() else obj[thing]

_uniq = (stuff) ->
  unique = []
  for thing in stuff when thing not in unique
    unique.push thing
  unique

_formToObject = (fields) ->
  obj = {}
  for field in fields
    { name, value } = field
    obj[name] = value
  obj

_rsvp = ->

  REQUIRED_FIELDS = ['name', 'email', 'attending', 'food']
  OPTIONAL_FIELDS = ['music']
  EMAIL_REGEX = /^[a-zA-Z0-9-+_.]+@[a-zA-Z0-9-+_.]+\.[a-zA-Z]{2,}$/

  class Rsvp

    @validate: (form) ->
      new Rsvp(_formToObject form).validate()

    constructor: (@rsvp) ->
      @sanitize()

    sanitize: ->
      @rsvp = _pick @rsvp, ['_id', REQUIRED_FIELDS..., OPTIONAL_FIELDS...]
      for key, value of @rsvp
        @rsvp[key] = value.trim()

    errorMessages: ->
      { rsvp } = @
      hasFields: ->
        missing = []
        for field in REQUIRED_FIELDS
          rsvpField = rsvp[field]
          missing.push(field) unless rsvpField? and rsvpField
        if missing.length
          plural = unless missing.length is 1 then "s" else ""
          message: "[#{missing}] field#{plural} must be provided."
          fields: missing
      validEmail: ->
        if rsvp.email
          message: "[#{rsvp.email}] is not a valid email"
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

      rsvp: @rsvp
      valid: errors.length is 0
      errors: errors
      fields: _uniq(errorFields)

    hasFields: ->
      for field in REQUIRED_FIELDS when not @rsvp[field]
        return false
      true

    validEmail: ->
      { email } = @rsvp
      email? and EMAIL_REGEX.test(email)


if typeof module is "object"
  module.exports = _rsvp()
else
  define 'model/rsvp', [], _rsvp

