_ = require 'lodash'
Article = require '../models/article'
ArticleText = require '../models/article-text'

module.exports =
  load: (id, cb) -> Article.findOne {articleId: id}, cb

  index: (req, res, next) ->
    Article.find {feedId: req.feed.feedId}, (err, articles) ->
      return next err if err?
      res.json articles

  create: (req, res, next) ->
    article = new Article
    article.setMultiple req.body
    article.feedId = req.feed.feedId
    article.save (err) ->
      return next err if err?
      res.json article

  show: (req, res) -> res.json req.article

  get:
    text: (req, res, next) ->
      ArticleText.findOne {articleId: req.article.articleId}, (err, articleText) ->
        return next err if err?
        res.text articleText

  post:
    text: (req, res, next) ->
      articleText = new ArticleText text: req.body.text, articleId: req.article.articleId
      articleText.upsert (err) ->
        return next err if err?
        res.send()
