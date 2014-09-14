Feed = require '../models/feed'

module.exports =
  load: (id, cb) -> Feed.findById id, cb

  index: (req, res, next) ->
    Feed.find (err, feeds) ->
      return next err if err?
      res.json feeds

  create: (req, res, next) ->
    feed = new Feed
    feed.setMultiple req.body
    feed.save (err) ->
      return next err if err?
      req.publish feed
      res.json id: feed._id

  show: (req, res) -> res.json req.feed
