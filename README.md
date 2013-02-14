# Americano

**What is Americano?** Americano, a CoffeeScript-based framework, is an extra layer of structure on top of Express JS and Mongoose intended to reduce the busy work in creating an organized project structure. We also built code generators into Americano based on the [node-forge](https://github.com/rjz/node-forge) generator framework. Our generators include Controller, Model, and [Socket.io](http://socket.io/) Controller generators. Our inspiration for Americano came from the PHP Codeigniter framework for its simplicity and from Ruby on Rails for its generators. 

**What's with the name?** American industry with the assembly line in the early 20th century propelled the US to become a power in the world. The Americano (CoffeeScript) framework intends to achieve similiar results in aiding Node based web development projects by increasing developer efficiency to focus on application specific logic without the busy work.

**Key Features**

* CoffeeScript
* MVC File Structure
* Controller and Model Generators
* Socket.io Controller Generator
* ExpressJS Core
* Mongoose
* Swig templates (Django-like)

**Node Technologies**

* [ExpressJS 3.x](http://expressjs.com)
* [CoffeeScript](http://coffeescript.org/)
* [Mongoose 3.x](http://mongoosejs.com/docs)
* [Swig Templates](http://paularmstrong.github.com/swig/)
* [Mocha](http://visionmedia.github.com/mocha/), [Sinon](http://sinonjs.org/), [Zombie](http://zombie.labnotes.org/), [Chai](http://chaijs.com/) Testing Libraries
* [Socket.io](http://socket.io)
* [Node Validator](https://github.com/chriso/node-validator)
* [Node-Forge](https://github.com/rjz/node-forge) Customized for Americano
	
## Project Set Up

	git clone https://github.com/emumarketing/americano

Next edit *config/app.json* and change the server port and database configuration to your liking. 

To run the Americano server:

	coffee app.coffee


## Project Folder Structure

	- bundles
	- config
	- controllers
	- core
	- examples
	- lib
	- models
	- public
	- routes
	- test
	- views

**bundles** will in the future hold bundles that follow the americano file structure to be bootstrapped at runtime into the current application

**config** holds json configuration files loaded by the bootstrapper.

**controllers** define methods called by the route files and render views.

**core** holds the core framework libraries for bootstrapping, database support, express, and generators. 

**examples** are meant to hold examples for files or snippets of code to help developers. Currently it hosts test file examples.

**lib** holds any code libraries that do not fit in the MVC style structure or code that stands on its own. 

**models** provide Mongoose schemas plus access to the mongoose-validator (Node-Validator) library. 

**public** consistent with ExpressJS in storing asset files (CSS, Javascript, Images etc.)

**routes** stores route files each pointing to a controller. The route file calls the apropriate controller method when a route is callled. All controllers are boostrapped and loaded into the routes by the _core/bootstrapper_.

**test** is a placeholder for storing and calling test files run by the *Cakefile*

**views** is where Swig Templates are stored and organized in folders based on the parent controller. 

## Generator Tutorial

###Basic Syntax

	./am [create|destroy] [generator_name] [object_name] [methods or fields]

###Generating a Controller

	./am create controller Blog show edit update delete
	
Creates the Blog controller with associated the methods specified along with the view files needed for each controller method. *Stores the controller in ./controllers/, route file in ./routes/, and views in ./views/*
		
###Generating a Model

	./am create model Blog title:String created_on:Date post:String
	
Creates the Blog model with the schema fields and their types separated by colons. These schema types are exactly the Mongoose defined types. Please see the Mongoose docs for more info on schema types. *Stores the BlogModel.coffee file in ./models/*
	
###Generating a Socket Controller

	./am create socket_controller Chat message name_change room_change disconnect 

Creates a Socket.io controller that provides a skeleton for creating "on" events based on the argument methods passed to ./am. This automatically creates a socket.io namespace based on the socket_controller name to prevent conflicts with current socket.io implementations. 
		
## Testing

To run TDD-style testing add your Mocha tests optionally using Sinon and Zombie to the tests folder. Run the following to run all your tests:

	cake test
	
	
## Contributions

We are happy to examine any pull requests containing enhancements to Americano and welcome any community feedback. We are still in the early development stages of this framework and are looking for active contributors to help make this framework great.
	
## About The Maintainer

[Michael A Tomcal](https://github.com/mtomcal) of the University of Oregon EMU Marketing team developed Americano to make building web applications in node and express easier. EMU Marketing is a team of student and full time web designers, developers, journalists, and strategists with a love for handcrafted experiences and a passion to be the best that we can be. Please visit our website at [marketing.uoregon.edu](http://marketing.uoregon.edu).

## License (MIT)

Copyright (c) 2013 University of Oregon

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.




