define [
  'saveTheDate/dispatcher'
], (Dispatcher) ->

  LoginActions =

    authenticate: ->
      Dispatcher.handleLoginAction
        actionType: 'AUTHENTICATED'
