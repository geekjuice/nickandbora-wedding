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

  ENTER_KEY = 13

  InputElement = React.createClass

    getDefaultProps: ->
      name: ''
      next: _.noop
      prev: _.noop

    getInitialState: ->
      value: @props.value or ''

    changeHandler: (e) ->
      { value } = e.currentTarget
      @setState { value }

    keyDownHandler: (e) ->

    render: ->
      { name } = @props
      { value } = @state

      <div className='field-container'>
        <label htmlFor={name}>{name}</label>
        <div className='input-container'>
          <input type='text'
                 id={name}
                 name={name}
                 value={value}
                 onChange={@changeHandler}
                 onKeyDown={@keyDownHandler}
                />
        </div>
      </div>
