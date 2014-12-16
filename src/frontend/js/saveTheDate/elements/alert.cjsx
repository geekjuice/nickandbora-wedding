define [
  'react'
  'saveTheDate/mixins/listen'
  'saveTheDate/stores/alertStore'
], (React, ListenMixin, AlertStore) ->

  DURATION = 5000

  AlertElement = React.createClass

    mixins: [ListenMixin]

    getInitialState: ->
      visible: false
      message: ""

    componentWillMount: ->
      @listenTo(AlertStore)

    componentWillUnmount: ->
      @stopListening(AlertStore)

    onStoreChange: ->
      @handleVisibility()

      @setState
        visible: true
        message: AlertStore.get("message")

    handleVisibility: ->
      if @_transitionId
        clearTimeout(@_transitionId)
        @_transitionId = null

      @_transitionId = setTimeout =>
        @setState({visible: true})
      , DURATION

    render: ->
      { visible, message } = @state

      classes = React.addons.classSet
        'alert-container': true
        'alert-visible': visible

      <div className={classes}>
        <div className='alert'>{ message }</div>
      </div>

