
###
Static Server
###

{ NODE_ENV, PORT } = process.env

require('newrelic') if NODE_ENV is 'production'

## Env
NAME = 'NickAndBora'

## Requires
express = require('express')
logger  = require('morgan')
debug   = require('debug')(NAME)

## Start Express
app = express()

## Setup Middleware
app.use(logger('dev'))

## Static
app.use(express.static("#{__dirname}/public"))

## Routes
require('./router')(app)

## Start Server
app.set('port', PORT or 7000)
server = app.listen app.get('port'), ->
  debug('Express static server listening on port ' + server.address().port)

## Export App
module.exports = app

