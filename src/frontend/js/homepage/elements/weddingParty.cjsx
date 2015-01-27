define [
  'zepto'
  'react'
  'velocity'
  'imagesloaded'
  'homepage/elements/navbar'
  'homepage/elements/footer'
  'homepage/lib/partyBios'
], ($, React, Velocity, Imagesloaded, NavBarElement, FooterElement, PARTY_BIOS) ->

  BRIDESMAIDS = 'bridesmaids'
  GROOMSMEN = 'groomsmen'

  S3 = (img) -> "http://nickandbora.s3.amazonaws.com/weddingParty/#{img}"

  WeddingPartyApp = React.createClass

    getInitialState: ->
      backToTopVisible: false
      modalOpen: false
      image: null
      orientation: 'portrait'

    componentDidMount: ->
      @_debouncedShowBackToTop = _.debounce @showBackToTop, 500
      $(window).on 'scroll', @_debouncedShowBackToTop

    componentWillUnmount: ->
      $(window).off 'scroll', @_debouncedShowBackToTop

    showBackToTop: ->
      partyMemberTop = $('.party-members').offset().top
      scrollTop = $('body').scrollTop()
      if partyMemberTop <= scrollTop
        @setState { backToTopVisible: true }
      else
        @setState { backToTopVisible: false }

    backToTop: ->
      [duration, easing, offset] = [1600, 'ease-in-out', 0]
      Velocity(document.body, 'scroll', { duration, easing, offset })

    goToMember: (key) ->
      (e) ->
        [duration, easing, offset] = [1600, 'ease-in-out', $("[data-member=#{key}]").offset().top]
        Velocity(document.body, 'scroll', { duration, easing, offset })

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
      { backToTopVisible, modalOpen, image, orientation } = @state

      backToTopClasses = React.addons.classSet
        'back-to-top': true
        'visible': backToTopVisible

      <section className='NickAndBora-weddingParty'>
        <NavBarElement onNavChange={@onNavChange} />

        <span className={backToTopClasses} onClick={@backToTop}>↟</span>

        <div className="image-modal-container #{if modalOpen then 'image-modal-open' else ''}">
          <div className='image-modal-overlay' />
          <div className="image-modal #{orientation}" onClick={@closeModal}>
            {if image
              <img src={image} />
            }
          </div>
          <span className='image-modal-close icono-cross' onClick={@closeModal}/>
        </div>

        <h1>Wedding Party</h1>

        <div className='container'>
          <section className='bride-and-groom'>
            <section className='party'>
              <div className='person'>
                <img src='/img/wedding-party/people/bora.png' />
              </div>
              <div className='members'>
                <div className='members-text' onClick={@goToMember(BRIDESMAIDS)}>
                  <img src='/img/wedding-party/bridesmaids-text.png' />
                </div>
                <ul>
                  {for key, person of PARTY_BIOS.bridalParty
                    <li key={key} onClick={@goToMember(key)} data-name={key}>
                      <span>{person.name}</span>
                    </li>
                  }
                </ul>
              </div>
            </section>

            <section className='party'>
              <div className='person'>
                <img src='/img/wedding-party/people/nick.png' />
              </div>
              <div className='members'>
                <div className='members-text' onClick={@goToMember(GROOMSMEN)}>
                  <img src='/img/wedding-party/groomsmen-text.png' />
                </div>
                <ul>
                  {for key, person of PARTY_BIOS.groomsmen
                    <li key={key} onClick={@goToMember(key)} data-name={key}>
                      <span>{person.name}</span>
                    </li>
                  }
                </ul>
              </div>
            </section>
          </section>

          <section className='party-members'>
            <img className='party-members-text'
                 src='/img/wedding-party/bridesmaids-text.png'
                 data-member={BRIDESMAIDS} />


            <div key='sora' className='party-member' data-member='sora'>
              <img src="/img/wedding-party/people/sora.png" />
              <h3>Sora Lee</h3>
              <p>
                Matron of Honor. And she deserves every title of that. The Matron part, the Honor part. She was there from the moment I was born and since then she was my point of direction and support. As a big sis, she always took care of me. Whatever she had she always shared. (Although when we were young, she would lick the chocolate part of the <span className='link' onClick={@openModal('http://www.tofucute.com/images/286_choco_boy_biscuits_bottom.jpg')}>choco mushroom cookie</span> and she would give me the cookie part and said that she was giving the best part way) She was my emotional support. She was there always to uplift and love. When things were tough, she took ownership and took care of us. She is the older sister everyone wants. And I am so lucky to have her. Now I am so happy for her wonderful life with an amazing husband and a beautiful son. I can’t wait to join her in the married life.
              </p>
            </div>

            <div key='julia' className='party-member' data-member='julia'>
              <img src="/img/wedding-party/people/julia.png" />
              <h3>Julia Park</h3>
              <p>
                What more can I say, she is the best. We didn’t get this way overnight though. We fought, we argued, we loved, we shared and I couldn’t be anywhere without this girl. We first met each other the first month Julia and their family moved to Temecula from Korea. We instantly got along and on our first day we went swimming (I still remember!) and since then we’ve always been together. Did I mention doing the most outrageous things like running around the dorm in chicken and dinosaur costume? Even after we moved apart in college, we always managed to keep each other <span className='link' onClick={@openModal(S3('julia1.jpg'))}>caught up</span>. She is one person that I can call any time, between any length of time, and continue our conversation without any hesitation. Overtime, her family became mine. I have two extra sisters (Ashley and Yunhee) and an awesome mom that makes the best homemade bossam as the world knows it. Also you can’t forget Toto, Julia’s mini schnauzer. I love this girl. All jokes aside, she is passionate, goal oriented and the smartest girl I know. She is honest and caring. I know I can trust this her opinions. In the beginning of my relationship with Nick, Julia was the first one to push me to ask him out. <q>"Why not! You like him. You ask him!"</q> Perhaps we wouldn’t be here on this day without her.
              </p>
            </div>

            <div key='claire' className='party-member' data-member='claire'>
              <img src="/img/wedding-party/people/claire.png" />
              <h3>Claire Park</h3>
              <p>
                <q>"Why is she here."</q> This refers to the moment I was introduced to Claire. Despite the fact I was a bitter bug then, she stuck around. I now know that I couldn’t have survived chicago without her. Claire went to school in Northwestern, 45 minutes away from downtown Chicago, yet we always found time to be with each other all the time. I love eating, napping, watching <span className="link" onClick={@openModal(S3('spongebob.png'))}>Spongebob</span> and it turns out she did so too. She was like me, but only more loving, kind, funny and more talented. We managed to have awesome <span className="link" onClick={@openModal(S3('claire1.jpg'))}>adventures</span> together. We would meet half way to go shopping, share our favorite meal places. Even just eating Chinese takeout in her apartment doing nails is a precious memory of mine. We shared dreams together about owning a duplex near Armitage where I would teach art downstairs and Claire would teach violin upstairs. Claire was always supportive in the craziest things I’ve done, and even performed for my <span className='link' onClick={@openModal(S3('claire2.jpg'))}>final art show</span> in Chicago. I know I can trust her about anything, because we prayed together, we cried together and we laughed together. She is wise and loving and I depend on her for many of my decision making. In some ways, Claire was just like Nick. She helped me understand him better by explaining things in his perspective. Looking back, I can’t help but to understand <q>"Why she was there."</q>
              </p>
            </div>

            <div key='heaven' className='party-member' data-member='heaven'>
              <img src="/img/wedding-party/people/heaven.png" />
              <h3>Heaven Lee</h3>
              <p>
                There is no other. I first met Heaven during a summer course in my last year of college. She had the corner studio, and I would peek into her studio to see what she was doing. It was a mess. I couldn’t tell which one was her work and which was trash (I really appreciated this part because I too, partake in this practice). Art was all over the ground, taped up, half hazardly hanging on the edge of the desk - and it was amazing. She was just my style. Striking a conversation with Heaven, we found out shared a mutual best friend. From then we had an instant connection. Often times we would sit in our studio and engage in deep conversation about art for hours. Heaven was passionate, knowledgeable, bright and most of all - energetic. We became close quickly and formed a <span className='link' onClick={@openModal(S3('heaven1.jpg'))}>group</span> with our mutual friends. Our group, practically knew each other’s schedules and met daily for lunch, met after afternoon course and ate dinner together at each other’s apartments. We took over part of the sullivan center where we held meeting for our own <span className='link' onClick={@openModal(S3('heaven2.jpg'))}>"artistic enrichment program"</span> (which included many chitchats and food). After Graduation, Heaven invited me to Italy, where in a moments notice I booked a flight and <span className='link' onClick={@openModal(S3('heaven3.jpg'))}>flew there</span> to reconnect. We promised each other that even when we go our separate ways we will strive to be successful and supportive of each other. For this I am thankful for Heaven and our group. I can’t wait to see what <span className='link' onClick={@openModal(S3('heaven4.jpg'))}>our futures</span> hold us.
              </p>
            </div>

            <div key='alice' className='party-member' data-member='alice'>
              <img src="/img/wedding-party/people/alice.png" />
              <h3>Alice Hwang</h3>
              <p>
                I’ve seen Alice since she was a shy little girl that walked to her elementary school from her house. Now I can’t believe she is all <span className='link' onClick={@openModal(S3('alice1.jpg'))}>grown up</span> doing her second year in college! In what it seems like few years flew by and she turned from a cute little girl into a beautiful smart independent woman. Looking at Alice, I couldn’t help to think that she was already my little sister - and now, she will be legally! We became family over period of time and even share our love for dessert and face masks. She is in some ways like Nick but with her own cute flair. I can’t help but love! Alice is like the little sister I never had, and I am so glad that with a union with Nick means union with a little sis!
              </p>
            </div>



            <img className='party-members-text'
                 src='/img/wedding-party/groomsmen-text.png'
                 data-member={GROOMSMEN} />

            <div key='andy' className='party-member' data-member='andy'>
              <img src="/img/wedding-party/people/andy.png" />
              <h3>Andrew Kim</h3>
              <p>
                I don't know why, but whenever I picture Andy, 4 out of 5 times this is face that I see him in. I've probably spent more time with Andy that anyone (even Bora...) throughout highschool. Looking back, it's almost absurd the amount of time we spent together. Whether it was working on some photo gallery project past midnight hopped up on caffeine, driving back-and-forth from San Diego to Fullerton to take SAT classes (during winter break might I add), or diligently going to the gym everyday after school, we were always doing them together and (generally) having a great time. Even after we went our separate ways for college, he kept me level-headed in my relationship with Bora by periodically checking in to make sure everything is fine. Whatever we may have been going through, he was always willing step in and help however he can. He's just that kind of guy; one that will drop whatever he's doing to help out. Without him, Nick and Bora may not have been and I'm honored to have him as my Best Man.
              </p>
            </div>

            <div key='dj' className='party-member' data-member='dj'>
              <img src="/img/wedding-party/people/dj.png" />
              <h3>Daniel Jae</h3>
              <p>
                Think Korean Terry Crews, just less buff. I'm sure if he's reading this he's making some comment out loud about how he's just as big (he's really not... but seriously who is). But jokes aside, this is a guy who can liven up any room with his energy. When I think about people I know with big personalities, DJ is the first person I think of. I've seen him pump up hundreds of people just by him being himself and it's amazing. Yet what's more amazing is his determination to never stay down. Watching how he deals with difficulties is motivating, even inspiring to the point where I find myself trying to live positively like he does. Not to mention the amount of love this guy has for others seems unending and it clearly shows when you are around him.
              </p>
            </div>

            <div key='hoyoung' className='party-member' data-member='hoyoung'>
              <img src="/img/wedding-party/people/hoyoung.png" />
              <h3>Hoyoung Chin</h3>
              <p>
                You know how there's always that one guy or girl that seems to know everyone, everywhere? Yea for me, that's Hoyoung. And I bet he knows that guy you're thinking of too. It's absurd how connected this guy knows. But then you meet Hoyoung, it makes sense why everyone wants to know him and become friends. For me, Hoyoung is also one of the goofiest people I know. This guy seems to have a joke (funny or not) ready whenever we meet up. Jokes ranging from punny to just politically incorrect. The last time he visited Boston, I was literally rolling on the floor lauging from his ridiculous antics. But outside all the humor, he never forget to take care of those near to him. Whether it's making sure no one feels left out or just making sure everyone is having a good time, he's constantly thinking of others before himself making it easy to see why people are so drawn to him.
              </p>
            </div>

            <div key='dave' className='party-member' data-member='dave'>
              <img src="/img/wedding-party/people/dave.png" />
              <h3>David Lee</h3>
              <p>
                When I think about college, it's mostly fond memories of eating, drinking, and watching a variety of shows with Dave. The amount of Indian food we consumed and number of hours spent watching shows would make you question if we ever studied and if we had the energy to do so. Yet despite our lazy means of bonding, Dave is always at the top of his game when it came to his studies, work, and fellowship. Among the people I know, he is definitely among the brightest and most driven. He can also be attributed to my working in software engineering - one of the best things that has ever happened to me. But when it comes down to it, he's a guy who is willing to set aside time in his busy schedule to catch up, grab a meal, and just lazily watch shows on the couch and have a blast doing so. Just a down to earth bro.
              </p>
            </div>

            <div key='seongwoo' className='party-member' data-member='seongwoo'>
              <img src="/img/wedding-party/people/seongwoo.png" />
              <h3>Seongwoo Byun</h3>
              <p>
                One of the most eccentric people I know. A musically gifted, Guatemalan-Korean who works like a horse and enjoys the finer things in life. On top of all that, he is one of the busiest people I know and having the opportunity to hang out with him anytme during the week is on par with winning the lottery these days. Yet this guy seems to make time whenever I visit even it means having to sacrifice sleep and health some other time during the week (hmmm... that makes me sound like a jerk...). But in all seriousness, Seongwoo is one of the most selfless people I know - giving up the few hours a week he has for freetime to spend with others. Juggling a demanding a job and maintaining strong relationships with others is not an easy task, but Seongwoo seems manages.
              </p>
            </div>

          </section>
        </div>

        <FooterElement />
      </section>

