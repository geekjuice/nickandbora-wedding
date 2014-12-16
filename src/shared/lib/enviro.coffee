###
Enviro
###

Enviro = (_) ->

  ->
    KEYS =
      qa:     ['qa']
      prod:   ['production']
      local:  ['development', 'local']

    Env =
      get: _.memoize (key) ->
        process?.env?.NODE_ENV ?
        window?[key] ?
        window?.localStorage?[key] ?
        @getCookie(key) ?
        KEYS.prod

      isProd: _.memoize (key) ->
        @get(key) in KEYS.prod

      isQA: _.memoize (key) ->
        @get(key) in KEYS.qa

      isLocal: _.memoize (key) ->
        @get(key) in KEYS.local

      isDev: _.memoize (key) ->
        @get(key) in KEYS.local

      getCookie: _.memoize (key) ->
        for cookie in document?.cookie?.split(/\s*;\s*/g)
          [_key, _value] = cookie.split('=')
          return _value if _key is key
        return null


if typeof module is "object"
  module.exports = do Enviro(require('lodash'))
else
  define 'lib/enviro', ['lodash'], (_) -> do Enviro(_)

