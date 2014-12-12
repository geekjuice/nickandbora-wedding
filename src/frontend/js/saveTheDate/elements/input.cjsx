define [
  'react'
  'saveTheDate/mixins/listen'
  'saveTheDate/stores/formStore'
], (React, ListenMixin, FormStore) ->

  capitalize = (str) ->
    str[0].toUpperCase() + str[1...]

  InputElement = React.createClass

    mixins: [ListenMixin]

    getDefaultProps: ->
      name: 'input'

    getInitialState: ->
      value: @props.value or ''
      valid: true

    componentWillMount: ->
      @listenTo(FormStore)

    componentWillUnmount: ->
      @stopListening(FormStore)

    onStoreChange: ->
      fields = FormStore.get('fields') or []
      @setState { valid: @props.name not in fields }

    handleChange: (e) ->
      { value } = e.currentTarget
      @setState { value }

    handleFocus: (e) ->
      @props.onFocus?(e)
      @setState { valid: true, label: true }

    handleBlur: (e) ->
      @props.onBlur?(e)
      @setState { label: false }

    handleKeyup: (e) ->
      { keyCode } = e
      if @props.onBlur? and keyCode is 13
        return @props.onBlur(e)
      @props.onKeyUp?(e)

    getDisplayName: ->
      capitalize @props.placeholder or @props.name or 'input'

    render: ->
      { value, label, valid } = @state
      { name } = @props

      containerClasses = React.addons.classSet
        'form-input-container': true
        'form-input-invalid': not valid

      labelClasses = React.addons.classSet
        'form-input-label': true
        'form-input-focused': label

      <div className={containerClasses}>
        <span className={labelClasses}>
          {@getDisplayName()}
        </span>
        <input type='text'
               className={'form-input'}
               name={name}
               placeholder={@getDisplayName()}
               value={value}
               onBlur={@handleBlur}
               onFocus={@handleFocus}
               onChange={@handleChange}
               onKeyUp={@handleKeyup}
               spellCheck='false'
        />
      </div>
