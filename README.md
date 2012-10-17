# Americano

**What is Americano?** Americano, a CoffeeScript-based framework, is an extra layer of structure on top of Express JS and Mongoose intended to reduce the busy work in creating an organized project structure. We also built code generators into Americano based on the [node-forge](https://github.com/rjz/node-forge) generator framework. Our generators include Controller, Model, _[Socket.io](http://socket.io/) Controller_, and _AdminPanel_ generators. Our inspiration for Americano came from the PHP Codeigniter framework for its simplicity and from Ruby on Rails for its generators and AdminPanel gems. 

**What's with the name?** American industry with the assembly line in the early 20th century propelled the US to become a power in the world. The Americano (CoffeeScript) framework intends to achieve similiar results in aiding Node based web development projects by increasing developer efficiency to focus on application specific logic without the busy work.

**Key Features**

* CoffeeScript
* MVC File Structure
* Twitter Bootstrapified AdminPanel Generator
* Controller and Model Generators
* Socket.io Controller Generator
* ExpressJS Core
* Mongoose

**Node Technologies**

* [ExpressJS 2.x](http://expressjs.com/2x/) _To be updated soon_
* [CoffeeScript](http://coffeescript.org/)
* [Mongoose 2.x](http://mongoosejs.com/docs/2.8.x/) _To be updated soon_
* [Eco Templates](https://github.com/sstephenson/eco)
* [Mocha](http://visionmedia.github.com/mocha/), [Sinon](http://sinonjs.org/), [Zombie](http://zombie.labnotes.org/), [Chai](http://chaijs.com/) Testing Libraries
* [Socket.io](http://socket.io)
* [Node Validator](https://github.com/chriso/node-validator)
* [Q Promises](https://github.com/kriskowal/q)
* [Node-Forge](https://github.com/rjz/node-forge) Customized for Americano
	* Added [Handlebars](http://handlebarsjs.com/) for Templating with the [Swag Library](https://github.com/elving/swag)
	
## Project Set Up

	git clone https://github.com/emumarketing/americano
	
**Temporary Hack Until We Create an NPM Module:** Then remove the the git repo:
	
	rm -rf .git/
	
You are free to init your own git repo now.

Next edit *app.coffee* and change the Express JS like server port configuration. 

To edit your database settings visit *./models/db.coffee* and change the mongoose connect values. 

You should be able to now use the Generators and work on your project.

## Project Folder Structure

	- controllers
	- examples
	- lib
	- models
	- node-forge
	- public
	- routes
	- test
	- views

**controllers** define methods called by the route files and render views.

**examples** are meant to hold examples for files or snippets of code to help developers. Currently it hosts test file examples.

**lib** holds any code libraries that do not fit in the MVC style structure or code that stands on its own. 

**models** provide Mongoose schemas plus access to the Node-Validator library. 

**node-forge** holds the node-forge project customized for Americano in mind which is written in Javascript. Please refer to the node-forge project on how tos for creating additional generators. For americano we use Handlebars with Swag for templating rather than Underscore.

**public** consistent with ExpressJS in storing asset files (CSS, Javascript, Images etc.)

**routes** stores route files each pointing to a controller. The route file calls the apropriate controller method when a route is callled. All controllers are boostrapped and loaded into the routes by the *app.coffee* file.

**test** is a placeholder for storing and calling test files run by the *Cakefile*

**views** is where Eco Templates are stored and organized in folders based on the parent controller. 

## Important Files

	- app.coffee
	- am
	- Cakefile
	- ./models/db.coffee
	
**app.coffee** just as in Express JS it starts the HTTP server process. In Americano it features the code performing the reading of the Controllers directory, and initiating the Controller instances and pushing them to the route files to use. It also bootstraps the routes and initiates them in similiar fashion to the Controllers. 

**am** is the commandline script that calls the node-forge generator. It takes arguments based on which generator you wish to run. 

**Cakefile** is currently used for running the Mocha tests from the test folder. 

**db.coffee** is where your Mongoose configuration is for connecting to your Mongo database. 

## Generator Tutorial

**Note:** The destroy does not delete folders recursively if there are files in them and requires manual intervention sometimes to clean up after a destroy operation on a generator. This is due to the NodeJS recursive delete issue. See [node-forge](https://github.com/rjz/node-forge) project for more details.

###Basic Syntax

	./am [create|destroy] [generator_name] [object_name] [methods or fields]

###Generating a Controller

	./am create controller Blog show edit update delete
	
Creates the Blog controller with associated the methods specified along with the view files needed for each controller method. *Stores the controller in ./controllers/, route file in ./routes/, and views in ./views/*
	
Outputs:

	(controller): Created americano/node-forge/	generators/controller/../../../controllers/Blog.coffee
	(controller): Created americano/node-forge/	generators/controller/../../../routes/blog.coffee
	(controller): Created directory americano/node-forge/generators/controller/../../../views/blog
	(controller): Created americano/node-forge/	generators/controller/../../../views/blog/layout.eco
	(controller): Created americano/node-forge/	generators/controller/../../../views/blog/show.eco
	(controller): Created americano/node-forge/	generators/controller/../../../views/blog/edit.eco
	(controller): Created americano/node-forge/	generators/controller/../../../views/blog/update.eco
	(controller): Created americano/node-forge/	generators/controller/../../../views/blog/delete.eco
	
###Generating a Model

	./am create model Blog title:String created_on:Date post:String
	
Creates the Blog model with the schema fields and their types separated by colons. These schema types are exactly the Mongoose defined types. Please see the Mongoose docs for more info on schema types. *Stores the BlogModel.coffee file in ./models/*

Outputs:

	(model): Created americano/node-forge/generators/model/../../../models/BlogModel.coffee
	
###Generating a Socket Controller

	./am create socket_controller Chat message name_change room_change disconnect 

Creates a Socket.io controller that provides a skeleton for creating "on" events based on the argument methods passed to ./am. This automatically creates a socket.io namespace based on the socket_controller name to prevent conflicts with current socket.io implementations. 

Outputs:

	(socket_controller): Created americano/node-forge/generators/socket_controller/../../../controllers/Chat.coffee
	(socket_controller): Created americano/node-forge/generators/socket_controller/../../../routes/chat.coffee
	(socket_controller): Created directory americano/node-forge/generators/socket_controller/../../../views/chat
	(socket_controller): Created americano/node-forge/generators/socket_controller/../../../views/chat/layout.eco
	(socket_controller): Created americano/node-forge/generators/socket_controller/../../../public/javascripts/chat.js
	(socket_controller): Created americano/node-forge/generators/socket_controller/../../../views/chat/index.eco
	
###AdminPanel Generators

####1. Admin Skeleton Generator

	./am create admin_skeleton StaffPanel # <- Panel Name
	
First step to create an AdminPanel is to create the skeleton which provides the folder structure, authentication and sessions, and user management views for building out a an AdminPanel. 

Outputs:

	(admin_skeleton): Created directory americano/node-forge/generators/admin_skeleton/../../../controllers/staffpanel
	(admin_skeleton): Created directory americano/node-forge/generators/admin_skeleton/../../../views/staffpanel
	(admin_skeleton): Created directory americano/node-forge/generators/admin_skeleton/../../../views/staffpanel/users
	(admin_skeleton): Created directory americano/node-forge/generators/admin_skeleton/../../../views/session
	(admin_skeleton): Created directory americano/node-forge/generators/admin_skeleton/../../../public/stylesheets/staffpanel
	(admin_skeleton): Created directory americano/node-forge/generators/admin_skeleton/../../../public/stylesheets/session
	(admin_skeleton): Created americano/node-forge/generators/admin_skeleton/../../../controllers/StaffPanel.coffee
	(admin_skeleton): Created americano/node-forge/generators/admin_skeleton/../../../controllers/Session.coffee
	(admin_skeleton): Created americano/node-forge/generators/admin_skeleton/../../../controllers/staffpanel/UsersMixin.coffee
	(admin_skeleton): Created americano/node-forge/generators/admin_skeleton/../../../public/stylesheets/staffpanel/style.css
	(admin_skeleton): Created americano/node-forge/generators/admin_skeleton/../../../public/stylesheets/staffpanel/bootstrap.css
	(admin_skeleton): Created americano/node-forge/generators/admin_skeleton/../../../public/stylesheets/session/style.css
	(admin_skeleton): Created americano/node-forge/generators/admin_skeleton/../../../public/stylesheets/session/bootstrap.css
	(admin_skeleton): Created americano/node-forge/generators/admin_skeleton/../../../views/staffpanel/_nav.eco
	(admin_skeleton): Created americano/node-forge/generators/admin_skeleton/../../../views/staffpanel/home.eco
	(admin_skeleton): Created americano/node-forge/generators/admin_skeleton/../../../views/staffpanel/layout.eco
	(admin_skeleton): Created americano/node-forge/generators/admin_skeleton/../../../views/session/layout.eco
	(admin_skeleton): Created americano/node-forge/generators/admin_skeleton/../../../views/session/login.eco
	(admin_skeleton): Created americano/node-forge/generators/admin_skeleton/../../../routes/staffpanel.coffee
	(admin_skeleton): Created americano/node-forge/generators/admin_skeleton/../../../routes/staffpanel_users.coffee
	(admin_skeleton): Created americano/node-forge/generators/admin_skeleton/../../../routes/session.coffee
	(admin_skeleton): Created americano/node-forge/generators/admin_skeleton/../../../views/staffpanel/users/_form.eco
	(admin_skeleton): Created americano/node-forge/generators/admin_skeleton/../../../views/staffpanel/users/_page.eco
	(admin_skeleton): Created americano/node-forge/generators/admin_skeleton/../../../views/staffpanel/users/_search.eco
	(admin_skeleton): Created americano/node-forge/generators/admin_skeleton/../../../views/staffpanel/users/_table.eco
	(admin_skeleton): Created americano/node-forge/generators/admin_skeleton/../../../views/staffpanel/users/create.eco
	(admin_skeleton): Created americano/node-forge/generators/admin_skeleton/../../../views/staffpanel/users/edit.eco
	(admin_skeleton): Created americano/node-forge/generators/admin_skeleton/../../../views/staffpanel/users/index.eco
	(admin_skeleton): Created americano/node-forge/generators/admin_skeleton/../../../views/staffpanel/users/layout.eco
	(admin_skeleton): Created americano/node-forge/generators/admin_skeleton/../../../views/staffpanel/users/search.eco
	(admin_skeleton): Created americano/node-forge/generators/admin_skeleton/../../../models/UsersModel.coffee
	
####2. Admin Datatype Generator

	./am create admin StaffPanel:Blog title:String created_on:Date post:String
	
This creates Admin management pages for the datatype specified. In this case "Blog" is the datatype added to the the StaffPanel admin skeleton resource, creating views, assets, routes, and mixins to the StaffPanel controller. The schema types tell the generator what schema to use and how to generate the HTML forms and other nescessary infrastructure.  

To enable the newly generated datatype, one must require and add the mixin to the controller (./controllers/StaffPanel.coffee) like this:

	# Require any mixins here
	
	BlogMixin = require('./staffpanel/BlogMixin')
	
	module.exports = class StaffPanelController extends BaseController
	
  		constructor: (@app) ->
    		super(@app)
    		# Call the mixin helpers here
    		@mixin(BlogMixin)
    		
Next, to make sure you can login, visit http://[url]/staffpanel and create an admin user you must disable the load user route:

	module.exports = (app, controllers) ->
	  loadUser = controllers.session.loadUser
	
	  ## Comment out this route ## 
	  #app.get '/staffpanel/*', (req, res, next) ->
	    #loadUser(req, res, next)
	
	  app.get "/staffpanel/home", (req, res) ->
	    controllers.staffpanel.action_home(req, res)
	  
	  app.get "/staffpanel", (req, res) ->
	    res.redirect '/staffpanel/home'

Re-enable the route after you visit http://[url]/login and attempt to login with your new user.
	

Output:

	(admin): Created americano/node-forge/generators/admin/../../../models/BlogModel.coffee
	(admin): Created americano/node-forge/generators/admin/../../../controllers/StaffPanel/BlogMixin.coffee
	(admin): Created directory americano/node-forge/generators/admin/../../../views/StaffPanel/blog
	(admin): Created americano/node-forge/generators/admin/../../../views/StaffPanel/Blog/_form.eco
	(admin): Created americano/node-forge/generators/admin/../../../views/StaffPanel/Blog/_page.eco
	(admin): Created americano/node-forge/generators/admin/../../../views/StaffPanel/Blog/_search.eco
	(admin): Created americano/node-forge/generators/admin/../../../views/StaffPanel/Blog/_table.eco
	(admin): Created americano/node-forge/generators/admin/../../../views/StaffPanel/Blog/search.eco
	(admin): Created americano/node-forge/generators/admin/../../../views/StaffPanel/Blog/index.eco
	(admin): Created americano/node-forge/generators/admin/../../../views/StaffPanel/Blog/create.eco
	(admin): Created americano/node-forge/generators/admin/../../../views/StaffPanel/Blog/edit.eco
	(admin): Created americano/node-forge/generators/admin/../../../views/StaffPanel/Blog/layout.eco
	(admin): Created americano/node-forge/generators/admin/../../../routes/staffpanel_blog.coffee
	
## Testing

To run TDD-style testing add your Mocha tests optionally using Sinon and Zombie to the tests folder. Run the following to run all your tests:

	cake test
	
## Contributions

We are happy to examine any pull requests containing enhancements to Americano and welcome any community feedback. 
	
## About The Maintainer

[Michael A Tomcal](https://github.com/mtomcal) of the University of Oregon EMU Marketing team developed Americano in response to the need of an efficient framework for tackling client projects. Americano is currently used in development for a key project and many more are planned. EMU Marketing is a team of student and full time web designers, developers, journalists, and strategists with a love for handcrafted experiences and a passion to be the best that we can be. Please visit our website at [marketing.uoregon.edu](http://marketing.uoregon.edu).

## License






