define [
  'lodash'
  'react'
  'saveTheDate/actions/loginActions'
], (_, React, LoginActions) ->

  PASSWORD = /^march 28[,]? 2015$/i

  LoginElement = React.createClass

    propTypes:
      className: React.PropTypes.string

    getDefaultProps: ->
      placeholder: 'Enter password...'

    getInitialState: ->
      value: ''
      authenticated: @props.authenticated ? false

    componentWillMount: ->
      @_onceChangeLoginLabel = _.once @changeLoginLabel

    handleChange: (e) ->
      { value } = e.currentTarget
      authenticated = PASSWORD.test value
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

    changeLoginLabel: ->
      setTimeout =>
        @setState { value: "Save the Date" }
      , 500

    render: ->
      { value, authenticated } = @state
      { placeholder } = @props

      classes = React.addons.classSet
        'component': true
        'login-input': true
        'authenticated-input': authenticated

      do @_onceChangeLoginLabel if authenticated

      <input type='text'
             className={classes}
             placeholder={placeholder}
             value={value}
             onBlur={this.handleBlur}
             onFocus={this.handleFocus}
             onChange={this.handleChange}
             onKeyUp={this.handleKeyup}
             autoFocus={not authenticated}
      />
