define [
  'zepto'
  'react'
], (
  $
  React
) ->

  PASSWORD = /since[ ]?2005/i

  LoginElement = React.createClass

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
      @getElement('login').blur().addClass('autheticating')
      setTimeout =>
        @setState { password: 'Oh, hello :D' }
        @getElement('login')
          .removeClass('autheticating')
          .addClass('authenticated')
      , 1200

    componentDidMount: ->
      setTimeout =>
        @getElement('login').focus()
      , 600

    render: ->
      { password, authenticated } = @state
      <div>
        <input ref='login'
               type='text'
               placeholder='How long?...'
               value={password}
               onChange={@changeHandler}
               onFocus={@focusHandler}
               />
      </div>

