_ = require 'lodash'
mongoose = require 'mongoose'

require('express/lib/response').text = (body) ->
  @set 'Content-Type', 'text/plain'
  @send body

_.extend mongoose.Model.prototype,
  upsert: (id, cb) ->
    this.constructor.findByIdAndUpdate id, _.omit(this.toObject(), '_id', '__v'), {upsert: true}, cb

_.extend mongoose.Model,
  bulkInsert: (jsonArray, cb) ->
    mongoose.connection.db.command {
      insert: this.collection.name
      documents: jsonArray
      ordered: false
    }, (err, reply) ->
      return cb err if err?
      
      if errors = reply.writeErrors
        for err in errors
          jsonArray[err.index] = null

      cb null, jsonArray


