define [
  'zepto'
  'react'
  'homepage/elements/navbar'
  'homepage/elements/footer'
  'homepage/elements/map'
], ($, React, NavBarElement, FooterElement, MapElement) ->

  MORGAN_RUN_RESORT = '5690 Cancha De Golf, Rancho Santa Fe, CA'

  TravelApp = React.createClass

    render: ->
      <div className='NickAndBora-travel'>
        <NavBarElement onNavChange={@onNavChange} />
        <h1>Travel</h1>
        <MapElement address={MORGAN_RUN_RESORT} />
        <FooterElement />
      </div>
