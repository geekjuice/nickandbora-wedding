define [
  'lodash'
  'zepto'
  'homepage/resizer'
], (_, $, Resizer) ->

  DEFAULT_TRANSITION = 600

  class App

    start: ->
      Resizer.init()

      $('.nick').on 'click', @showModal('.nick-bio')
      $('.bora').on 'click', @showModal('.bora-bio')
      $('.modal-overlay').on 'click', @hideModal('.modal')

      $('a.and').on 'mouseenter', ->
        $('.saveTheDate').addClass('hovered')
      $('a.and').on 'mouseleave', ->
        $('.saveTheDate').removeClass('hovered')

    showModal: (selector) =>
      (e) =>
        e.preventDefault()
        $('.home').addClass('unfocused')
        $(selector).addClass('animating visible')
        @startAnimation(selector)

    hideModal: (selector) =>
      (e) =>
        e.preventDefault()
        $('.home').removeClass('unfocused')
        $(selector).addClass('animating').removeClass('visible')
        @startAnimation(selector)

    startAnimation: (selector) ->
      duration = @getTransitionDuration(selector, 'transform')
      setTimeout @animatingFinished(selector), duration

    animatingFinished: (selector) ->
      (e) ->
        $(selector).removeClass('animating')

    getTransitionDuration: _.memoize (selector, property) ->
      TRANSITION_REGEX = new RegExp "#{property}\\s+([0-9.]+)"
      transition = $(selector).css 'transition'
      match = transition.match TRANSITION_REGEX
      match[1] * 1000 ? DEFAULT_TRANSITION
