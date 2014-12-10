###
Contact API
###

_      = require('lodash')
router = require('express').Router()

## POST Contact Info
router.post "/", (req, res, next) ->
  res.send(req.body)

## Export Router
module.exports = router
