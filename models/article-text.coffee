mongoose = require 'mongoose'
validators = require '../services/validators'
_ = require 'lodash'

schema = new mongoose.Schema
  text:
    type: String
    minLength: 1

module.exports = mongoose.model 'ArticleText', schema