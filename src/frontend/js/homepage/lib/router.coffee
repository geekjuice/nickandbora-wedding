define [
  'zepto'
  'lodash'
  'backbone'
  'react'
  'homepage/lib/router'
  'homepage/elements/app'
  'homepage/elements/story'
  'homepage/elements/proposal'
  'homepage/elements/weddingParty'
  'homepage/elements/details'
  'homepage/elements/travel'
  'homepage/elements/gallery'
  'homepage/elements/registry'
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
      @$container = $('#NickAndBora')
      @$body = $('body')

    fancyRoute: (title, App) ->
      document.title = if title then "#{TITLE} | #{title}" else TITLE
      @$container.removeClass('loaded')
      setTimeout =>
        @$body.scrollTop(0)
        @$container.addClass('loaded')
        React.render(<App />, @el)
      , 1000
