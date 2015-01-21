define [
  'zepto'
  'react'
  'homepage/elements/navbar'
  'homepage/elements/footer'
  'homepage/lib/partyBios'
], ($, React, NavBarElement, FooterElement, BIOS) ->

  S3_URL = 'http://nickandbora.s3.amazonaws.com'

  ProposalApp = React.createClass

    render: ->
      <div className='NickAndBora-proposal'>
        <NavBarElement onNavChange={@onNavChange} />
        <h1>Proposal</h1>
        <div className='hero' />

        <section>
          <h3>Where?</h3>
          <p><em>Hello</em> {BIOS.lorem}</p>
        </section>

        <section>
          <h3>How?</h3>
          <p><em>Hello</em> {BIOS.lorem}</p>
        </section>

        <FooterElement />
      </div>

