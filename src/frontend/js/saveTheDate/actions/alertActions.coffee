define [
  'saveTheDate/dispatcher'
], (Dispatcher) ->

  AlertActions =

    alert: (message) ->
      Dispatcher.handleAlertAction
        actionType: 'ALERT'
        message: message
