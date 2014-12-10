###
# Jade Templates
###

_     = require('lodash')
jade  = require('jade')
path  = require('path')
fs    = require('fs')

JADE_FILE_REGEX = /(\w+)\.jade$/
TEXT_FILE_REGEX = /(\w+)\.text$/

_.templateSettings.interpolate = /{{([\s\S]+?)}}/g

templates = {}
templateDir = path.join __dirname, '_templates'

if fs.existsSync templateDir
  filenames = fs.readdirSync(templateDir)

  for file in filenames
    filename = path.join(templateDir, file)
    switch
      when JADE_FILE_REGEX.test(file)
        name = file.match(JADE_FILE_REGEX)[1]
        templates[name] = jade.compileFile filename
      when TEXT_FILE_REGEX.test(file)
        name = file.match(TEXT_FILE_REGEX)[1]
        template = fs.readFileSync(filename).toString()
        templates[name] = _.curry _.template(template)

module.exports = templates
