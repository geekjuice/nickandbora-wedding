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

    render: ->
      <div id='NickAndBora-rsvp'>
        <LoginElement />
      </div>
