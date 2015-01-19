define [
  'zepto'
  'lodash'
  'backbone'
  'react'
  'homepage/lib/router'
  'homepage/elements/app'
  'homepage/elements/story/app'
  'homepage/elements/proposal/app'
  'homepage/elements/weddingParty/app'
  'homepage/elements/details/app'
  'homepage/elements/travel/app'
  'homepage/elements/gallery/app'
  'homepage/elements/registry/app'
], (
  $
  _
  Backbone
  React
  Router
  HomepageApp
  StoryApp
  ProposalApp
  WeddingPartyApp
  DetailsApp
  TravelApp
  GalleryApp
  RegistryApp
) ->

  class Router extends Backbone.Router

    @init: (root='/', pushState=true) ->
      new Router
      Backbone.history.start { root, 'pushState' }

    routes:
      'story(/)': 'story'
      'proposal(/)': 'proposal'
      'weddingParty(/)': 'weddingParty'
      'wedding(/)': 'details'
      'travel(/)': 'travel'
      'gallery(/)': 'gallery'
      'registry(/)': 'registry'
      '(/)': 'index'

    elements:
      'index': HomepageApp
      'story': StoryApp
      'proposal': ProposalApp
      'weddingParty': WeddingPartyApp
      'details': DetailsApp
      'travel': TravelApp
      'gallery': GalleryApp
      'registry': RegistryApp

    constructor: ->
      for route, Element of @elements
        do (Element) =>
          @[route] = -> @fancyRoute(Element)
      super

    initialize: ->
      @el = $('#NickAndBora').get(0)
      @$body = $('#NickAndBora')

    fancyRoute: (Element) ->
      @$body.removeClass('loaded')
      setTimeout =>
        @$body.addClass('loaded')
        React.render(<Element />, @el)
      , 1000
