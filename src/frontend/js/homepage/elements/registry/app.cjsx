define [
  'zepto'
  'react'
  'homepage/elements/navbar'
], ($, React, NavBarElement) ->

  RegistryApp = React.createClass

    render: ->
      <div className='NickAndBora-registry'>
        <NavBarElement />
        <span>Registry</span>
      </div>

