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

    changeHandler: (e) ->
      return if @state.authenticated
      password = e.currentTarget.value
      authenticated = PASSWORD.test(password)
      @setState { password, authenticated }
      @successHandler() if authenticated

    focusHandler: (e) ->
      $(e.currentTarget).blur() if @state.authenticated

    successHandler: ->
      @setState { password: 'Authenticated' }
      $(@refs.login.getDOMNode()).blur()

    render: ->
      { password, authenticated } = @state
      <div>
        <input ref='login'
               type='text'
               placeholder='Yes?...'
               value={password}
               onChange={@changeHandler}
               onFocus={@focusHandler}
               />
      </div>

