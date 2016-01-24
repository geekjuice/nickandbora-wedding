define [
  'lodash'
  'flux'
], (_, Flux) ->

  Dispatcher = _.extend (new Flux.Dispatcher),

    handleLoginAction: (action) ->
      source = 'LOGIN_ACTION'
      @dispatch { source, action }

    handleFormAction: (action) ->
      source = 'FORM_ACTION'
      @dispatch { source, action }

    handleAlertAction: (action) ->
      source = 'ALERT_ACTION'
      @dispatch { source, action }
