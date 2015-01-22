define [
  'zepto'
  'react'
  'homepage/elements/navbar'
  'homepage/elements/footer'
], ($, React, NavBarElement, FooterElement) ->

  RegistryApp = React.createClass

    render: ->
      <div className='NickAndBora-registry'>
        <NavBarElement />
        <span>Registry</span>
        <FooterElement />
      </div>

