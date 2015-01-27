define [
  'react'
  'lib/enviro'
  'homepage/elements/banner'
  'homepage/elements/bio'
], (
  React
  Enviro
  BannerElement
  BioElement
) ->

  KEY = 'NickAndBora-Env'

  HomepageApp = React.createClass

    showRsvp: (e) ->
      console.log 'rsvp'

    render: ->
      rsvpClasses = React.addons.classSet
        'rsvp-container': true
        '__hidden': Enviro.isProd(KEY)

      <div className='NickAndBora-homepage'>
        <div className={rsvpClasses} onClick={@showRsvp}>
          <span className='rsvp-icon icono-pin' />
          <span className='rsvp-text'>RSVP</span>
        </div>
        <BannerElement />
        <BioElement who='nick' />
        <BioElement who='bora' />
      </div>
