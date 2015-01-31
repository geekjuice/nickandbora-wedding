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
      label: ''
      optional: false

    getInitialState: ->
      value: @props.value or ''

    changeHandler: (e) ->
      { value } = e.currentTarget
      @setState { value }

    focusHandler: (e) ->
      $(e.currentTarget).parent().removeClass('invalid')

    keyDownHandler: (e) ->

    render: ->
      { name, label, optional } = @props
      { value } = @state

      <div className='field-container'>
        <label htmlFor={name}>
          {label or name}
          {if optional
            <small>(optional)</small>
          }
        </label>
        <div className='input-container'>
          <input type='text'
                 id={name}
                 name={name}
                 value={value}
                 onChange={@changeHandler}
                 onFocus={@focusHandler}
                 onKeyDown={@keyDownHandler}
                />
        </div>
      </div>
