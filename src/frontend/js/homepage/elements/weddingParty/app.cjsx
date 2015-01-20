define [
  'zepto'
  'react'
  'homepage/elements/navbar'
  'homepage/elements/footer'
], ($, React, NavBarElement, FooterElement) ->

  WeddingPartyApp = React.createClass

    render: ->
      <div className='NickAndBora-weddingParty'>
        <NavBarElement onNavChange={@onNavChange} />
        <span>WeddingParty</span>
        <FooterElement />
      </div>

