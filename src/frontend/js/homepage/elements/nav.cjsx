define [
  'react'
], (React) ->

  Nav = React.createClass

    routes:
      'story': 'Our story'
      'proposal': 'Proposal'
      'weddingParty': 'Wedding party'
      'wedding': 'Details'
      'travel': 'Travel'
      'gallery': 'Gallery'
      'registry': 'Registry'

    getDefaultProps: ->
      showNav: false

    mouseenterHandler: (e) ->
      { currentTarget } = e
      route = $(currentTarget).data('icon')
      $(".icon-text.#{route}").addClass('active')

    mouseleaveHandler: (e) ->
      $('.icon-text.active').removeClass('active')

    render: ->
      classes = React.addons.classSet
        'nav-visible': @props.showNav

      <div id='nav' className={classes}>
        <ul>
          {for route, name of @routes
            <li key="nav-#{route}">
              <a href={route}
                 className='icon-container'
                 onMouseEnter={@mouseenterHandler}
                 onMouseLeave={@mouseleaveHandler}
                 data-icon={route} >
                <div className="icon #{route}"></div>
              </a>
            </li>
          }
        </ul>
        <div className='icon-text-container'>
          {for route, name of @routes
            <span key="icon-text-#{route}"
                  className="icon-text #{route}">
              {name}
            </span>
          }
        </div>
      </div>
