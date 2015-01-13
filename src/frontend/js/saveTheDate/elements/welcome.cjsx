define [
  'react'
  'saveTheDate/mixins/listen'
  'saveTheDate/stores/formStore'
], (React, ListenMixin, FormStore) ->

  WelcomeElement = React.createClass

    mixins: [ListenMixin]

    getDefaultProps: ->
      name: ''
      date: 'March 28, 2015'
      venue: 'Rancho Valencia'
      location: 'Rancho Santa Fe (San Diego), CA'

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
      { name, date, venue, location } = @props

      classes = React.addons.classSet
        'component': true
        'welcome-message': true

      <p className={classes}>
        Welcome{if name then " #{name}" else ''}, you are cordially invited to the wedding of <span className="keyword">Nick & Bora</span> on <span className="keyword">{date}</span> at the <span className="keyword">{venue}</span> of <span className='keyword'>{location}</span>. To ensure we can keep you up-to-date, please provide your contact information below.
      </p>
