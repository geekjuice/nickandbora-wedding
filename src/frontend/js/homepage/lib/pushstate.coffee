define [
  'zepto'
  'backbone'
], ($, Backbone) ->

  EXTERNAL_LINK_REGEX = /(^http:\/\/.*)|(^\/.*)/

  class Pushstate

    @init: ->
      new Pushstate

    constructor: ->
      $(document).delegate 'a', 'click', @linkHandler

    linkHandler: (e) ->
      href = $(@).attr('href')
      return if EXTERNAL_LINK_REGEX.test(href)
      e.preventDefault()
      Backbone.history.navigate(href, trigger: true)
