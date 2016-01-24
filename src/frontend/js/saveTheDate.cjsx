console.log "{ Nick & Bora }"

_NickAndBora = {}

require.config
  paths:
    bluebird: 'vendor/bluebird'
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
  'saveTheDate/elements/app'
], ($, React, Setup, App) ->

  $ ->
    do Setup
    React.render(<App />, document.getElementById('login'))
