express = require 'express'
bodyParser = require 'body-parser'
mongoose = require 'mongoose'
mongooseAutoIncrement = require 'mongoose-auto-increment'
http = require 'http'
io = require 'socket.io'
_ = require 'lodash'
errorHandler = require './middleware/error-handler'
redisPublish = require './middleware/redis-publish'
require 'express-resource'

serverConfig = require './config/server'
redisPublishConfig = require './config/redis-publish'

require('express/lib/response').text = (body) ->
  @set 'Content-Type', 'text/plain'
  @send body

mongoose.connect require('./config/database').url
mongooseAutoIncrement.initialize mongoose.connection

app = express()
server = http.Server(app)
require('./server/socket') io(server), app, redis: redisPublishConfig

app.use bodyParser.urlencoded extended: true
app.use bodyParser.json()
app.use redisPublish redisPublishConfig
app.use express.static(process.cwd() + '/public')
app.set 'view engine', 'jade'

app.get '/', (req, res) ->
  res.render ''

app.resource('feeds', _.extend(require('./api/feed'),base:'/api'))
  .resource('articles', require('./api/article'))

app.use errorHandler

server.listen serverConfig.port, serverConfig.hostname, (err) ->
  if err?
    console.error err
    process.exit 1

  console.log "Listening on #{serverConfig.hostname}:#{serverConfig.port}"
