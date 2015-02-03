# This is some Cthulhu-ass, anti-pattern React code...

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

  descriptions =
    beef: 'Braised Beef Short Rib'
    fish: 'Sautéed Wild Sea Bass'
    veggie: 'Chef\'s choice vegetarian dish'

  FormElement = React.createClass

    mixins: [QueryMixin, React.addons.LinkedStateMixin]

    attendingOptions: ['yes', 'no']

    foodOptions: ['beef', 'fish', 'veggie']

    getDefaultProps: ->
      onFinish: _.noop

    getInitialState: ->
      loading: true
      saved: false
      prefilled:
        _id: ''
        name: ''
        email: ''
        attending: ''
        food: 'beef'
        music: ''

    componentWillMount: ->
      @_debouncedSave = _.debounce @saveRsvp, 2000, {leading: true}
      params = _.keys(@state.prefilled)
      queries = @parseQueryParams(params)
      unless _.isEmpty queries
        prefilled = _.extend @state.prefilled, queries
        @setState { prefilled }

    componentDidMount: ->
      Delay.run(1200, @revealForm)

    revealForm: ->
      @setState { loading: false }

    chooseFood: (e) ->
      food = $(e.currentTarget).data('food')
      prefilled = _.extend {}, @state.prefilled, { food }
      @setState { prefilled }

    chooseAttending: (e) ->
      attending = $(e.currentTarget).data('attending')
      prefilled = _.extend {}, @state.prefilled, { attending }
      @setState { prefilled }

    submit: (e) ->
      e.preventDefault()
      { saved } = @state
      form = @getFormValues()
      { rsvp, valid, errors, fields } = Rsvp.validate(form)
      if valid and not saved
        @_debouncedSave(rsvp)
      else
        for field in fields
          $("[name=#{field}]").parent().addClass('invalid')
        $('.alert').addClass('visible')
        @setState { errorMessage: 'Please review the highlighted fields' }
        Delay.run(5000, -> $('.alert').removeClass('visible'))

    getFormValues: ->
      { prefilled: { food, attending } } = @state
      food = if attending is 'yes' then food else 'noop'
      form = $('#rsvpForm').serializeArray()
      form = form.concat [
        { name: 'food', value: food }
        { name: 'attending', value: attending }
      ]
      return form

    saveRsvp: (rsvp) ->
      $.post "/api/rsvp", rsvp, ({status, message}) =>
        if status is 200
          @setState(saved: true)
          $('#rsvpForm').addClass('loading')
          @props.onFinish(rsvp)
        else
          $('.alert').addClass('visible')
          @setState { errorMessage: "(╯°□°）╯︵ ┻━┻     Err.. let Nick know and he'll fix it..." }
          Delay.run(5000, -> $('.alert').removeClass('visible'))

    render: ->
      { loading, errorMessage } = @state
      { _id, name, email, attending, food, music } = @state.prefilled

      formClasses = React.addons.classSet
        'loading': loading

      <form id='rsvpForm' className={formClasses}>
        <div className='alert'>
          <div className='alert-message'>{errorMessage}</div>
        </div>

        <header>RSVP</header>
        <input type='hidden' name='_id' value={_id}/>

        <div className='split'>
          <h3>attending?</h3>
          {for option in ['yes', 'no']
            <div className="half attending #{if option is attending then 'active' else ''}"
                 key={option} onClick={@chooseAttending} data-attending={option}>
              <div>
                <img src="/img/rsvp/#{option}.png" className='overlap'/>
                <img src="/img/rsvp/#{option}-active.png" />
              </div>
              <div className="attending-text #{option}-text">
                {if option is 'yes' then 'Yes!' else 'Regretfully decline...'}
              </div>
            </div>
          }
        </div>

        {if attending
          <div>
            <InputElement ref='1' name='name' value={name} />
            <InputElement ref='2' name='email' value={email} />
          </div>
        }

        {if attending is 'yes'
          <div>
            <div className='split'>
              <h3>food?</h3>
              {for option in ['beef', 'fish', 'veggie']
                <div className="third food #{if option is food then 'active' else ''}"
                    key={option} onClick={@chooseFood} data-food={option}>
                  <div>
                    <img src="/img/rsvp/#{option}.png" className='overlap'/>
                    <img src="/img/rsvp/#{option}-green.png" />
                  </div>
                  <div className='food-text'>{_.capitalize option}</div>
                  <div className='food-description'>{descriptions[option]}</div>
                </div>
              }
            </div>
            <InputElement ref='5' name='music' value={music} label="song requests" optional={true} />

            <div className='psa'>
              Friendly reminder that we need an RSVP filled out for <em>each person</em> who is attending. That way, we can provide you each with the correct food option and so we obtain an accurate headcount as space and attendance is limited.
            </div>
          </div>
        }

        {if attending
          <ButtonElement text='Submit' onClick={@submit}/>
        }
        <footer>
          Made with &hearts; by Nick & Bora
        </footer>
      </form>
