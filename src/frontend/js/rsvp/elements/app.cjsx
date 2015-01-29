define [
  'zepto'
  'react'
  'rsvp/lib/delay'
  'rsvp/elements/login'
  'rsvp/elements/form'
], (
  $
  React
  Delay
  LoginElement
  FormElement
) ->

  RsvpApp = React.createClass

    getInitialState: ->
      authenticated: true

    onAuthenticated: ->
      $('input').removeClass('welcome').addClass('authenticated')
      Delay.run 1200, =>
        @setState { authenticated: true }
        $('#NickAndBora').removeClass('login')

    render: ->
      { authenticated } = @state

      <div id='NickAndBora-rsvp'>
        {if authenticated
          <FormElement />
        else
          <LoginElement onAuthenticated={@onAuthenticated}/>
        }
      </div>
