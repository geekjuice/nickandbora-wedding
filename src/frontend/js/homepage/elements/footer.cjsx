define [
  'react'
], (React) ->

  FooterElement = React.createClass

    render: ->
      <footer id='footer'>
        <div className='banner bottom'>
          <img src="/img/wedding-party/banner-bottom.png" />
        </div>
        <div className='made-by-container'>
          <span>Made with &hearts; by Nick & Bora</span>
        </div>
      </footer>
