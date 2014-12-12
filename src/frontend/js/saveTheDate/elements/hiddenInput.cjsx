define [
  'react'
], (React) ->

  HiddenInput = React.createClass

    getDefaultProps: ->
      value: ''

    render: ->
      { name, value } = @props

      <input type='hidden'
             name={name}
             value={value}
      />
