define [
  'react'
], (React) ->

  FooterElement = React.createClass

    render: ->
      <footer id='footer'>
        <div className='made-by-container'>
          <span>Made with &hearts; by Nick & Bora</span>
        </div>
      </footer>
