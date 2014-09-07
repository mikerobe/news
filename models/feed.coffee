mongoose = require 'mongoose'
validators = require '../services/validators'
_ = require 'lodash'

schema = new mongoose.Schema
  title:
    type: String
    required: true
    minLength: 3
    unique: true
  url:
    type: String
    validate: [validators.url, "The url is invalid."]
    unique: true
  lastRefresh:
    type: Date
    default: new Date(0)
  refreshMillis:
    type: Number
    default: 5 * 60 * 1000
  tags:
    type: [ String ]
    index: true

schema.methods =
  setMultiple: (details) ->
    _.extend this, _.pick details||{},
      'title'
      'url'
      'refreshMillis'
      'tags'

module.exports = mongoose.model 'Feed', schema