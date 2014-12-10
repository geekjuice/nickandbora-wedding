define [
  'react'
  'saveTheDate/actions/formActions'
], (React, FormActions) ->

  ButtonElement = React.createClass

    getDefaultProps: ->
      text: 'Submit'

    handleClick: (e) ->
      e.preventDefault()

      data = {}
      _.map $('#contacts-form').serializeArray(), (input) ->
        data[input.name] = input.value

      FormActions.validateInput(data)

    render: ->
      { text } = @props

      classes = React.addons.classSet
        'form-button': true

      <button type={'button'}
              className={classes}
              onClick={@handleClick}>
        {text}
      </button>
