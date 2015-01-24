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

        <section>
          <h3>It’s a long story folks...</h3>
          <p>Lorem</p>

          <div className='split'>
            <div className='left img-container'>
              <img src='/img/story/note.png' />
            </div>
            <p className='right'>
              Hello world
            </p>
          </div>

          <div className='split'>
            <div className='right third img-container'>
              <img src='/img/story/prom.png' />
            </div>
            <p className='left two-thirds'>
              Prom
            </p>
          </div>

        </section>

        <FooterElement />
      </div>

