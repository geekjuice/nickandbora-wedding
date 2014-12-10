define [
  'lodash'
  'react'
  'saveTheDate/actions/loginActions'
], (_, React, LoginActions) ->

  PASSWORD = 'hello'

  LoginElement = React.createClass

    propTypes:
      className: React.PropTypes.string

    getDefaultProps: ->
      placeholder: 'Enter password...'

    getInitialState: ->
      value: ''
      authenticated: @props.authenticated ? false

    handleChange: (e) ->
      { value } = e.currentTarget
      authenticated = value is PASSWORD
      LoginActions.authenticate() if authenticated
      @setState { value, authenticated }

    handleFocus: (e) ->
      return @blur(e) if @state.authenticated

    handleBlur: (e) ->
      @props.onBlur?(e)

    handleKeyup: (e) ->
      return @blur(e) if @state.authenticated
      @props.onKeyUp?(e)

    blur: (e) ->
      e.currentTarget.blur() if @state.authenticated

    render: ->
      { value, authenticated } = @state
      { placeholder } = @props

      classes = React.addons.classSet
        'login-input': true
        'authenticated-input': authenticated

      value = "Save the Date" if authenticated

      <input type='text'
             className={classes}
             placeholder={placeholder}
             value={value}
             onBlur={this.handleBlur}
             onFocus={this.handleFocus}
             onChange={this.handleChange}
             onKeyUp={this.handleKeyup}
             autoFocus={true}
      />
