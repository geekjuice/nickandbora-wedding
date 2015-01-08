define [
  'backbone'
  'react'
  'homepage/lib/router'
  'homepage/elements/app'
], (Backbone, React, Router, App) ->

  class Router extends Backbone.Router

    @init: ->
      new Router

    routes:
      'gallery(/)': 'gallery'
      '(/)': 'index'

    index: ->
      React.render(<App />, document.getElementById('NickAndBora'))

    gallery: ->
      React.render(
        <div>Hello</div>
        document.getElementById('NickAndBora')
      )
