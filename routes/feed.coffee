Feed = require '../models/feed'
formatError = require '../services/format-error'

module.exports = (router) ->
  router.route('/feeds')

    .get((req, res) ->
      Feed.find (err, feeds) ->
        if err?
          res.status(400).json
            message: formatError err
        else
          res.json feeds
    )

    .post((req, res) ->
      feed = new Feed
      feed.setMultiple req.body
      feed.save (err) ->
        if err?
          res.status(400).json
            message: formatError err
        else
          res.json feed
    )
