mongoose = require 'mongoose'
validators = require '../services/validators'
_ = require 'lodash'

schema = new mongoose.Schema
  title:
    type: String
    required: true
    minLength: 3
  url:
    type: String
    validate: [validators.url, "The url is invalid."]
    unique: true
  date:
    type: Date
    default: -> new Date()
  author:
    type: String
  summary:
    type: String
  feed:
    type: mongoose.Schema.Types.ObjectId
    required: true
    index: true

schema.methods =
  setMultiple: (details) ->
    _.extend this, _.pick details||{},
      'title'
      'url'
      'date'
      'author'
      'summary'
      'feedId'

module.exports = mongoose.model 'Article', schema