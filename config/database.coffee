config =
  development:
    url: "mongodb://localhost:27017/news"

  production:
    url: "mongodb://localhost:27017/news"

module.exports = config[process.env.NODE_ENV?.toLowerCase() || 'production']
