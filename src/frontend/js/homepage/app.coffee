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
      $('.nick').on 'click', @showNick
      $('.bora').on 'click', @showBora
      $('.overlay').on 'click', @goBack

    enter: (e) =>
      e.preventDefault()
      @hide('.enter')
      @hide('.splash')
      @show('.home')

    showNick: (e) =>
      e.preventDefault()
      @blurBackground()
      $nick = $('.nick-bio')
      $nick.addClass('reveal')
      setTimeout ->
        $nick.addClass('revealing')
      , 25

    showBora: (e) =>
      e.preventDefault()
      @blurBackground()
      $bora = $('.bora-bio')
      $bora.addClass('reveal')
      setTimeout ->
        $bora.addClass('revealing')
      , 25

    goBack: (e) =>
      @unblurBackground()
      $bios = $('.bios')
      $bios.removeClass('revealing')
      setTimeout ->
        $bios.removeClass('reveal')
      , 600

    blurBackground: ->
      $('.mask').addClass('blurred')

    unblurBackground: ->
      $('.mask').removeClass('blurred')

    show: (selector) ->
      $(selector).addClass('visible').removeClass('hidden')

    hide: (selector) ->
      $(selector).addClass('hidden').removeClass('visible')
      setTimeout ->
        $(selector).addClass('removed')
      , 1000
