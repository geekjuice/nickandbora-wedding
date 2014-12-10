define [
  'zepto'
  'react'
  'saveTheDate/stores/loginStore'
  'saveTheDate/stores/formStore'
  'saveTheDate/mixins/queryparams'
  'saveTheDate/mixins/listen'
  'saveTheDate/elements/alert'
  'saveTheDate/elements/signup'
  'saveTheDate/elements/thankYou'
], (
  $
  React
  LoginStore
  FormStore
  QueryMixin
  ListenMixin
  AlertElement
  SignUpElement
  ThankYouElement
) ->

  { TransitionGroup } = React.addons

  App = React.createClass

    mixins: [ListenMixin, QueryMixin]

    getInitialState: ->
      authenticated: false
      completed: false

    onStoreChange: ->
      { authenticated, completed } = @state
      authenticated = LoginStore.get('authenticated') ? authenticated
      completed = FormStore.get('completed') ? completed
      @setState { authenticated, completed }

    componentWillMount: ->
      @listenTo(LoginStore)
      @listenTo(FormStore)

      { _authenticated } = @parseQueryParams('_authenticated')
      if _authenticated? and /^true$/.test _authenticated
        @setState { authenticated: true }

    componentWillUnmount: ->
      @stopListening(LoginStore)
      @stopListening(FormStore)

    render: ->
      { authenticated, completed } = @state

      classes = React.addons.classSet
        'app': true
        'completed': completed

      $('html, body').addClass('authenticated') if authenticated

      <div className={classes}>
        <AlertElement />
        <TransitionGroup>
          {if completed
            <ThankYouElement key="thank-you" id="thank-you" />
          else
            <SignUpElement key="signup" id="signup" />
          }
        </TransitionGroup>
      </div>
