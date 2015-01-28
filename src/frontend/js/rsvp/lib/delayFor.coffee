define [
  'q'
], (Q) ->

  (timeout, cb) ->
    ->
      deferred = Q.defer()
      setTimeout ->
        cb()
        deferred.resolve()
      , timeout
      deferred.promise
