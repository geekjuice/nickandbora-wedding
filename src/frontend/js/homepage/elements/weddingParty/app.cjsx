define [
  'zepto'
  'react'
  'homepage/elements/navbar'
  'homepage/elements/footer'
], ($, React, NavBarElement, FooterElement) ->

  GROOMSMEN =
    'andy': 'Andrew Kim'
    'dj': 'Daniel Jae'
    'hoyoung': 'Hoyoung Chin'
    'dave': 'David Lee'
    'seongwoo': 'Seongwoo Byun'

  BRIDAL_PARTY =
    'sora': 'Sora Lee'
    'julia': 'Julia Park'
    'claire': 'Claire Park'
    'alice': 'Alice Hwang'
    'other': 'Art friend'

  WeddingPartyApp = React.createClass

    render: ->
      <div className='NickAndBora-weddingParty'>
        <NavBarElement onNavChange={@onNavChange} />

        <div className='container'>
          <div className='header-text'>
            <img src="/img/wedding-party/weddingparty-text.png" />
          </div>

          <div className='party'>
            <div className='person'>
              <img src='/img/wedding-party/bora.png' />
            </div>
            <div className='members'>
              <div className='members-text'>
                <img src='/img/wedding-party/bridalparty-text.png' />
              </div>
              <ul>
                {for bridalParty, name of BRIDAL_PARTY
                  <li key={bridalParty}>
                    <span>{name}</span>
                  </li>
                }
              </ul>
            </div>
          </div>

          <div className='party'>
            <div className='person'>
              <img src='/img/wedding-party/nick.png' />
            </div>
            <div className='members'>
              <div className='members-text'>
                <img src='/img/wedding-party/groomsmen-text.png' />
              </div>
              <ul>
                {for groomsman, name of GROOMSMEN
                  <li key={groomsman}>
                    <span>{name}</span>
                  </li>
                }
              </ul>
            </div>
          </div>

        </div>

        <FooterElement />
      </div>

