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
      backgroundPosition = if (h / (w / 2)) < 1.5
      then 'center 25%'
      else 'center center'
      $('.hello-bg').css { backgroundPosition }

  new Resizer
