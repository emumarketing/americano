require "coffee-script"
express = require "express"
app = express.createServer()
less = require "less-middleware"
eco = require "eco"

app.set "views", __dirname + "/views"
app.set 'view engine', 'eco'
app.set "view options",
  layout: true
  pretty: true


app.configure ->
  app.use express.bodyParser()
  app.use less(
    src: __dirname + "/public"
    force: true
    compress: "auto"
    optimization: 2
  )
  app.use express.static(__dirname + "/public")
  app.use app.router


# Controller Bootstrapper

controllers = {}

require("fs").readdirSync(__dirname + "/controllers").forEach (file) ->
  if fileName = file.match(/(\w+)\.coffee/)

    className = fileName[1].toLowerCase()

    klass = require(__dirname + "/controllers/" + file)

    controllers[className] = new klass(app)

# Routes Bootstrapper

require("fs").readdirSync(__dirname + "/routes").forEach (file) ->
  if fileName = file.match(/[\w|\_]+\.coffee/)
    require(__dirname + '/routes/' + fileName[0])(app, controllers)

# Custom Routes

app.get "/", (req, res) ->
  res.render "home"


app.listen 8004

module.exports = app

#Libraries

