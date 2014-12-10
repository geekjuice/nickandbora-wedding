
###
Backend
###

## Env
{ NAME, SERVER_PORT } = require ('./env.json')

## Requires
express     = require('express')
bodyParser  = require('body-parser')
logger      = require('morgan')
debug       = require('debug')(NAME)

## Start Express
app = express()

## Setup Middleware
app.use(logger('dev'))
app.use(bodyParser.json())
app.use(bodyParser.urlencoded(extended: true))
app.use (req, res, next) ->
  res.header('Access-Control-Allow-Origin', '*')
  res.header('Access-Control-Allow-Methods', 'GET,POST')
  res.header("Access-Control-Allow-Headers", 'Origin, X-Requested-With, Content-Type')
  next()

## Static
app.use(express.static("#{__dirname}/public"))

## Routes
require('./router')(app)

## Start Server
app.set('port', process.env.PORT or SERVER_PORT or 8000)
server = app.listen app.get('port'), ->
  debug('Express server listening on port ' + server.address().port)

## Export App
module.exports = app
