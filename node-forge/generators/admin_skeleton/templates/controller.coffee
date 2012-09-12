BaseController = require('./base')

module.exports = class {{name}}Controller extends BaseController

  constructor: (@app) ->
    super(@app)

  home: (req, res) =>
    res.render "{{name}}/home"
    return

    



















































