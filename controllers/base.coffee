module.exports = class BaseController
  constructor: (@app) ->

  mixin: (mixin) ->
    obj = this
    obj[name] = method for name, method of mixin
    obj
