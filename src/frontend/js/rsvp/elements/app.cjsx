define [
  'zepto'
  'react'
  'rsvp/lib/delayFor'
  'rsvp/elements/login'
  'rsvp/elements/form'
], (
  $
  React
  DelayFor
  LoginElement
  FormElement
) ->

  RsvpApp = React.createClass

    getInitialState: ->
      authenticated: false

    onAuthenticated: ->
      $('input').removeClass('welcome').addClass('authenticated')
      do DelayFor 1200, =>
        @setState { authenticated: true }

    render: ->
      { authenticated } = @state

      <div id='NickAndBora-rsvp'>
        {if authenticated
          <FormElement />
        else
          <LoginElement onAuthenticated={@onAuthenticated}/>
        }
      </div>
