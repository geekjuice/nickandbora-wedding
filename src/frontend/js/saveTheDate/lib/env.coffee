define [], ->

  KEYS =
    local: 'local'
    prod: 'production'

  Env =

    get: (key) ->
      window[key] ? window.localStorage?[key] ? KEYS.prod

    isLocal: (key) ->
      @get(key) is KEYS.local

    isProd: (key) ->
      @get(key) is KEYS.prod
