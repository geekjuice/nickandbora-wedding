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

    routes:
      'gallery(/)': 'gallery'
      '(/)': 'index'

    initialLoad: true

    initialize: ->
      @el = $('#NickAndBora').get(0)
      @$body = $('body')

    index: ->
      @fancyRoute(App)

    gallery: ->
      @fancyRoute(GalleryApp)

    fancyRoute: (Element) ->
      if @initialLoad
        @initialLoad = false
        React.render(<Element />, @el)
      else
        @$body.addClass('transitioning')
        setTimeout =>
          @$body.removeClass('transitioning')
          React.render(<Element />, @el)
        , 1000
