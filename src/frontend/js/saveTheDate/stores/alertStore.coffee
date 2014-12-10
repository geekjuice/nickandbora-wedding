define [
  'lodash'
  'event'
  'saveTheDate/dispatcher'
], (_, Events, Dispatcher) ->

  class AlertStore extends Events

    defaults:
      alerting: false

    constructor: ->
      @state = _.clone @defaults

    get: (key) ->
      @state[key]

    set: (key, value) ->
      @state[key] = value
      @emitChange()

    emitChange: ->
      @emit('change')

  AlertStore = new AlertStore

  Dispatcher.register (payload) ->
    { action: { actionType, message } } = payload

    switch actionType
      when 'ALERT'
        AlertStore.set("message", message)

  AlertStore

