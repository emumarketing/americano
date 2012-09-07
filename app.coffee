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

AdminController = require('./controllers/admin')
adminController = new AdminController app

app.get "/", (req, res) ->
  res.render "home"

app.get "/admin/home", adminController.home

app.get "/admin/blog", adminController.blogIndex

app.get "/admin/blog/create", adminController.blogCreate

app.post "/admin/blog/new", adminController.blogNew

app.get "/admin/blog/edit/:slug", adminController.blogEdit

app.post "/admin/blog/update/:slug", adminController.blogUpdate

app.get "/admin", (req, res) ->
  res.redirect '/admin/home'

app.listen 8004

#Libraries

