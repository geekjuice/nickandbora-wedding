define [
  'saveTheDate/dispatcher'
], (Dispatcher) ->

  MapActions =

    updateMap: (address) ->
      Dispatcher.handleFormAction
        actionType: 'UPDATE_MAP'
        address: address
