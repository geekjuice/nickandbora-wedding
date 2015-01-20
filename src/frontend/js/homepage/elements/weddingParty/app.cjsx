define [
  'zepto'
  'react'
  'homepage/elements/navbar'
  'homepage/elements/footer'
  'homepage/lib/partyBios'
], ($, React, NavBarElement, FooterElement, PARTY_BIOS) ->

  WeddingPartyApp = React.createClass

    goToMember: (key) ->
      (e) ->
        $('html, body').scrollTop $("[data-bio=#{key}]").offset().top

    render: ->
      <section className='NickAndBora-weddingParty'>
        <NavBarElement onNavChange={@onNavChange} />

        <div className='container'>
          <header className='header-text'>
            <img src="/img/wedding-party/weddingparty-text.png" />
          </header>

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

          <section className='party-members'>
            {for key, person of PARTY_BIOS.bridalParty
              <div className='party-member' data-bio={key}>
                <img src="/img/wedding-party/people/#{key}.png" />
                <p>{person.bio or PARTY_BIOS.lorem}</p>
              </div>
            }
            {for key, person of PARTY_BIOS.groomsmen
              <div className='party-member' data-bio={key}>
                <img src="/img/wedding-party/people/#{key}.png" />
                <p>{person.bio or PARTY_BIOS.lorem}</p>
              </div>
            }
          </section>
        </div>

        <FooterElement />
      </section>

