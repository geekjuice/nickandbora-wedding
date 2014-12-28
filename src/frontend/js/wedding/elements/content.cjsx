define [
  'react'
  'wedding/elements/when'
  'wedding/elements/where'
], (React, WhenElement, WhereElement) ->

  Content = React.createClass

    render: ->
      <section className='content'>
        <WhenElement />
        <WhereElement />
      </section>
