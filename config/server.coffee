url = require 'url'
_ = require 'lodash'

configs =
  development:
    port: 8080
    hostname: 'localhost'

  production:
    port: 80
    hostname: 'localhost'

Object.defineProperties module.exports = config = configs[process.env.NODE_ENV?.toLowerCase() || 'production'],
  href:
    get: ->
      url.format _.defaults config, protocol: 'http'
