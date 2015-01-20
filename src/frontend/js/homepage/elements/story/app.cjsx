define [
  'zepto'
  'react'
  'homepage/elements/navbar'
], ($, React, NavBarElement) ->

  StoryApp = React.createClass

    render: ->
      <div className='NickAndBora-story'>
        <NavBarElement onNavChange={@onNavChange} />
        <span>Story</span>
      </div>

