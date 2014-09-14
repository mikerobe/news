redis = require 'redis'
_ = require 'lodash'

module.exports = (io, app, options={redis:{}}) ->
  io.on 'connection', (socket) ->
    sub = redis.createClient options.redis.host || '127.0.0.1', options.redis.port || 6379, _.omit(options.redis,'host','port')
    socket.on 'disconnect', sub.quit.bind(sub)
    socket.on 'subscribe', sub.subscribe.bind(sub)
    socket.on 'unsubscribe', sub.unsubscribe.bind(sub)
    sub.on 'message', (endpoint, data) ->
      try
        socket.emit endpoint, JSON.parse(data)
      catch _error
        console.error "Unable to parse redis payload: #{data}"
