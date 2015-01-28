define [
  'lodash'
  'zepto'
  'react'
  'rsvp/lib/delayFor'
], (
  _
  $
  React
  DelayFor
) ->

  FormElement = React.createClass

    getInitialState: ->
      loading: true

    componentDidMount: ->
      do DelayFor(1200, @revealForm)

    revealForm: ->
      @setState { loading: false }

    render: ->
      { loading } = @state

      formClasses = React.addons.classSet
        'loading': loading

      <div id='rsvpForm' className={formClasses}>
        {if 1
          <input placeholder='1' autofocus />
        else if 2
          <input placeholder='2' />
        else if 3
          <input placeholder='3' />
        }
      </div>
