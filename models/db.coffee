mongoose = require('mongoose')
Schema = mongoose.Schema

env = process.env.NODE_ENV

connection =
  'default':     'mongodb://localhost/test1',
  'development': 'mongodb://localhost/test1',
  'testing':     'mongodb://localhost/test1-testing',
  'production':  'mongodb://localhost/test1',

if !env then env = 'default'
mongoose.connect(connection[env])

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

