define [
  'zepto'
  'react'
  'homepage/elements/navbar'
  'homepage/elements/footer'
], ($, React, NavBarElement, FooterElement) ->

  TravelApp = React.createClass

    render: ->
      <div className='NickAndBora-travel'>
        <NavBarElement onNavChange={@onNavChange} />
        <span>Travel</span>
        <FooterElement />
      </div>
