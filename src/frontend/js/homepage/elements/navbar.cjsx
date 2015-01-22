define [
  'zepto'
  'react'
  'homepage/elements/nav'
], ($, React, NavElement) ->

  NavBarElement = React.createClass

    getDefaultProps: ->
      onNavChange: null

    getInitialState: ->
      navOpen: false

    toggleNav: (e) ->
      navOpen = not @state.navOpen
      @props.onNavChange?(navOpen)
      @setState { navOpen }

    openNav: ->
      @setState { navOpen: true }

    render: ->
      { navOpen } = @state

      <div id='navbar'>
        <div className='banner top'>
          <img src="/img/wedding-party/banner-top.png" />
        </div>
        <a href='/' className='home-link'>
          <span className="icono-heart" />
        </a>
        <div className='nav-link'
             onMouseEnter={@openNav}
             onClick={@toggleNav}>
          <span className="icono-#{if navOpen then 'cross' else 'hamburger'}" />
        </div>
        <div className="nav #{if navOpen then 'nav-visible' else ''}">
          <NavElement showNav={true} />
        </div>
      </div>

