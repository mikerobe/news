_ = require 'lodash'
Article = require '../models/article'

module.exports =
  load: (id, cb) -> Article.find {articleId: id}, (err, articles) -> cb err, articles?[0]

  index: (req, res, next) ->
    Article.find (err, articles) ->
      return next err if err?
      res.json articles

  create: (req, res, next) ->
    article = new Article
    article.setMultiple req.body
    article.save (err) ->
      return next err if err?
      res.json article

  show: (req, res) -> res.json req.article

  get:
    text: (req, res) -> res.text req.article.text
