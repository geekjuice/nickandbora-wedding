define [
  'zepto'
  'react'
  'homepage/elements/navbar'
  'homepage/elements/footer'
], ($, React, NavBarElement, FooterElement) ->

  DetailsApp = React.createClass

    render: ->
      <div className='NickAndBora-details'>
        <NavBarElement onNavChange={@onNavChange} />
        <span>Wedding Details</span>
        <FooterElement />
      </div>

