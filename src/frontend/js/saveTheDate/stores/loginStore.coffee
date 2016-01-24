define [
  'lodash'
  'event'
  'saveTheDate/dispatcher'
], (_, Events, Dispatcher) ->

  class LoginStore extends Events

    defaults: {}

    constructor: ->
      @state = _.clone @defaults

    get: (key) ->
      @state[key]

    set: (key, value) ->
      @state[key] = value
      @emitChange()

    emitChange: ->
      @emit('change')

  LoginStore = new LoginStore

  Dispatcher.register (payload) ->
    { action: { actionType } } = payload

    switch actionType
      when 'AUTHENTICATED'
        LoginStore.set("authenticated", true)

  LoginStore
