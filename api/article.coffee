_ = require 'lodash'
Article = require '../models/article'
ArticleText = require '../models/article-text'
mongoose = require 'mongoose'

module.exports =
  load: (id, cb) -> Article.findById id, cb

  index: (req, res, next) ->
    Article.find {feed: req.feed.id}, (err, articles) ->
      return next err if err?
      res.json articles

  create: (req, res, next) ->
    if req.body and _.isArray(articles = req.body.documents) and Object.keys(req.body).length is 1
      article._id ||= new mongoose.Types.ObjectId for article in articles
      Article.bulkInsert articles, (err, jsonArray) ->
        return next err if err?
        req.publish _.filter jsonArray
        res.send ids: jsonArray.map (article) -> article && article._id
    else
      article = new Article
      article.setMultiple req.body
      article.feed = req.feed.id
      req.publish article
      article.save (err) ->
        return next err if err?
        res.send id: article.id.toString()

  show: (req, res) -> res.json req.article

  get:
    text: (req, res, next) ->
      ArticleText.findById req.article.id, (err, articleText) ->
        return next err if err?
        res.text articleText

  post:
    text: (req, res, next) ->
      articleText = new ArticleText text: req.body.text
      articleText.upsert req.article.id, (err) ->
        return next err if err?
        res.send()
