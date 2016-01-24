define [
  'lodash'
  'bluebird'
], (_, Promise) ->

  _setTimeout = (timeout, cb) ->
    deferred = Promise.pending()
    setTimeout ->
      cb()
      deferred.fulfill()
    , timeout
    deferred.promise

  run: _setTimeout

  nextTick: _.curry(_setTimeout)(0)

  for: (timeout, cb) ->
    -> _setTimeout(timeout, cb)
