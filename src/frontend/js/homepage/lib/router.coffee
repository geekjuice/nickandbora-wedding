define [
  'zepto'
  'lodash'
  'backbone'
  'react'
  'homepage/lib/router'
  'homepage/elements/app'
  'gallery/elements/app'
], ($, _, Backbone, React, Router, App, GalleryApp) ->

  class Router extends Backbone.Router

    @init: (root='/', pushState=true) ->
      new Router
      Backbone.history.start { root, 'pushState' }

    initialize: ->
      @el = $('#NickAndBora').get(0)

    routes:
      'gallery(/)': 'gallery'
      '(/)': 'index'

    index: ->
      React.render(<App />, @el)

    gallery: ->
      React.render(<GalleryApp />, @el)
