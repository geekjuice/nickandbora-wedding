define [
  'zepto'
  'lodash'
  'backbone'
  'react'
  'homepage/lib/router'
  'homepage/elements/app'
  'homepage/elements/story/app'
  # 'homepage/elements/proposal/app'
  # 'homepage/elements/weddingParty/app'
  # 'homepage/elements/details/app'
  'homepage/elements/travel/app'
  'homepage/elements/gallery/app'
], (
  $
  _
  Backbone
  React
  Router
  HomepageApp
  # StoryApp
  # WeddingPartyAppApp
  # DetailsApp
  TravelApp
  GalleryApp
) ->

  class Router extends Backbone.Router

    @init: (root='/', pushState=true) ->
      new Router
      Backbone.history.start { root, 'pushState' }

    routes:
      'story(/)': 'story'
      'proposal(/)': 'proposal'
      'wedding-party(/)': 'weddingParty'
      'wedding(/)': 'details'
      'travel(/)': 'travel'
      'gallery(/)': 'gallery'
      '(/)': 'index'

    elements:
      # 'story': StoryApp
      # 'proposal': ProposalApp
      # 'weddingParty': WeddingPartyApp
      # 'details': DetailsApp
      'travel': TravelApp
      'gallery': GalleryApp
      'index': HomepageApp

    initialLoad: true

    constructor: ->
      for route, Element of @elements
        do (Element) =>
          @[route] = -> @fancyRoute(Element)
      super

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
