console.log "{ Nick & Bora }"

_NickAndBora = {}

require.config
  paths:
    q: 'vendor/q'
    zepto: 'vendor/zepto'
    lodash: 'vendor/lodash'
    react: 'vendor/react'
    flux: 'vendor/flux'
    event: 'vendor/event'
    backbone: 'vendor/backbone'
    underscore: 'vendor/lodash'
    jquery: 'vendor/zepto'
  map:
    '*':
      jquery: 'zepto'
      underscore: 'lodash'
  shim:
    zepto:
      exports: '$'
    backbone:
      deps: ['zepto', 'lodash']

require [
  'zepto'
  'backbone'
  'setup'
  'homepage/lib/router'
  'homepage/lib/resizer'
  'homepage/lib/pushstate'
], ($, Backbone, Setup, Router, Resizer, Pushstate) ->

  $ ->
    do Setup
    Pushstate.init()
    Router.init()

    Backbone.history.start
      pushState: true
      root: '/'
