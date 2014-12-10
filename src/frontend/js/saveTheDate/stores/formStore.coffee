define [
  'lodash'
  'event'
  'model/contact'
  'saveTheDate/dispatcher'
], (_, Events, Contact, Dispatcher) ->

  class FormStore extends Events

    defaults: {}

    constructor: ->
      @state = _.clone @defaults

    get: (key) ->
      @state[key]

    set: (key, value) ->
      @state[key] = value

    emitChange: ->
      @emit('change')

  FormStore = new FormStore

  Dispatcher.register (payload) ->
    { action: { actionType, address, inputs } } = payload

    switch actionType
      when 'VALIDATE_INPUT'
        # Consider waitFor on Google Maps API validation
        { contact, valid, fields } = new Contact(inputs).validate()
        FormStore.set("contact", contact)
        FormStore.set("valid", valid)
        FormStore.set("fields", fields)
        FormStore.emitChange()

      when 'COMPLETE'
        FormStore.set("completed", true)
        FormStore.emitChange()

  FormStore

