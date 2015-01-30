define [
  'lodash'
  'zepto'
  'react'
  'model/rsvp'
  'rsvp/lib/delay'
  'rsvp/mixins/queryparams'
  'rsvp/elements/input'
  'rsvp/elements/radio'
  'rsvp/elements/button'
], (
  _
  $
  React
  Rsvp
  Delay
  QueryMixin
  InputElement
  RadioElement
  ButtonElement
) ->

  FormElement = React.createClass

    mixins: [QueryMixin]

    attendingOptions: ['yes', 'no']

    foodOptions: ['beef', 'fish', 'veggie']

    getInitialState: ->
      loading: true
      saved: false
      prefilled:
        _id: ''
        name: ''
        email: ''
        attending: ''
        food: ''
        music: ''

    componentWillMount: ->
      @_onceSaveRsvp = _.once @saveRsvp
      params = _.keys(@state.prefilled)
      queries = @parseQueryParams(params)
      unless _.isEmpty queries
        prefilled = _.extend @state.prefilled, queries
        @setState { prefilled }

    componentDidMount: ->
      Delay.run(1200, @revealForm)

    revealForm: ->
      @setState { loading: false }
      Delay.run(600, @focusInput)

    focusInput: ->
      $(@refs["1"].getDOMNode()).find('input').focus()

    submit: (e) ->
      e.preventDefault()
      { saved } = @state
      form = $('#rsvpForm').serializeArray()
      { rsvp, valid, errors, fields } = Rsvp.validate(form)
      if valid and not saved
        @_onceSaveRsvp(rsvp)
      else
        console.log 'nope'

    saveRsvp: (rsvp) ->
      $.post "/api/rsvp", rsvp, ({status, message}) =>
        if status is 200
          @setState(saved: true)
          # $('body').css('backgroundColor', '#333')
        else
          # $('body').css('backgroundColor', 'red')

    render: ->
      { loading } = @state
      { _id, name, email, attending, food, music } = @state.prefilled

      formClasses = React.addons.classSet
        'loading': loading

      <form id='rsvpForm' className={formClasses}>
        <header>RSVP</header>
        <input type='hidden' name='_id' value={_id} />

        <InputElement ref='1' name='name' value={name} />
        <InputElement ref='2' name='email' value={email} />

        <div className='split'>
          <div className='half'>
            <RadioElement ref='3'
                          name='attending'
                          options={@attendingOptions}
                          value={attending}
                          />
          </div>
          <div className='half'>
            <RadioElement ref='4'
                          name='food'
                          options={@foodOptions}
                          value={food}
                          />
          </div>
        </div>

        <InputElement ref='5' name='music' value={music} />
        <ButtonElement text='Submit' onClick={@submit}/>

      </form>
