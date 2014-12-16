console.log "{ Nick & Bora }"

_NickAndBora = {}

require.config
  paths:
    q: 'vendor/q'
    zepto: 'vendor/zepto'
    lodash: 'vendor/lodash'
    react: 'vendor/react'
    flux: 'vendor/flux'
    page: 'vendor/page'
    event: 'vendor/event'
  shim:
    zepto:
      exports: '$'
    page:
      exports: 'page'

require [
  'zepto'
  'setup'
], ($, Setup) ->

  getTransition = (value) ->
    '-webkit-transition': value
    '-moz-transition': value
    '-ms-transition': value
    '-o-transition': value
    'transition': value

  showTransition = ->
    now = +new Date()
    oneDay = 24 * 60 * 60 * 1000
    loaded = localStorage?['NickAndBora:ComingSoon']

    noValue = not loaded?
    invalid = loaded? and isNaN(loaded)
    expired = not invalid and (now - +loaded > oneDay)

    if noValue or invalid or expired
      transition = getTransition('opacity 2.0s 1.0s')
      $('.background-image').css(transition)
      localStorage['NickAndBora:ComingSoon'] = now

  $ ->
    do Setup
    showTransition()
    $('.background-image').addClass('loaded')
