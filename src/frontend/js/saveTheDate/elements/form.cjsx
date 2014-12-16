define [
  'react'
  'saveTheDate/mixins/queryparams'
  'saveTheDate/mixins/listen'
  'saveTheDate/actions/formActions'
  'saveTheDate/actions/mapActions'
  'saveTheDate/actions/alertActions'
  'saveTheDate/stores/formStore'
  'saveTheDate/elements/input'
  'saveTheDate/elements/hiddenInput'
  'saveTheDate/elements/button'
  'saveTheDate/elements/googleMaps'
  'saveTheDate/elements/thankYou'
], (
  React
  QueryMixin
  ListenMixin
  FormActions
  MapActions
  AlertActions
  FormStore
  InputElement
  HiddenInputElement
  ButtonElement
  MapElement
  ThankYouElement
) ->

  WHEELSCROLL = 'mousewheel DOMMouseScroll'

  FormElement = React.createClass

    mixins: [ListenMixin, QueryMixin]

    getInitialState: ->
      saved: false
      address: 'Rancho Valencia, San Diego, CA'
      prefilled:
        _id: ''
        name: ''
        email: ''
        address: ''

    componentWillMount: ->
      @setupFunctions()
      @listenTo(FormStore)
      $(window).on WHEELSCROLL, @_debouncedCancelScroll

      queries = @parseQueryParams(['_id', 'name', 'email', 'address'])
      unless _.isEmpty queries
        prefilled = _.extend @state.prefilled, queries
        @setState { prefilled }

    setupFunctions: ->
      @_updateMap = MapActions.updateMap
      @_onceSaveContact = _.once @saveContact
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
        @_onceSaveContact(contact)
      else
        @_scrolling = requestAnimationFrame @scrollToForm
        unless saved
          setTimeout ->
            AlertActions.alert("Please review the highlighted fields.")
          , 0

    scrollToForm: ->
      current = $(window).scrollTop()
      destination = $('#contacts-form').get(0)?.offsetTop - 80

      return unless destination

      diff = current - destination
      direction = if diff < 0 then 1 else -1
      unless Math.abs(diff) < 5
        interval = Math.max(1, Math.floor(Math.abs(diff) / 10))
        $(window).scrollTop(current + (interval * direction))
        @_scrolling = requestAnimationFrame @scrollToForm

    cancelScroll: (e) ->
      if @_scrolling
        cancelAnimationFrame(@_scrolling)
        @_scrolling = null

    saveContact: (contact) ->
      $.post "api/contact", contact, ({status, message}) =>
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
      { _id, name, email, address } = @state.prefilled
      <form id='contacts-form'>
        <div>
          <HiddenInputElement name='_id' value={_id} />
          <InputElement name='name' value={name} autoFocus={true} />
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
