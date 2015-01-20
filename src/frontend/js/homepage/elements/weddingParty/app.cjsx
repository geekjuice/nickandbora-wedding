define [
  'zepto'
  'react'
  'homepage/elements/navbar'
], ($, React, NavBarElement) ->

  WeddingPartyApp = React.createClass

    render: ->
      <div className='NickAndBora-weddingParty'>
        <NavBarElement onNavChange={@onNavChange} />
        <span>WeddingParty</span>
      </div>

