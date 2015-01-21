define [
  'zepto'
  'react'
  'homepage/elements/navbar'
  'homepage/elements/footer'
  'homepage/elements/map'
], ($, React, NavBarElement, FooterElement, MapElement) ->

  DetailsApp = React.createClass

    render: ->
      <div className='NickAndBora-details'>
        <NavBarElement onNavChange={@onNavChange} />
        <h1>Wedding Details</h1>
        <MapElement />
        <FooterElement />
      </div>

