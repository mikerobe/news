formatError = require '../services/format-error'

module.exports = (err, req, res, next) ->
  res.status(400).json
    message: formatError err
