config =
  development:
    host: '/tmp/redis.sock'

  production: 
    host: '/tmp/redis.sock'

module.exports = config[process.env.NODE_ENV?.toLowerCase() || 'production']
