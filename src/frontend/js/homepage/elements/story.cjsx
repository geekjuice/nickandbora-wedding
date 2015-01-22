define [
  'zepto'
  'react'
  'homepage/elements/navbar'
  'homepage/elements/footer'
], ($, React, NavBarElement, FooterElement) ->

  StoryApp = React.createClass

    render: ->
      <div className='NickAndBora-story'>
        <NavBarElement onNavChange={@onNavChange} />
        <h1>Story</h1>
        <FooterElement />
      </div>

