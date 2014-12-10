define [
  'zepto'
  'react'
  'saveTheDate/stores/formStore'
], ($, React, FormStore) ->

  titleize = (str) ->
    _.map(str.split(/\s+/), (part) ->
      part[0].toUpperCase() + part[1...]
    ).join(' ')

  ThankYouElement = React.createClass

    componentDidEnter: ->
      setTimeout ->
        $('#thank-you').css('display', 'table')
        setTimeout ->
          $('#thank-you').addClass('thank-you-visible')
        , 0
      , 1000

    componentWillEnter: (cb) ->
      cb()

    render: ->
      { name, email, address } = FormStore.get('contact')

      <div id={@props.id} className="thank-you-container">
        <div className="thank-you-content">
          <p>Thank you <strong>{titleize name}</strong>, we'll keep you posted on our journey. We sent a confirmation email to <strong>{email}</strong> in case you need to edit your information and also for your records.</p>
          <div>
            <a href="http://NickAndBora.life">Nick & Bora - Life</a>
          </div>
        </div>
      </div>

