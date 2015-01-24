define [
  'zepto'
  'react'
  'imagesloaded'
  'homepage/elements/navbar'
  'homepage/elements/footer'
  'homepage/lib/partyBios'
], ($, React, Imagesloaded, NavBarElement, FooterElement, B) ->

  StoryApp = React.createClass

    getInitialState: ->
      modalOpen: false
      image: null
      orientation: 'portrait'

    openModal: (image) ->
      (e) =>
        $('html, body').addClass('no-scroll')
        @getOrientation image, (orientation) =>
          @setState { modalOpen: true, image, orientation }

    getOrientation: (image, cb) ->
      @getImageSize image, ([width, height]) ->
        cb(if height > width then 'portrait' else 'landscape')

    closeModal: ->
      $('html, body').removeClass('no-scroll')
      @setState { modalOpen: false }

    getImageSize: (image, cb) ->
      $tmp = $("<img src='#{image}' style='visibility: hidden;'/>")
      $('body').append($tmp)
      Imagesloaded $tmp, ->
        width = $tmp.width()
        height = $tmp.height()
        $tmp.remove()
        cb([width, height])

    render: ->
      { modalOpen, image, orientation } = @state

      <div className='NickAndBora-story'>
        <NavBarElement onNavChange={@onNavChange} />
        <h1>Story</h1>

        <div className="image-modal-container #{if modalOpen then 'image-modal-open' else ''}">
          <div className='image-modal-overlay' />
          <div className="image-modal #{orientation}" onClick={@closeModal}>
            {if image
              <img src={image} />
            }
          </div>
          <span className='image-modal-close icono-cross' onClick={@closeModal}/>
        </div>

        <section>
          <h3>It’s a long story folks...</h3>
          <p>{B.lorem}</p>
          <p onClick={@openModal('/img/story/note.png')}>
            Click for <em>image</em> and this is a <a href='#'>link</a>
          </p>

        </section>

        <FooterElement />
      </div>

