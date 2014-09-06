express = require 'express'
bodyParser = require 'body-parser'
mongoose = require 'mongoose'
mongooseAutoIncrement = require 'mongoose-auto-increment'

serverConfig = require './config/server'
dbConfig = require './config/database'

mongoose.connect dbConfig.url
mongooseAutoIncrement.initialize mongoose.connection

app = express()
app.use bodyParser.urlencoded extended: true
app.use bodyParser.json()

router = express.Router()

router.get '/', (req, res) ->
  res.json message: 'hello!'

require('./routes/feed')(router)

app.use '/api', router

app.listen serverConfig.port, serverConfig.hostname, (err) ->
  if err?
    console.error err
    process.exit 1

  console.log "Listening on #{serverConfig.hostname}:#{serverConfig.port}"
