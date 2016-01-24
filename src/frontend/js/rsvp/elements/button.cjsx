define [
  'lodash'
  'zepto'
  'react'
  'rsvp/lib/delay'
], (
  _
  $
  React
  Delay
) ->

  ButtonElement = React.createClass

    getDefaultProps: ->
      text: ''
      onClick: _.noop

    render: ->
      { text } = @props
      <button onClick={@props.onClick}>{text}</button>
