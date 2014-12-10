define [
  'react'
  'saveTheDate/lib/env'
  'saveTheDate/mixins/queryparams'
  'saveTheDate/mixins/listen'
  'saveTheDate/actions/formActions'
  'saveTheDate/actions/mapActions'
  'saveTheDate/actions/alertActions'
  'saveTheDate/stores/formStore'
  'saveTheDate/elements/input'
  'saveTheDate/elements/button'
  'saveTheDate/elements/googleMaps'
  'saveTheDate/elements/thankYou'
], (
  React
  Env
  QueryMixin
  ListenMixin
  FormActions
  MapActions
  AlertActions
  FormStore
  InputElement
  ButtonElement
  MapElement
  ThankYouElement
) ->

  BASE_URL = if Env.isLocal('saveTheDate')
  then 'localhost:8000'
  else ''

  WHEELSCROLL = 'mousewheel DOMMouseScroll'

  FormElement = React.createClass

    mixins: [ListenMixin, QueryMixin]

    getInitialState: ->
      saved: false
      address: 'Rancho Valencia, San Diego, CA'
      prefilled:
        name: ''
        email: ''
        address: ''

    componentWillMount: ->
      @setupFunctions()
      @listenTo(FormStore)
      $(window).on WHEELSCROLL, @_debouncedCancelScroll

      queries = @parseQueryParams(['name', 'email', 'address'])
      unless _.isEmpty queries
        prefilled = _.extend @state.prefilled, queries
        @setState { prefilled }

    setupFunctions: ->
      @_updateMap = MapActions.updateMap
      @_debouncedUpdateMap = _.debounce MapActions.updateMap, 500
      @_debouncedCancelScroll = _.debounce @cancelScroll, 200,
        leading: true
        trailing: false

    componentWillUnmount: ->
      @stopListening(FormStore)
      $(window).off WHEELSCROLL, @_debouncedCancelScroll

    onStoreChange: ->
      { saved } = @state
      contact = FormStore.get('contact')
      if FormStore.get('valid') and not saved
        @saveContact(contact)
      else
        @_scrolling = requestAnimationFrame @scrollUpToForm
        unless saved
          setTimeout ->
            AlertActions.alert("Please review the highlighted fields.")
          , 0

    scrollUpToForm: ->
      current = $(window).scrollTop()
      destination = $('#contacts-form').get(0)?.offsetTop - 80

      return unless destination

      if current > destination
        interval = Math.max(1, Math.floor((current - destination) / 10))
        $(window).scrollTop(current - interval)
        @_scrolling = requestAnimationFrame @scrollUpToForm

    cancelScroll: (e) ->
      if @_scrolling
        cancelAnimationFrame(@_scrolling)
        @_scrolling = null

    saveContact: (contact) ->
      $.post "http://#{BASE_URL}/contact", contact, ({status, message}) =>
        if status is 200
          @setState(saved: true)
          FormActions.complete()
        else
          AlertActions.alert(message)

    updateMap: (e) ->
      { keyCode, currentTarget: { value } } = e
      _value = value.trim()

      if _value isnt @state.address
        if keyCode? and keyCode isnt 13
          @_debouncedUpdateMap(_value)
        else
          @_updateMap(_value)
        @setState(address: _value)

    render: ->
      { name, email, address } = @state.prefilled
      <form id='contacts-form'>
        <div>
          <InputElement name='name' value={name} />
          <InputElement name='email' value={email} />
          <InputElement name='address' value={address}
                        placeholder='mailing address'
                        onBlur={@updateMap}
                        onKeyUp={@updateMap}
          />
          <MapElement />
          <ButtonElement text={'Submit'}/>
        </div>
      </form>
