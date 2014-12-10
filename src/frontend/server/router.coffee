###
Static Routes
###

ROUTES =
  '/saveTheDate': 'saveTheDate'
  '/': 'index'

_route = (file) ->
  (req, res, next) ->
    res.sendFile("#{__dirname}/public/#{file}.html")

module.exports = (app) ->

  ## Static Routes
  for route, file of ROUTES
    app.use route, _route(file)

  ## Catch 404
  app.get '*', (req, res, next) ->
    err = new Error('Not Found')
    err.status = 404
    next(err)
