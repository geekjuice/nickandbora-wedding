define [
  'react'
  'saveTheDate/mixins/listen'
  'saveTheDate/stores/formStore'
], (React, ListenMixin, FormStore) ->

  WelcomeElement = React.createClass

    mixins: [ListenMixin]

    getDefaultProps: ->
      name: ''
      date: '3/28/15'

    getInitialState: ->
      completed: true

    onStoreChange: ->
      { completed } = @state
      completed = FormStore.get('completed') ? completed
      @setState { completed }

    componentWillMount: ->
      @listenTo(FormStore)

    componentWillUnmount: ->
      @stopListening(FormStore)


    render: ->
      { name, date } = @props
      <p className="welcome-message">
        Welcome{if name then " #{name}" else ''}, you are cordially invited to the wedding of Nick & Bora on {date}. To ensure we can keep you up-to-date, please provide your contact information below.
      </p>
