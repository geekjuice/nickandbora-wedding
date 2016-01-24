define [
  'react'
  'saveTheDate/stores/loginStore'
  'saveTheDate/mixins/listen'
  'saveTheDate/mixins/queryparams'
  'saveTheDate/elements/login'
  'saveTheDate/elements/welcome'
  'saveTheDate/elements/form'
  'saveTheDate/elements/footer'
], (
  React
  LoginStore
  ListenMixin
  QueryMixin
  Login
  Welcome
  Form
  Footer
) ->

  App = React.createClass

    mixins: [ListenMixin, QueryMixin]

    getInitialState: ->
      authenticated: false
      completed: false

    onStoreChange: ->
      { authenticated } = @state
      authenticated = LoginStore.get('authenticated') ? authenticated
      @setState { authenticated }

    componentWillMount: ->
      @listenTo(LoginStore)

      { _authenticated } = @parseQueryParams('_authenticated')
      if _authenticated? and /^true$/.test _authenticated
        @setState { authenticated: true }

    componentWillUnmount: ->
      @stopListening(LoginStore)

    componentWillLeave: (cb) ->
      $('#signup').addClass('signup-hidden')
      setTimeout cb, 1000

    componentDidLeave: ->

    render: ->
      { authenticated } = @state

      <div id={@props.id} className="signup-container">
        <Login authenticated={authenticated} />
        {if authenticated
          <div>
            <Welcome />
            <Form />
            <Footer />
          </div>
        }
      </div>

