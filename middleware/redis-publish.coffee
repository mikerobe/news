redis = require 'redis'
_ = require 'lodash'

module.exports = (options={}) ->
  pub = redis.createClient options.host || '127.0.0.1', options.port || 6379, _.omit(options,'host','port')

  (req, res, next) ->
    req.publish = (data) ->
      endpoint = req.path.replace(/\/$/,'')
      try
        pub.publish endpoint, JSON.stringify(data)
        return true
      catch _error
        console.error "Unable to publish to #{endpoint} #{data}"
        return false
    next()