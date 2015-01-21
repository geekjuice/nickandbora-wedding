define [
  'zepto'
  'react'
  'velocity'
  'homepage/elements/navbar'
  'homepage/elements/footer'
  'homepage/lib/partyBios'
], ($, React, Velocity, NavBarElement, FooterElement, PARTY_BIOS) ->

  WeddingPartyApp = React.createClass

    getInitialState: ->
      backToTopVisible: false

    componentWillMount: ->
      @_debouncedShowBackToTop = _.debounce @showBackToTop, 500
      $(window).on 'scroll', @_debouncedShowBackToTop

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
        [duration, easing, offset] = [1600, 'ease-in-out', $("[data-bio=#{key}]").offset().top]
        Velocity(document.body, 'scroll', { duration, easing, offset })

    render: ->
      { backToTopVisible } = @state

      backToTopClasses = React.addons.classSet
        'back-to-top': true
        'visible': backToTopVisible

      <section className='NickAndBora-weddingParty'>
        <NavBarElement onNavChange={@onNavChange} />

        <span className={backToTopClasses} onClick={@backToTop}>↟</span>

        <div className='container'>
          <header className='header-text'>
            <img src="/img/wedding-party/weddingparty-text.png" />
          </header>

          <section className='bride-and-groom'>
            <section className='party'>
              <div className='person'>
                <img src='/img/wedding-party/people/bora.png' />
              </div>
              <div className='members'>
                <div className='members-text'>
                  <img src='/img/wedding-party/bridalparty-text.png' />
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
                <div className='members-text'>
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
            {for key, person of PARTY_BIOS.bridalParty
              <div key={key} className='party-member' data-bio={key}>
                <img src="/img/wedding-party/people/#{key}.png" />
                <p>{person.bio or PARTY_BIOS.lorem}</p>
              </div>
            }
            {for key, person of PARTY_BIOS.groomsmen
              <div key={key} className='party-member' data-bio={key}>
                <img src="/img/wedding-party/people/#{key}.png" />
                <p>{person.bio or PARTY_BIOS.lorem}</p>
              </div>
            }
          </section>
        </div>

        <FooterElement />
      </section>

