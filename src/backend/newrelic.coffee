###
New Relic agent configuration.

See lib/config.defaults.js in the agent distribution for a more complete
description of configuration variables and their potential values.
###

{ NODE_ENV, NEW_RELIC_LICENSE_KEY } = process.env

appname = switch NODE_ENV
  when 'production' then 'NickAndBora'
  when 'qa' then 'NickAndBora-QA'

exports.config =
  ###
  Array of application names.
  ###
  app_name: [appname]

  ###
  Your New Relic license key.
  ###
  license_key: NEW_RELIC_LICENSE_KEY

  ###
  Level at which to log. 'trace' is most useful to New Relic when diagnosing
  issues with the agent, 'info' and higher will impose the least overhead on
  production applications.
  ###
  logging:
    level: 'info'

