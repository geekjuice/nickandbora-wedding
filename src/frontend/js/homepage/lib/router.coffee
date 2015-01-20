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

  TITLE = 'Nick & Bora'

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
      'index': [null, HomepageApp]
      'story': ['Our Story', StoryApp]
      'proposal': ['Proposal', ProposalApp]
      'weddingParty': ['Wedding Party', WeddingPartyApp]
      'details': ['Wedding', DetailsApp]
      'travel': ['Travel Information', TravelApp]
      'gallery': ['Gallery', GalleryApp]
      'registry': ['Registry', RegistryApp]

    constructor: ->
      for route, Element of @elements
        do (Element) =>
          @[route] = -> @fancyRoute(Element[0], Element[1])
      super

    initialize: ->
      @el = $('#NickAndBora').get(0)
      @$body = $('#NickAndBora')

    fancyRoute: (title, App) ->
      document.title = if title then "#{TITLE} | #{title}" else TITLE
      @$body.removeClass('loaded')
      setTimeout =>
        @$body.addClass('loaded')
        React.render(<App />, @el)
      , 1000
