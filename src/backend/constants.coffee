###
Enviroment Configs
###

_ = require('lodash')

{ NODE_ENV, MANDRILL_API_KEY, MONGOLAB_URI } = process.env


unless NODE_ENV
  console.log '[ NODE_ENV ] not found. Goodbye...'
  process.exit(1)


if NODE_ENV in ['development', 'local', 'test']
  try
    key = require('../key.json')


base =
  URL: 'http://NickAndBora.Life/SaveTheDate'
  FIELDS: ['name', 'email', 'address']
  TABLE_FLIP: "Sorry, we encountered an error.  (╯°□°）╯︵ ┻━┻ "


env = switch NODE_ENV
  when 'development', 'local'
    MONGOURI: 'mongodb://@localhost:27017/nickAndBora_dev'
    REFERER_REGEX: /.*/i
    MANDRILL_API_KEY: MANDRILL_API_KEY or key.MANDRILL_API_KEY

  when 'test'
    MONGOURI: 'mongodb://@localhost:27017/nickAndBora_test'
    REFERER_REGEX: /.*/i
    MANDRILL_API_KEY: MANDRILL_API_KEY or key.MANDRILL_API_KEY

  when 'qa'
    MONGOURI: MONGOLAB_URI
    REFERER_REGEX: /^http(s)?:\/\/qa.nickandbora.life\/savethedate/i
    MANDRILL_API_KEY: MANDRILL_API_KEY

  when 'production'
    MONGOURI: MONGOLAB_URI
    REFERER_REGEX: /^http(s)?:\/\/nickandbora.life\/savethedate/i
    MANDRILL_API_KEY: MANDRILL_API_KEY


module.exports = _.extend({}, base, env)
