define [
  'react'
  'homepage/elements/banner'
  'homepage/elements/bio'
], (
  React
  BannerElement
  BioElement
) ->

  HomepageApp = React.createClass

    showRsvp: (e) ->
      console.log 'rsvp'

    render: ->
      <div className='NickAndBora-homepage'>
        <div className='rsvp-container' onClick={@showRsvp}>
          <span className='rsvp-icon icono-pin' />
          <span className='rsvp-text'>RSVP</span>
        </div>
        <BannerElement />
        <BioElement who='nick' />
        <BioElement who='bora' />
      </div>
