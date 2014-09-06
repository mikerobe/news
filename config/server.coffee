config =
  development:
    port: 8080
    hostname: 'localhost'

  production: 
    port: 80
    hostname: 'localhost'

module.exports = config[process.env.NODE_ENV?.toLowerCase() || 'production']
