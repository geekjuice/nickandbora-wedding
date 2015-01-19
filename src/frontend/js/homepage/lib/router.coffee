define [
  'zepto'
  'lodash'
  'backbone'
  'react'
  'homepage/lib/router'
  'homepage/elements/app'
  'homepage/elements/gallery/app'
  'homepage/elements/travel/app'
], (
  $
  _
  Backbone
  React
  Router
  HomepageApp
  GalleryApp
  TravelApp
) ->

  class Router extends Backbone.Router

    @init: (root='/', pushState=true) ->
      new Router
      Backbone.history.start { root, 'pushState' }

    routes:
      'travel(/)': 'travel'
      'gallery(/)': 'gallery'
      '(/)': 'index'

    initialLoad: true

    initialize: ->
      @el = $('#NickAndBora').get(0)
      @$body = $('body')

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

    travel: ->
      @fancyRoute(TravelApp)

    gallery: ->
      @fancyRoute(GalleryApp)

    index: ->
      @fancyRoute(HomepageApp)

