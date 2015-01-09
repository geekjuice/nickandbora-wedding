define [
  'lodash'
  'zepto'
], (_, $) ->

  class Resizer

    throttleRate: 500

    constructor: ->
      @_throttleResize = _.throttle @resizeHandler, @throttleRate

    init: ->
      $(window).on('resize', @_throttleResize).resize()

    resizeHandler: (e) ->
      $window = $(window)
      h = $window.height()
      w = $window.width()

      if (h / (w / 2)) < 1
        styles =
          backgroundPosition: 'center 25%'
      else
        styles =
          backgroundPosition: 'center center'

      $('.modal-content').css(styles)

  new Resizer
