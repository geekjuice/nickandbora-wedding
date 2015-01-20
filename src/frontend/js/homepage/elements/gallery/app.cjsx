define [
  'zepto'
  'react'
  'masonry'
  'imagesloaded'
  'homepage/elements/navbar'
  'homepage/elements/footer'
], ($, React, Masonry, Imagesloaded, NavBarElement, FooterElement) ->

  S3_URL = 'http://nickandbora.s3.amazonaws.com'

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
      modalOpen: false
      image: null
      orientation: 'portrait'

    componentDidMount: ->
      @masonrize()

    componentDidUpdate: ->
      @masonrize()

    masonrize: ->
      masonry = new Masonry '.gallery',
        columnWidth: '.image'
        itemSelector: '.image'
      Imagesloaded '.gallery', ->
        masonry.layout()

    showMore: ->
      { numberOfImages, increment } = @state
      @setState { numberOfImages: numberOfImages + increment }

    onNavChange: (navOpen) ->
      @setState { navOpen }

    openModal: (image) ->
      (e) =>
        $('html, body').addClass('no-scroll')
        orientation = @getOrientation $(e.currentTarget).find('img')
        @setState { modalOpen: true, image, orientation }

    getOrientation: ($img) ->
      if $img.height() > $img.width() then 'portrait' else 'landscape'

    closeModal: ->
      $('html, body').removeClass('no-scroll')
      @setState { modalOpen: false }


    render: ->
      { numberOfImages, navOpen, modalOpen, image, orientation } = @state

      <div className='NickAndBora-gallery'>
        <NavBarElement onNavChange={@onNavChange} />

        <div className="image-modal-container #{if modalOpen then 'image-modal-open' else ''}">
          <div className='image-modal-overlay' />
          <div className="image-modal #{orientation}" onClick={@closeModal}>
            {if image
              <img src="#{S3_URL}/engagement/#{image}" />
            }
          </div>
          <span className='image-modal-close icono-cross' onClick={@closeModal}/>
        </div>

        <div className="gallery #{if navOpen then 'nav-visible' else ''}">
          {for image, i in IMAGES.engagement[0...numberOfImages]
            <div key={"engagement-#{i}"} className='image' onClick={@openModal(image)}>
              <div className='polaroid'>
                <img data-engagement={image} src="#{S3_URL}/engagement/#{image}" />
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
