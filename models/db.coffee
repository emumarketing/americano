mongoose = require('mongoose')
Schema = mongoose.Schema
#mongoose.connect('mongodb://localhost/db')

Validator = require('validator').Validator
validator = new Validator
validator.error = (msg) ->
  return false

exports.Validator = validator

exports.Schema = Schema

exports.Model =
  register: (name, model) ->
    return mongoose.model(name, model)
  ,fetch: (name) ->
    return mongoose.model(name)

