# Takes an Americano object argument for all configuration data.
# Uses: americano.secret, americano.cookies, americano.path

module.exports = (americano) =>
  express = require "express"
  less = require "less-middleware"
  eco = require "eco"
  app = express.createServer()

  app.set "views", americano.path + "/views"
  app.set 'view engine', 'eco'
  app.set "view options",
    layout: true
    pretty: true

    app.configure ->
      app.use express.bodyParser()
      app.use express.cookieParser()
      app.use express.session(
        secret: americano.secret,
        cookie: americano.cookies, #{maxAge: 60000 * 20} #20 minutes
      )
      app.use less(
        src: americano.path + "/public"
        force: true
        compress: "auto"
        optimization: 2
      )
      app.use express.static(americano.path + "/public")
      app.use app.router

      return app
