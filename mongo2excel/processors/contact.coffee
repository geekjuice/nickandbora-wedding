###
Contacts
###

_ = require('lodash')

WHITESPACE = /\s+/
capitalize = (s) -> s[0].toUpperCase() + s[1..]?.toLowerCase()
titleize = (s) -> s.trim().split(WHITESPACE).map(capitalize).join(' ')

KEYS = ['name', 'email', 'address']

module.exports = (entries) ->
  parsedEntries = []
  for entry in entries when entry
    parsedEntry = {}
    pickedValues = _.pick(JSON.parse(entry), KEYS)
    for key, value of pickedValues
      value = switch key
        when 'email' then value.toLowerCase()
        else titleize(value)
      parsedEntry[capitalize(key)] = value
    parsedEntries.push(parsedEntry)
  return parsedEntries
