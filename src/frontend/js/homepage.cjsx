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
  'react'
  'setup'
  'homepage/lib/resizer'
  'homepage/elements/app'
], ($, React, Setup, Resizer, App) ->

  $ ->
    do Setup
    Resizer.init()
    React.render(<App />, document.getElementById('NickAndBora'))
