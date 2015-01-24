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

          <p className='interviewer'>How did it all begin?</p>

          <p className='bora'>It all started in <a href='http://www.tphs.net/' target='_blank'>Del Mar</a>. It was time before Facetime, text messages, and note passing was still a real thing. One day I got a note from my friend, Angie, saying that there was a new Korean joining her her class. Angie and I were really silly back then, so we decided to chase this guy and ask him bunch of questions to make him <span className='link' onClick={@openModal('http://media1.giphy.com/media/mh90WH2cCgmOI/200_s.gif')}>uncomfortable</span>.</p>

          <p className='nick'>It was pretty terrifying at first. On the one hand, I was new so making friends was one of the top priorities. On the other hand... <span className='link' onClick={@openModal('http://boiseclassicmovies.com/wp-content/themes/prime-theme/gbs-addons/advanced-thumbnail/timthumb.php?src=http://boiseclassicmovies.com/wp-content/uploads/2013/09/shining-twins.png&w=700&h=400&zc=1&s=0&a=0&q=89&cc=0000000')}>'ahem'</span>. Don't get me wrong. They were seemed genuinely nice, but my being an introvert meant that kind of attention was daunting.</p>

          <p className='interviewer'>So how did you get closer?</p>

          <div className='split'>
            <div className='text-container right'>
              <p className='bora'>
                I followed his Xanga and I borrowed his <span className='link' onClick={@openModal('http://images.usatoday.com/money/_photos/2003/09-25-dell-jukebox.jpg')}>Dell MP3</span> to listen to his music during class, but it was more of a friend thing. Again it was a gradual experience – we passed notes in class often joking about how we’d take over the world. This continued and eventually the two of us just naturally became closer and closer. Soon I even found myself waiting for him after class and him waiting for me. I even asked my parents to take me to <a href='http://sdkendo.blogspot.com/p/join.html' target='_blank'>Kendo</a> so we can spend our Saturdays together too!
              </p>
            </div>
            <div className='img-container left'>
              <img src='/img/story/world.png' onClick={@openModal('/img/story/world.png')}/>
            </div>
          </div>

          <p className='nick'>Not to say we didn't put in any effort to get closer, but at the time, we were just good friends. So it just made sense that we hung out all the time, shared the same groups of friends, and generally enjoy each other's company.</p>

          <p className='interviewer'>Was there a moment that you realized he/she was a good for you?</p>

          <p className='bora'><em>HAHAHA YES!</em> He helped me in chemistry and math. I remember he was very patient and even drew photos on the computer to help me understand it. There I thought, <q>"Here's a geeky (which was even less cool back then...) guy who is kind of awesome!"</q>. After a while, his friends became my friends and we had some adventures together. And by adventures, I mean going to <a href='https://libraries.ucsd.edu/blogs/sshl/tag/clics/' target='_blank'>UCSD Library</a> to study. No joke...</p>

          <p className='nick'>It's actually a really nice library... Anyway, for me, I just started developing an affinity towards her. Maybe it's because I'm a fairly lowkey, monotononous, and stoic person, but I naturally gravitated towards her vibrant nature. Plus it helped she was <span className='link' onClick={@openModal('http://25.media.tumblr.com/69fb7353199af413a27dcbe9017ac585/tumblr_n1lszcqMjt1smcbm7o1_500.gif')}>pretty</span>.</p>

          <p className='interviewer'>How did you ask her out?</p>

          <p className='nick'>With a help of few friends, we gradually became closer. We actually didn’t ask each other. We just became close and mutually knew we're <span className='link' onClick={@openModal('http://cdn4.gurl.com/wp-content/uploads/2013/05/the-lion-king-gif.gif')}>in a relationship</span>.</p>

          <p className='bora'><em>Wait!</em> I actually asked him to the movies. I think it was a comedy. We paid for our own tickets and we got picked up separately afterwards. Does that count? I think the actual <em>moment</em> was the time after that when we went to eat <a href='http://doublehappiness-delmar.com' target='_blank'>chinese food</a>. He wasn’t hungry so I ordered two entries and ate it myself while he just sat there and watched.</p>

          <p className='nick'>I think I had <em>one</em> dumpling...</p>

          <p className='interviewer'>What about after high school?</p>

          <div className='split'>
            <div className='left text-container'>
              <p className='bora'>
                We decided in our senior year that even though we really liked each other, working towards our inidividual goals came first. We realized we were going our separate ways: Nick to <a href='http://www.columbia.edu' target='_blank'>New York</a> and myself to <a href='http://www.saic.edu/index.html' target='_blank'>Chicago</a>. Despite being far apart, it worked out because I had chances to visit New York often and see all the <a href='http://artforum.com/guide/country=US&place=New%20York&show=active&district=Chelsea' target='_blank'>galleries</a> and <a href='http://www.moma.org' target='_blank'>museums</a>.
              </p>
              <p className='nick'>
                It worked out for me as well since both Bora and Andy, my best man, were both in Chicago. Chicago itself though...it's just okay... I mean the food is amazing, but I always ended up visiting Chicago in the winter, so I only ever wanted to go out if it was to <span className='link' onClick={@openModal('http://static.fjcdn.com/gifs/Just+a+couple+long+cold+sad+months+just+exchange+there_cecb14_4191039.gif')}>eat</span>.
              </p>
            </div>
            <div className='img-container right'>
              <img src='/img/story/prom.png' onClick={@openModal('/img/story/prom.png')}/>
            </div>
          </div>

          <p className='interviewer'>Wasn't a long distance relationship difficult?</p>

          <p className='bora'>Definitely. However we tried to maintain contact everyday through all means of communinication. For example, I sent Nick many, many, <em>many</em> postcards. Haha I hope he wasn’t overwhelmed, but I really enjoyed process. It was kind of an analog movement. And because we couldn’t physically spend time together, I spent my time into an <a href='http://moca.org/pc/viewArtWork.php?id=30'>object</a> that I can send.</p>

          <p className='nick'>It was sweet. But yes, I had a <em>lot</em> of postcards from her in my dorm rooms. At one point, entire shelves were filled with cards and gifts from her. I was always a little self-conscious when people would visit since it could have been misunderstood as some creepy <span className='link' onClick={@openModal('http://3.bp.blogspot.com/-cp_RNeL7yLQ/T6mLHH2DprI/AAAAAAAADGE/Zx1KcMrnaTM/s640/tumblr_lp9r53xRwG1qiwmebo1_500.png')}>shrine</span> for her...</p>

          <div className='split'>
            <div className='text-container right'>
              <p className='bora'>
                Years later when I came to Boston, I actually found a whole box of the handmade postcards and gifts I’ve sent him throughout college. Everything was kept. That was very sweet.
              </p>
            </div>
            <div className='img-container left'>
              <img src='/img/story/note.png' onClick={@openModal('/img/story/note.png')}/>
            </div>
          </div>

          <p className='interviewer'>Where do you go from here?</p>

          <p className='nick'>Having gone through everything that we have together, it just clicked that Bora is who I was meant to be with. Obviously I don't know what lies ahead, but I can't imagine going forward without her now.</p>

          <p className='bora'>There were definitely tough times when we were apart, but we supported each other and I believe that is what allowed us to be where we are today. Now I am really happy to spend the rest of my life with this man. I can’t wait to grow old together and go through rest of our <span className='link' onClick={@openModal('http://25.media.tumblr.com/tumblr_mb6hnvqDB41qi23vmo1_500.gif')}>adventure</span>.</p>

        </section>

        <FooterElement />
      </div>

