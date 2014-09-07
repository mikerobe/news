redis = require 'redis'
_ = require 'lodash'

module.exports = (options={}) ->
  pub = redis.createClient options.host || '127.0.0.1', options.port || 6379, _.omit(options,'host','port')

  (req, res, next) ->
    req.publish = pub.publish.bind(pub, req.path.replace(/\/$/,''))
    next()