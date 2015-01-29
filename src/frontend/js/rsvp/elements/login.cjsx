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

  PASSWORD = /since[ ]?2005/i

  LoginElement = React.createClass

    getDefaultProps: ->
      onAuthenticated: _.noop

    getInitialState: ->
      password: ''
      authenticated: false

    getElement: (name) ->
      ref = @refs[name]
      return [] unless ref
      $(ref.getDOMNode())

    changeHandler: (e) ->
      return if @state.authenticated
      password = e.currentTarget.value
      authenticated = PASSWORD.test(password)
      @setState { password, authenticated }
      @successHandler() if authenticated

    focusHandler: (e) ->
      $(e.currentTarget).blur() if @state.authenticated

    successHandler: ->
      @getElement('login').blur().addClass('authenticating')
      Delay.run(1200, @showWelcome)
        .then(Delay.for(2400, @props.onAuthenticated))

    showWelcome: ->
      @setState { password: 'Oh, hello :D' }
      @getElement('login').removeClass('authenticating').addClass('welcome')

    componentWillMount: ->
      $('#NickAndBora').addClass('login')

    componentDidMount: ->
      Delay.run 600, =>
        @getElement('login').focus()

    render: ->
      { password } = @state
      <div className='field-container'>
        <input ref='login'
               type='text'
               placeholder='How long?...'
               value={password}
               onChange={@changeHandler}
               onFocus={@focusHandler}
               />
      </div>

