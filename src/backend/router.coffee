###
Router
###

mongo        = require('mongoskin')
errorHandler = require('errorhandler')

C       = require('./constants')
api     = require('./api')
Enviro  = require('./lib/enviro')

KEY = 'NickAndBora-Env'

ROUTES =
  '/saveTheDate': 'saveTheDate'
  '/comingSoon': 'comingSoon'
  '/wedding': 'wedding'
  '/': 'index'

ROUTES = _.omit ROUTES, ['/comingSoon', '/wedding'] if Enviro.isProd(KEY)


_route = (file) ->
  (req, res, next) ->
    res.sendFile("#{__dirname}/public/#{file}.html")


module.exports = (app) ->

  ## Load MongoDB
  db = mongo.db(C.MONGOURI, {safe: true})

  ## API
  api.param 'collection', (req, res, next, collection) ->
    req.collection = db.collection(collection)
    next()

  ## API Routes
  app.use '/api', api

  ## Static Routes
  for route, file of ROUTES
    app.use route, _route(file)

  ## Catch 404
  app.get '*', (req, res, next) ->
    err = new Error('Not Found')
    err.status = 404
    next(err)

  ## Error Handlers
  switch
    when Enviro.isLocal() or Enviro.isQA()
      app.use(errorHandler())
    when Enviro.isProd()
      app.use (err, req, res, next) ->
        res.status(err.status or 500)
        res.render 'error',
          message: err.message,
          error: {}
