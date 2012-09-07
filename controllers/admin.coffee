BaseController = require('./base')
BlogMixin = require('./admin/blog')

module.exports = class AdminController extends BaseController

  constructor: (@app) ->
    super(@app)
    @mixin BlogMixin

  home: (req, res) =>
    res.render "admin/home"
    return

    



















































