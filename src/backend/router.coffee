###
Router
###

mongo        = require('mongoskin')
errorHandler = require('errorhandler')

C   = require('./constants')
api = require('./api')

module.exports = (app) ->

  db = mongo.db(C.MONGOURI, {safe: true})

  ## API
  api.param 'collection', (req, res, next, collection) ->
    req.collection = db.collection(collection)
    next()

  ## API Routes
  app.use '/api', api

  ## Catch 404
  app.get '*', (req, res, next) ->
    err = new Error('Not Found')
    err.status = 404
    next(err)

  ## Error Handlers
  switch app.get('env')
    when 'development'
      app.use(errorHandler())
    when 'production'
      app.use (err, req, res, next) ->
        res.status(err.status or 500)
        res.render 'error',
          message: err.message,
          error: {}
