define [
  'react'
], (React) ->

  Nav = React.createClass

    getDefaultProps: ->
      showNav: false

    render: ->
      classes = React.addons.classSet
        'nav-visible': @props.showNav

      <div id='nav' className={classes}>
        <ul>
          {for i in [0..5]
            <li key={"nav-#{i}"}>
              <a href='gallery' className='icon-container'>
                <div className='icon' />
              </a>
            </li>
          }
        </ul>
      </div>
