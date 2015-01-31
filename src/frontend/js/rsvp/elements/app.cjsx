define [
  'zepto'
  'react'
  'rsvp/lib/delay'
  'rsvp/mixins/queryparams'
  'rsvp/elements/login'
  'rsvp/elements/form'
], (
  $
  React
  Delay
  QueryMixin
  LoginElement
  FormElement
) ->

  RsvpApp = React.createClass

    mixins: [QueryMixin]

    getInitialState: ->
      authenticated: false

    componentWillMount: ->
      { __authenticated } = @parseQueryParams('__authenticated')
      if __authenticated? and /^true$/.test __authenticated
        @setState { authenticated: true }

    onAuthenticated: ->
      $('input').removeClass('welcome').addClass('authenticated')
      Delay.run 1200, =>
        @setState { authenticated: true }
        $('#NickAndBora').removeClass('login')

    render: ->
      { authenticated } = @state

      <div id='NickAndBora-rsvp'>
        {if authenticated
          <FormElement />
        else
          <LoginElement onAuthenticated={@onAuthenticated}/>
        }
      </div>
