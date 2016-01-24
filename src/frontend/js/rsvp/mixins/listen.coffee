define [], ->

  listenTo: (store, cb) ->
    store.on 'change', cb ?  @onStoreChange

  stopListening: (store, cb) ->
    store.off 'change', cb ? @onStoreChange
