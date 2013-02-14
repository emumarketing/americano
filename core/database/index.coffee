#Loading all the needed classes for Models to work and establishing
#a database connection based on values in the config.

Mongoose = require('mongoose')
Validator = require('mongoose-validator').validate

module.exports = (americano) =>

  americano.validator = Validator

  americano.model = {}

  env = americano.config.environment 

  if !env then env = 'default'

  Mongoose.connect(americano.config.database[env])

  americano.model.schema = Mongoose.Schema

  americano.model.register = (name, model) ->
    Mongoose.model(name, model)

    americano.model[name] = ->
      return Mongoose.model(name)

  return americano


  
