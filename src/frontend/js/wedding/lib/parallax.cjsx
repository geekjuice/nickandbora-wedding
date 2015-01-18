define [
  'lodash'
  'zepto'
], (_, $) ->

  class Parallax

    @init: ->
      new Parallax

    constructor: ->
      $(window).on('scroll', @parallaxHero).scroll()

    vendorize: (css, value) ->
      transition = {}
      vendors = [
        "-webkit-#{css}"
        "-moz-#{css}"
        "-ms-#{css}"
        "-o-#{css}"
        "#{css}"
      ]
      for vendor in vendors
        transition[vendor] = value
      transition

    parallaxHero: (e) =>
      height = $('.hero').height()
      scrollTop = $(window).scrollTop()
      translate3d = "translate3d(0,-#{0.45 * scrollTop}px,0)"
      opacity = (0.8 * height - scrollTop) / (0.75 * height)
      style = _.extend {}, @vendorize('transform', translate3d),
        opacity: Math.max(0, Math.min(1, opacity))
      $('.logo-text, .logo-subtext').css(style)

