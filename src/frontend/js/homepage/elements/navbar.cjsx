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

    render: ->
      { navOpen } = @state

      <div id='navbar'>
        <div className='banner top'>
          <img src="/img/wedding-party/banner-top.png" />
        </div>
        <div href='#' className='nav-link' onClick={@toggleNav}>
          <span className="icono-#{if navOpen then 'cross' else 'hamburger'}" />
        </div>
        <div className="nav #{if navOpen then 'nav-visible' else ''}">
          <NavElement showNav={true} />
        </div>
      </div>

