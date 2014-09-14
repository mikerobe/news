url = require 'url'
_ = require 'lodash'

configs =
  development:
    port: process.env.PORT || 8080
    hostname: 'localhost'

  production:
    port: process.env.PORT || 80
    hostname: 'localhost'

Object.defineProperties module.exports = config = configs[process.env.NODE_ENV?.toLowerCase() || 'production'],
  href:
    get: ->
      url.format _.defaults config, protocol: 'http'
