define [
  'zepto'
  'react'
  'masonry'
  'homepage/elements/navbar'
  'homepage/elements/footer'
], ($, React, Masonry, NavBarElement, FooterElement) ->

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
      numberOfImages: 5
      increment: 5
      navOpen: false

    showMore: ->
      { numberOfImages, increment } = @state
      @setState { numberOfImages: numberOfImages + increment }

    onNavChange: (navOpen) ->
      @setState { navOpen }

    componentDidMount: ->
      @masonrize()

    componentDidUpdate: ->
      @masonrize()

    masonrize: ->
      new Masonry '.gallery',
        columnWidth: '.image'
        itemSelector: '.image'

    render: ->
      { numberOfImages, navOpen } = @state

      <div className='NickAndBora-gallery'>
        <NavBarElement onNavChange={@onNavChange} />
        <div className="gallery #{if navOpen then 'nav-visible' else ''}">
          {for image, i in IMAGES.engagement[0...numberOfImages]
            <div key={"engagement-#{i}"} className='image'>
              <div className='polaroid'>
                <img src="http://nickandbora.s3.amazonaws.com/engagement/#{image}" />
              </div>
            </div>
          }
        </div>
        {if numberOfImages < IMAGES.engagement.length
          <div className='showMore'>
            <a href='gallery' onClick={@showMore}>Show me more</a>
          </div>
        }
        <FooterElement />
      </div>
