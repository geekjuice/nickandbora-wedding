console.log "{ Nick & Bora }"

_NickAndBora = {}

require.config
  paths:
    bluebird: 'vendor/bluebird'
    zepto: 'vendor/zepto'
    lodash: 'vendor/lodash'
    react: 'vendor/react'
    flux: 'vendor/flux'
    event: 'vendor/event'
    backbone: 'vendor/backbone'
    underscore: 'vendor/lodash'
    jquery: 'vendor/zepto'
    masonry: 'vendor/masonry'
    imagesloaded: 'vendor/imagesloaded'
    velocity: 'vendor/velocity'
  map:
    '*':
      jquery: 'zepto'
      underscore: 'lodash'
  shim:
    zepto:
      exports: '$'
    velocity:
      deps: ['zepto']
    backbone:
      deps: ['zepto', 'lodash']

require [
  'zepto'
  'velocity'
  'backbone'
  'setup'
  'homepage/lib/router'
  'homepage/lib/pushstate'
], ($, Velocity, Backbone, Setup, Router, Pushstate) ->

  $ ->
    do Setup
    Pushstate.init()
    Router.init()
