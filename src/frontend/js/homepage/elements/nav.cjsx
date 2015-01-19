define [
  'react'
], (React) ->

  Nav = React.createClass

    routes: [
      'story'
      'proposal'
      'weddingParty'
      'wedding'
      'travel'
      'gallery'
      'registry'
    ]

    getDefaultProps: ->
      showNav: false

    render: ->
      classes = React.addons.classSet
        'nav-visible': @props.showNav

      <div id='nav' className={classes}>
        <ul>
          {for route in @routes
            <li key={"nav-#{route}"}>
              <a href={route} className='icon-container'>
                <div className='icon' />
              </a>
            </li>
          }
        </ul>
      </div>
