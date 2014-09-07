express = require 'express'
bodyParser = require 'body-parser'
mongoose = require 'mongoose'
mongooseAutoIncrement = require 'mongoose-auto-increment'
errorHandler = require './middleware/error-handler'
require 'express-resource'

serverConfig = require './config/server'
dbConfig = require './config/database'

require('express/lib/response').text = (body) ->
  @set 'Content-Type', 'text/plain'
  @send body

mongoose.connect dbConfig.url
mongooseAutoIncrement.initialize mongoose.connection

app = express()
app.use bodyParser.urlencoded extended: true
app.use bodyParser.json()

app.resource('feeds', require('./api/feed'))
  .resource('articles', require('./api/article'))

app.use errorHandler

app.listen serverConfig.port, serverConfig.hostname, (err) ->
  if err?
    console.error err
    process.exit 1

  console.log "Listening on #{serverConfig.hostname}:#{serverConfig.port}"
