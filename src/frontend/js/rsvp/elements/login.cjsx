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

    letMeIn: ->
      @setState
        password: 'since2005'
        authenticated: true
      @successHandler()

    changeHandler: (e) ->
      return if @state.authenticated
      password = e.currentTarget.value
      authenticated = PASSWORD.test(password)
      @setState { password, authenticated }
      @successHandler() if authenticated

    focusHandler: (e) ->
      $(e.currentTarget).blur() if @state.authenticated

    successHandler: ->
      @getElement('cheat').addClass('authenticating')
      @getElement('login').blur().addClass('authenticating')
      Delay
        .run(1200, @showWelcome)
        .then(Delay.for(2400, @props.onAuthenticated))

    showWelcome: ->
      @setState { password: 'Oh, hello there ^_^' }
      @getElement('login').removeClass('authenticating').addClass('welcome')

    componentWillMount: ->
      $('#NickAndBora').addClass('login')

    componentDidMount: ->
      Delay.run 600, =>
        @getElement('login').focus()

    render: ->
      { password } = @state
      <div className='field-container cheat'>
        <input
          ref='login'
          type='text'
          placeholder='Together...'
          value={password}
          onChange={@changeHandler}
          onFocus={@focusHandler}
        />
        <button ref='cheat' onClick={@letMeIn}>
          Just let me in...
        </button>
      </div>

