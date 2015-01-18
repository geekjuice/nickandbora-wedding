define [
  'react'
], (React) ->

  Hero = React.createClass

    render: ->
      <section className='hero'>
        <div className='logo-text'>
          Nick & Bora
        </div>
        <div className='logo-subtext'>
          March 28, 2015
        </div>
      </section>

