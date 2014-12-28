define [
  'react'
  'wedding/elements/venue'
], (React, VenueElement) ->

  Content = React.createClass

    render: ->
      <section className='content'>
        <VenueElement />
      </section>
