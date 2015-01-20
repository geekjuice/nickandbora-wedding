define [
  'zepto'
  'react'
  'homepage/elements/navbar'
  'homepage/elements/footer'
], ($, React, NavBarElement, FooterElement) ->

  ProposalApp = React.createClass

    render: ->
      <div className='NickAndBora-proposal'>
        <NavBarElement onNavChange={@onNavChange} />
        <span>Proposal</span>
        <FooterElement />
      </div>

