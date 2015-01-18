define [
  'lodash'
  'react'
  'lib/enviro'
  'homepage/mixers/transition'
  'homepage/elements/nav'
], (_, React, Enviro, TransitionMixin, NavElement) ->

  KEY = 'NickAndBora-Env'
  NICK = 'nick'
  BORA = 'bora'

  Banner = React.createClass

    mixins: [TransitionMixin]

    getInitialState: ->
      showNav: false

    showNav: (e) ->
      e.preventDefault()
      @setState({showNav: true}) unless @state.showNav

    showBio: (who) ->
      (e) =>
        e.preventDefault()
        selector = if who is NICK then '.nick-bio' else '.bora-bio'
        $('.home').addClass('unfocused')
        $(selector).addClass('animating visible')
        @startAnimation(selector)

    render: ->
      { showNav } = @state

      if Enviro.isProd(KEY)
        andLink = '/SaveTheDate'
        andClick = _.noop
      else
        andLink = '#'
        andClick = @showNav

      classes = React.addons.classSet
        'center-nav': true
        'nav-visible': showNav

      <section className='home'>
        <div className={classes}>
          <ul>
            <li>
              <a className='nick' href='#' onClick={@showBio(NICK)}>
                <img className='inactive' src='/img/nick_inactive.png' />
                <img className='active' src='/img/nick_active.png' />
              </a>
            </li>
            <li>
              <a className='and' href={andLink} onClick={andClick}>
                <img className='inactive' src='/img/and_inactive.png' />
                <img className='active' src='/img/and_active.png' />
              </a>
            </li>
            <li>
              <a className='bora' href='#' onClick={@showBio(BORA)}>
                <img className='inactive' src='/img/bora_inactive.png' />
                <img className='active' src='/img/bora_active.png' />
              </a>
            </li>
          </ul>
          <div className='saveTheDate'>
            <span>March 28, 2015</span>
          </div>
          <NavElement showNav={showNav}/>
        </div>
        <div className='mask' />
      </section>

