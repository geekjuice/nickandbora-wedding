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

    render: ->
      rsvpClasses = React.addons.classSet
        'rsvp-container': true
        '__hidden': Enviro.isProd(KEY)

      <div className='NickAndBora-homepage'>
        <a className={rsvpClasses} href='/rsvp'>
          <span className='rsvp-icon icono-pin' />
          <span className='rsvp-text'>RSVP</span>
        </a>
        <BannerElement />
        <BioElement who='nick' />
        <BioElement who='bora' />
      </div>
