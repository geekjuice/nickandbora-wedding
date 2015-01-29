define [
  'bluebird'
], (Promise) ->

  _setTimeout = (timeout, cb) ->
    deferred = Promise.pending()
    setTimeout ->
      cb()
      deferred.fulfill()
    , timeout
    deferred.promise

  run: _setTimeout

  for: (timeout, cb) ->
    -> _setTimeout(timeout, cb)
