define [
  'lodash'
  'zepto'
  'homepage/resizer'
], (_, $, Resizer) ->

  class App

    start: ->
      $('.enter').on 'click', @enter
      $('.nick').on 'click', @showNick
      $('.bora').on 'click', @showBora
      $('.overlay').on 'click', @goBack
      Resizer.init()

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
