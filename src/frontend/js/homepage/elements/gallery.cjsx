define [
  'zepto'
  'react'
  'masonry'
  'imagesloaded'
  'homepage/elements/navbar'
  'homepage/elements/footer'
], ($, React, Masonry, Imagesloaded, NavBarElement, FooterElement) ->

  S3_URL = 'http://nickandbora.s3.amazonaws.com'

  NUM_OF_IMAGES = 37

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
      loaded = new Imagesloaded('.gallery')

      loaded.on 'progress', (instance, img) ->
        $(img.img).parents('.image.loading').removeClass('loading')

      loaded.on 'always', =>
        new Masonry '.gallery',
          columnWidth: '.image'
          itemSelector: '.image'
          isAnimated: true
        $('.showMore').removeClass('loading')

    showMore: ->
      $('.showMore').addClass('loading')
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

        <h1>Gallery</h1>

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
          {for i in [0...Math.min(numberOfImages, NUM_OF_IMAGES)]
            <div key={"engagement-#{i}"} className='image loading' onClick={@openModal("img#{i}.jpg")}>
              <div className='polaroid'>
                <img data-engagement={"img#{i}.jpg"} src="#{S3_URL}/engagement/img#{i}.jpg" />
              </div>
            </div>
          }
        </div>
        {if numberOfImages < NUM_OF_IMAGES
          <div className='showMore'>
            <a href='gallery' onClick={@showMore}>Show me more</a>
          </div>
        }
        <FooterElement />
      </div>
