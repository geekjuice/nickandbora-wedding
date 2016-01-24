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
        'component': true
        'form-button': true

      <button
        type={'submit'}
        className={classes}
        onClick={@handleClick}>
        {text}
      </button>
