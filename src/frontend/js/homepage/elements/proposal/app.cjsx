define [
  'zepto'
  'react'
  'homepage/elements/navbar'
], ($, React, NavBarElement) ->

  ProposalApp = React.createClass

    render: ->
      <div className='NickAndBora-proposal'>
        <NavBarElement onNavChange={@onNavChange} />
        <span>Proposal</span>
      </div>

