define [
  'zepto'
  'react'
  'homepage/elements/navbar'
], ($, React, NavBarElement) ->

  DetailsApp = React.createClass

    render: ->
      <div className='NickAndBora-details'>
        <NavBarElement onNavChange={@onNavChange} />
        <span>Wedding Details</span>
      </div>

