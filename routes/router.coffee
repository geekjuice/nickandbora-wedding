###
Router
###

errorHandler = require('errorhandler')

contact = require('./contact')

module.exports = (app) ->

  app.use '/contact', contact

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
