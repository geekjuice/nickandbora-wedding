define [
  'zepto'
  'react'
  'rsvp/elements/login'
], (
  $
  React
  LoginElement
) ->

  RsvpApp = React.createClass

    getInitialState: ->
      authenticated: false

    onAuthenticated: ->
      $('input').removeClass('welcome').addClass('authenticated')
      setTimeout =>
        @setState { authenticated: true }
      , 1200

    render: ->
      { authenticated } = @state

      <div id='NickAndBora-rsvp'>
        {if authenticated
          <div>Oi</div>
        else
          <LoginElement onAuthenticated={@onAuthenticated}/>
        }
      </div>
