mongoose = require 'mongoose'
validators = require '../services/validators'
autoIncrement = require 'mongoose-auto-increment'

schema = new mongoose.Schema
  title:
    type: String
    required: true
    minLength: 3
  url:
    type: String
    validate: [validators.url, "The url is invalid."]
  date:
    type: Date
    default: -> new Date()
  author:
    type: String
  summary:
    type: String
  feedId:
    type: Number
    required: true

schema.methods =
  setMultiple: (details) ->
    _.extend this, _.pick details||{},
      'title'
      'url'
      'date'
      'author'
      'summary'
      'feedId'

schema.plugin autoIncrement.plugin, model: 'Article', field: 'articleId'
module.exports = mongoose.model 'Article', schema