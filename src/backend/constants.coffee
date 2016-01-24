###
Enviroment Configs
###

_ = require('lodash')

{ NODE_ENV, GOOGLE_SERVER_API_KEY, MANDRILL_API_KEY, MONGOLAB_URI } = process.env


unless NODE_ENV
  console.log '[ NODE_ENV ] not found. Goodbye...'
  process.exit(1)


if NODE_ENV in ['development', 'local', 'test']
  try
    key = require('../key.json')


base =
  FIELDS: ['name', 'email', 'address']
  TABLE_FLIP: "Sorry, we encountered an error.  (╯°□°）╯︵ ┻━┻ "


env = switch NODE_ENV
  when 'development', 'local'
    URL: 'http://nick.dev:5000/SaveTheDate'
    RSVP_URL: 'http://nick.dev:5000/RSVP'
    MONGOURI: 'mongodb://@localhost:27017/nickAndBora_dev'
    REFERER_REGEX: /.*/i
    REFERER_RSVP_REGEX: /.*/i
    MANDRILL_API_KEY: MANDRILL_API_KEY or key.MANDRILL_API_KEY
    GOOGLE_SERVER_API_KEY: GOOGLE_SERVER_API_KEY or key.GOOGLE_SERVER_API_KEY

  when 'test'
    URL: 'http://nick.dev:5000/SaveTheDate'
    RSVP_URL: 'http://nick.dev:5000/RSVP'
    MONGOURI: 'mongodb://@localhost:27017/nickAndBora_test'
    REFERER_REGEX: /.*/i
    REFERER_RSVP_REGEX: /.*/i
    MANDRILL_API_KEY: MANDRILL_API_KEY or key.MANDRILL_API_KEY
    GOOGLE_SERVER_API_KEY: GOOGLE_SERVER_API_KEY or key.GOOGLE_SERVER_API_KEY

  when 'qa'
    URL: 'http://qa.NickAndBora.Life/SaveTheDate'
    RSVP_URL: 'http://qa.NickAndBora.Life/RSVP'
    MONGOURI: MONGOLAB_URI
    REFERER_REGEX: /^http(s)?:\/\/qa.nickandbora.life\/savethedate/i
    REFERER_RSVP_REGEX: /^http(s)?:\/\/qa.nickandbora.life\/rsvp/i
    MANDRILL_API_KEY: MANDRILL_API_KEY
    GOOGLE_SERVER_API_KEY: GOOGLE_SERVER_API_KEY

  when 'production'
    URL: 'http://NickAndBora.Life/SaveTheDate'
    RSVP_URL: 'http://NickAndBora.Life/RSVP'
    MONGOURI: MONGOLAB_URI
    REFERER_REGEX: /^http(s)?:\/\/nickandbora.life\/savethedate/i
    REFERER_RSVP_REGEX: /^http(s)?:\/\/nickandbora.life\/rsvp/i
    MANDRILL_API_KEY: MANDRILL_API_KEY
    GOOGLE_SERVER_API_KEY: GOOGLE_SERVER_API_KEY


module.exports = _.extend({}, base, env)
