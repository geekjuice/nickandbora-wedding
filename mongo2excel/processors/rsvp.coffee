###
RSVP
###

_ = require('lodash')

WHITESPACE = /\s+/
capitalize = (s) -> s[0]?.toUpperCase() + s[1..]?.toLowerCase()
titleize = (s) -> s.trim().split(WHITESPACE).map(capitalize).join(' ')

KEYS = ['name', 'email', 'attending', 'food', 'music']

module.exports = (entries, onlyAttending=false) ->
  parsedEntries = []
  for entry in entries when entry
    parsedEntry = {}
    pickedValues = _.pick(JSON.parse(entry), KEYS)

    if onlyAttending and pickedValues.attending isnt 'yes'
      continue

    for key, value of pickedValues
      value = switch key
        when 'email' then value.toLowerCase()
        when 'attending', 'food' then value.toUpperCase()
        when 'music' then value or ''
        else titleize(value)
      parsedEntry[capitalize(key)] = value
    parsedEntries.push(parsedEntry)
  return parsedEntries
