_ = require 'lodash'

module.exports = (err) ->
  if err.errors?
    return _.pluck(_.values(err.errors),'message').join(' ')
  else if err.message
    return err.message

  "An unknown error occurred."

