define [
  'bluebird'
], (Promise) ->

  (timeout, cb) ->
    ->
      deferred = Promise.pending()
      setTimeout ->
        cb()
        deferred.fulfill()
      , timeout
      deferred.promise
