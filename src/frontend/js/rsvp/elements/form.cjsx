define [
  'lodash'
  'zepto'
  'react'
  'rsvp/lib/delay'
  'rsvp/elements/input'
  'rsvp/elements/radio'
  'rsvp/elements/button'
], (
  _
  $
  React
  Delay
  InputElement
  RadioElement
  ButtonElement
) ->

  FormElement = React.createClass

    attendingOptions: ['yes', 'no']

    foodOptions: ['beef', 'fish', 'veggie']

    getInitialState: ->
      loading: true

    componentDidMount: ->
      Delay.run(1200, @revealForm)

    revealForm: ->
      @setState { loading: false }
      Delay.run(600, @focusInput)

    focusInput: ->
      $(@refs["1"].getDOMNode()).find('input').focus()

    submit: (e) ->
      debugger

    render: ->
      { loading } = @state

      formClasses = React.addons.classSet
        'loading': loading

      <form id='rsvpForm' className={formClasses}>
        <header>RSVP</header>
        <InputElement ref='1' name='name' />
        <InputElement ref='2' name='email' />

        <div className='split'>
          <div className='half'>
            <RadioElement ref='3'
                          name='attending'
                          options={@attendingOptions}
                          />
          </div>
          <div className='half'>
            <RadioElement ref='4'
                          name='food'
                          options={@foodOptions}
                          />
          </div>
        </div>

        <InputElement ref='5' name='music' />
        <ButtonElement text='Submit' onClick={@submit}/>

      </form>
