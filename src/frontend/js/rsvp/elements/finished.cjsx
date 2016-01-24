define [
  'zepto'
  'react'
  'rsvp/lib/delay'
], (
  $
  React
  Delay
) ->

  FinishedElement = React.createClass

    componentDidMount: ->
      Delay.nextTick =>
        $(@getDOMNode()).find('.loading').removeClass('loading')

    render: ->
      <div id='rsvpFinished'>
        <div className='message-container loading'>
        {if @props.attending is 'yes'
          <div>
            <img src='/img/rsvp/yes-active.png' />
            <div className='message'>Awesome! We're honored to celebrate (and party) with you on our special day! Don't forget to visit <a href='http://NickAndBora.Life'>NickAndBora.Life</a> if you have any questions regarding travel, accomodations, and the wedding day. Also (another) friendly reminder that an RSVP needs to be filled out for each people (and child) so we know exactly which food option to provide and so we have an accurate head count. Other than that, you can email us directly at <a href='mailto:nickandbora@gmail.com?subject=%5BNick%20%26%20Bora%5D%20Hey!%20Listen!' target='_top'>NickAndBora@gmail.com</a> if you have any other questions and concerns. Can't wait to see you on March 28!</div>
          </div>

        else
          <div>
            <img src='/img/rsvp/no-active.png' />
            <div className='message'>That's unfortunate to hear. However, we understand that you have own schedules to attend and cant force you to come. However, if you are able to attend later, make sure to update your RSVP as soon as possible (before March 1) so we can accomodate you back in. Feel free to contact us directly at <a href='mailto:nickandbora@gmail.com?subject=%5BNick%20%26%20Bora%5D%20Hey!%20Listen!' target='_top'>NickAndBora@gmail.com</a> if you have any other concerns or questions.
            </div>
          </div>
        }
          <div className='message disclaimer'>
            Disclaimer: Updated for demonstration and portfolio purposes.
          </div>
        </div>
      </div>
