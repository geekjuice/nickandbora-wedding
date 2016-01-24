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

  RadioElement = React.createClass

    getDefaultProps: ->
      name: ''
      options: []

    getInitialState: ->
      value: @props.value or @props.options[0]

    changeHandler: (e) ->
      { value } = e.currentTarget
      @setState { value }

    render: ->
      { name, options } = @props
      { value } = @state

      <div className='radio-container'>
        <label htmlFor={name}>{name}</label>
        {for option in options
          <div key={option}>
            <input type='radio'
                   name={name}
                   value={option}
                   onChange={@changeHandler}
                   checked={value is option}
                   />
            <label htmlFor={name}>{option}</label>
          </div>
        }
      </div>


