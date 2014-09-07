mongoose = require 'mongoose'
validators = require '../services/validators'
_ = require 'lodash'

schema = new mongoose.Schema
  articleId:
    type: Number
    required: true
    unique: true
  text:
    type: String
    minLength: 1

schema.methods =
  upsert: (cb) ->
    this.constructor.findOneAndUpdate {articleId: this.articleId}, _.omit(this.toObject(), '_id', '__v'), {upsert: true}, cb

module.exports = mongoose.model 'ArticleText', schema