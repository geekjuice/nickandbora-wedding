define [
  'lodash'
  'zepto'
], (_, $) ->

  class App

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

    parallaxHeader: (e) =>
      height = $('.splash').height()
      scrollTop = $(window).scrollTop()
      translate3d = "translate3d(0,#{0.48 * scrollTop}px,0)"
      opacity = (0.8 * height - scrollTop) / (0.75 * height)
      style = _.extend {}, @vendorize('transform', translate3d),
        opacity: Math.max(0, Math.min(1, opacity))
      $('.logo-parallax').css(style)

    start: ->
      # $(window).on('scroll', @parallaxHeader).scroll()
      $('.enter').on 'click', @enter

    enter: (e) =>
      e.preventDefault()
      @hide('.enter')
      @hide('.splash')
      @show('.home')

    show: (selector) ->
      $(selector).addClass('visible').removeClass('hidden')

    hide: (selector) ->
      $(selector).addClass('hidden').removeClass('visible')
      setTimeout ->
        $(selector).addClass('removed')
      , 1000
