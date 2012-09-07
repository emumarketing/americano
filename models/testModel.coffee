BaseModel = require('./baseModel')

module.exports = class testModel
  constructor: ->
    BaseModel = BaseModel.Singleton.get("BaseModel")
    @mongoose = BaseModel.mongoose
    @Schema = BaseModel.Schema
