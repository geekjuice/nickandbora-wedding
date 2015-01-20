define [
  'zepto'
  'react'
  'homepage/elements/navbar'
], ($, React, NavBarElement) ->

  TravelApp = React.createClass

    render: ->
      <div className='NickAndBora-travel'>
        <NavBarElement onNavChange={@onNavChange} />
        <span>Travel</span>
      </div>
