define [
  'react'
], (React) ->

  Nav = React.createClass

    getDefaultProps: ->
      showNav: false

    render: ->
      classes = React.addons.classSet
        'nav': true
        'nav-visible': @props.showNav

      <div className={classes}>
        <ul>
          {for i in [0..5]
            <li key={"nav-#{i}"}>
              <a href>
                <img src='http://placehold.it/50x50' />
              </a>
            </li>
          }
        </ul>
      </div>
