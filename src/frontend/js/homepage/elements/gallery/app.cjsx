define [
  'zepto'
  'react'
  'homepage/elements/navbar'
], ($, React, NavBarElement) ->

  IMAGES =
    engagement: [
      'img0.jpg'
      'img1.jpg'
      'img2.jpg'
      'img3.jpg'
      'img4.jpg'
      'img5.jpg'
      'img6.jpg'
      'img7.jpg'
      'img8.jpg'
    ]

  GalleryApp = React.createClass

    getInitialState: ->
      numberOfImages: 8
      increment: 8
      navOpen: false

    componentWillMount: ->
      $('html, body').css('height', '100%')
      $('#NickAndBora').addClass('NickAndBora-gallery')

    componentDidUnmount: ->
      $('html, body').css('height', '')
      $('#NickAndBora').removeClass('NickAndBora-gallery')

    showMore: ->
      { numberOfImages, increment } = @state
      @setState { numberOfImages: numberOfImages + increment }

    onNavChange: (navOpen) ->
      @setState { navOpen }

    render: ->
      { numberOfImages, navOpen } = @state

      <div className='gallery-container horizontal'>
        <NavBarElement onNavChange={@onNavChange} />
        <div className="gallery #{if navOpen then 'nav-visible' else ''}">
          {for image, i in IMAGES.engagement[0...numberOfImages]
            <div key={"engagement-#{i}"} className='image'>
              <div className='polaroid'>
                <img src="http://nickandbora.s3.amazonaws.com/engagement/#{image}" />
              </div>
            </div>
          }
          {if numberOfImages < IMAGES.engagement.length
            <div className='showMore'>
              <div className='showMore-link'>
                <a href='gallery' onClick={@showMore}>Show me more ↠</a>
              </div>
            </div>
          }
        </div>
      </div>
