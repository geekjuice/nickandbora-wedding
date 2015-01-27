define [
  'zepto'
  'react'
  'imagesloaded'
  'homepage/elements/navbar'
  'homepage/elements/footer'
], ($, React, Imagesloaded, NavBarElement, FooterElement) ->

  S3_URL = 'http://nickandbora.s3.amazonaws.com'

  ProposalApp = React.createClass

    getInitialState: ->
      modalOpen: false
      image: null
      orientation: 'portrait'

    openModal: (image) ->
      (e) =>
        e.preventDefault()
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

      <div className='NickAndBora-proposal'>
        <NavBarElement onNavChange={@onNavChange} />
        <h1>Proposal</h1>

        <div className="image-modal-container #{if modalOpen then 'image-modal-open' else ''}">
          <div className='image-modal-overlay' />
          <div className="image-modal #{orientation}" onClick={@closeModal}>
            {if image
              <img src={image} />
            }
          </div>
          <span className='image-modal-close icono-cross' onClick={@closeModal}/>
        </div>

        <div className='hero' />

        <section>
          <h3>When?</h3>
          <p>July 11, 2013<sup>1</sup></p>
        </section>

        <section>
          <h3>Where?</h3>
          <p>Boston Public Garden</p>
        </section>

        <section>
          <h3>How?</h3>
          <p>
            Around this time, I was taking care of my family's dog, <span className='link' onClick={@openModal('http://nickandbora.s3.amazonaws.com/proposal/minky.jpeg')}>Minky</span>, and decided to use her as an excuse to take Bora to Boston Public Gardens. Now my planning to go somewhere other than my couch is already out of the norm, so for days priors, I would casually mention that we should take Minky to a park so she can run around and that we could grab brunch while we're out.
          </p>

          <p>
            So on <em>July 11, 2013</em>, we take Minky and head out towards Back Bay where I suggest that we eat at <a href='http://parishcafe.com/' target='_blank'>Parish Cafe</a> which was a block away from the gardens. Afterwards, we entered the gardens where we just strolled around for about 15 minutes until I found a quiet area to pop the question. To be honest, I can't remember what I said exactly, but it was along the lines of how I had prepared a late anniversary gift for her (our anniversary was only a month prior).
          </p>

          <div className='split'>
            <div className='right text-container'>
              <p>
                After preparing myself mentally, I presented her with a small bucket(?) that contained the ring. I had prepared the bucket(?) so that the ring was attached to the lid via a thread. As she took off the lid, the ring would appear and hang there. It sort of worked...better in theory... Anyway, once she started connecting the dots, I took her hand, got on my knee, and asked if she was willing to start a new chapter of life with me.
              </p>
              <p>
                Her response? <q>"Okay"</q><sup>2</sup>.
              </p>
            </div>
            <div className='left img-container'>
              <img src='http://nickandbora.s3.amazonaws.com/proposal/propose.jpg' onClick={@openModal('http://nickandbora.s3.amazonaws.com/proposal/propose.jpg')} />
            </div>
          </div>


          <div className='split'>
            <div className='left text-container'>
              <p>So after we finally calmed down a little, we started leaving the gardens. A random high school student asked if he is able to shoot a photo of us as an assignment and Bora was excited to jump the gun and say <q>"We just got engaged! Can you email us this photo?"</q> The picture we got was the both of us looking down and only Minky posing properly for the camera. I couldn't help but to notice that she was little disappointed that there was no one to capture the moment of the proposal.</p>
              <p>So she thought...</p>
            </div>
            <div className='right img-container'>
              <img src='http://nickandbora.s3.amazonaws.com/proposal/only.jpg' onClick={@openModal('http://nickandbora.s3.amazonaws.com/proposal/only.jpg')} />
            </div>
          </div>
        </section>

        <section>
          <h3>Huh?</h3>
          <p>
            As you can tell from the images above, there clearly was someone taking picutres of us that day. What she didn't know was that I hired a photographer weeks in advance to capture the moment without her knowledge. From the path we strolled around at the garden to the spot where I proposed to even purposely upsetting her a little by not documenting the moment, it was all planned out to some degree.
          </p>

          <p>
            So imagine her reaction when two months later she receives a package containing the image above framed along with photos of us strolling through the park, the moment when I asked, and even our asking a stranger to take our photo.
          </p>

          <p>
            She was pretty happy. <span className='icono-smile' />
          </p>

          <hr />
          <div className='annotations'>
            <ol>
              <li>1. Nerd Note: The date is three consecutive primes. 7/11/13</li>
              <li>2. She actually said this in a very excited tone.</li>
            </ol>
          </div>
        </section>

        <FooterElement />
      </div>

