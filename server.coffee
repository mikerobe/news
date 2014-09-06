express = require 'express'
bodyParser = require 'body-parser'
serverConfig = require './config/server'

app = express()
app.use bodyParser.urlencoded extended: true
app.use bodyParser.json()

router = express.Router()

router.get '/', (req, res) ->
  res.json message: 'hello!'

app.use '/api', router

app.listen serverConfig.port, serverConfig.hostname, (err) ->
  if err?
    console.error err
    process.exit 1

  console.log "Listening on #{serverConfig.hostname}:#{serverConfig.port}"
