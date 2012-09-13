require("coffee-script")
express = require("express")
app = express.createServer()
less = require("less-middleware")
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

AdminPanelController = require('./controllers/AdminPanel')
adminController = new AdminPanelController app

app.get "/", (req, res) ->
  res.render "home"

app.get "/adminpanel/home", adminController.action_home

app.get "/adminpanel/blog", adminController.action_index

app.get "/adminpanel/blog/create", adminController.action_create

app.post "/adminpanel/blog/new", adminController.action_new

app.get "/adminpanel/blog/edit/:slug", adminController.action_edit

app.post "/adminpanel/blog/update/:slug", adminController.action_update

app.get "/adminpanel", (req, res) ->
  res.redirect '/adminpanel/home'

app.listen 8004

#Libraries

