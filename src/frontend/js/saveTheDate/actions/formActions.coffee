define [
  'saveTheDate/dispatcher'
], (Dispatcher) ->

  FormActions =

    validateInput: (inputs) ->
      Dispatcher.handleFormAction
        actionType: 'VALIDATE_INPUT'
        inputs: inputs

    complete: ->
      Dispatcher.handleFormAction
        actionType: 'COMPLETE'
