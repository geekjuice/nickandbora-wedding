define [
  'lodash'
  'event'
  'saveTheDate/dispatcher'
], (_, Events, Dispatcher) ->

  class MapStore extends Events

    defaults: {}

    constructor: ->
      @state = _.clone @defaults

    get: (key) ->
      @state[key]

    set: (key, value) ->
      @state[key] = value

    emitChange: ->
      @emit('change')

  MapStore = new MapStore

  Dispatcher.register (payload) ->
    { action: { actionType, address, inputs } } = payload

    switch actionType
      when 'UPDATE_MAP'
        MapStore.set("address", address)
        MapStore.emitChange()

  MapStore


