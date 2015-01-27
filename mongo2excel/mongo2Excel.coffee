_         = require('lodash')
fs        = require('fs')
json2xls  = require('json2xls')

if process.argv.length < 4
  console.log 'Provide input and output filenames please. Exiting...'
  process.exit(1)

if process.argv.length < 3
  console.log 'Provide output filename please. Exiting...'

RAW_MONGO_DUMP_FILENAME = process.argv[2]
OUTPUT_FILENAME = process.argv[3]

WHITESPACE = /\s+/
capitalize = (s) -> s[0].toUpperCase() + s[1..]?.toLowerCase()
titleize = (s) -> s.trim().split(WHITESPACE).map(capitalize).join(' ')

process.stdout.write "Reading mongo dump file [#{RAW_MONGO_DUMP_FILENAME}]..."
fs.readFile RAW_MONGO_DUMP_FILENAME, (err, data) ->
  throw(err) if err
  console.log 'Done!'

  process.stdout.write 'Parsing raw dump output...'
  entries = data.toString().split('\n')
  parsedEntries = []
  for entry in entries when entry
    parsedEntry = {}
    pickedValues = _.pick(JSON.parse(entry), ['name', 'email', 'address'])
    for key, value of pickedValues
      value = if key is 'email' then value.toLowerCase() else titleize(value)
      parsedEntry[capitalize(key)] = value
    parsedEntries.push(parsedEntry)
  console.log 'Done!'

  process.stdout.write 'Converting JSON to XLS binary...'
  xls = json2xls(parsedEntries)
  console.log 'Done!'

  process.stdout.write "Writing XLS binary to [#{OUTPUT_FILENAME}]..."
  fs.writeFile OUTPUT_FILENAME, xls, 'binary', (err) ->
    console.log 'Done!'
    throw(err) if err
