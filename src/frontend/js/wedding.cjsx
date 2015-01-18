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
  'wedding/elements/app'
], ($, React, Setup, App) ->

  $ ->
    do Setup
    React.render(<App />, document.getElementById('wedding'))
