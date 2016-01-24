define [
  'zepto'
  'react'
  'rsvp/lib/delay'
  'rsvp/mixins/queryparams'
  'rsvp/elements/login'
  'rsvp/elements/form'
  'rsvp/elements/finished'
], (
  $
  React
  Delay
  QueryMixin
  LoginElement
  FormElement
  FinishedElement
) ->

  RsvpApp = React.createClass

    mixins: [QueryMixin]

    getInitialState: ->
      authenticated: false
      finished: false
      attending: false

    componentWillMount: ->
      { __authenticated } = @parseQueryParams('__authenticated')
      if __authenticated? and /^true$/.test __authenticated
        @setState { authenticated: true }

    onAuthenticated: ->
      $('input').removeClass('welcome').addClass('authenticated')
      Delay.run 1200, =>
        @setState { authenticated: true }
        $('#NickAndBora').removeClass('login')

    onFinish: (rsvp) ->
      Delay.run 1200, =>
        @setState { finished: true, attending: rsvp.attending }

    render: ->
      { finished, authenticated, attending } = @state

      <div id='NickAndBora-rsvp'>
        {if finished
          <FinishedElement attending={attending}/>
        else if authenticated
          <FormElement onFinish={@onFinish}/>
        else
          <LoginElement onAuthenticated={@onAuthenticated}/>
        }
      </div>
