define [
  'zepto'
  'backbone'
], ($, Backbone) ->

  EXTERNAL_LINK_REGEX = /(^http[s]?:\/\/.*)|(^\/.*)|(mailto:)/

  class Pushstate

    @init: ->
      new Pushstate

    constructor: ->
      $(document).delegate 'a', 'click', @linkHandler

    linkHandler: (e) ->
      { altKey, ctrlKey, metaKey, shiftKey } = e
      href = $(@).attr('href')
      return if EXTERNAL_LINK_REGEX.test(href) or altKey or ctrlKey or metaKey or shiftKey
      e.preventDefault()
      Backbone.history.navigate(href, trigger: true)
