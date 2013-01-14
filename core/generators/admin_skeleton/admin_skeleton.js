var Generator = require('./../../node-forge/src/Generator');
var americano = require('./../americano');

/**
 *	A generator
 */
module.exports = Generator.extend({

  // set the generator name
  key: 'admin_skeleton',

  project_dir: americano.generatorpath,

  /**
   *	What to do on setup (will be reversed for teardown)
   *	@param	{String}	name	the name of the object being generated
   *	@param	{Object}	options	a list of options being passed to the generator
   */
  create: function (name, options) {

    //Mkdirs 
    this.mkdir(this.project_dir + '/controllers/' + name.toLowerCase());
    this.mkdir(this.project_dir + '/views/' + name.toLowerCase());
    this.mkdir(this.project_dir + '/views/' + name.toLowerCase() + '/users');
    this.mkdir(this.project_dir + '/views/session');
    this.mkdir(this.project_dir + '/public/stylesheets/' + name.toLowerCase());
    this.mkdir(this.project_dir + '/public/stylesheets/session');


    //Controllers and Mixins
    this.template('controller.coffee.hbs', this.project_dir + '/controllers/' + name + '.coffee', { name: name });  
    this.template('Session.coffee.hbs', this.project_dir + '/controllers/Session.coffee', { name: name });  
    this.template('UsersMixin.coffee.hbs', this.project_dir + '/controllers/' + name.toLowerCase() + '/UsersMixin.coffee', { name: name });  


    //Public Styles
    this.template('./public/stylesheets/style.css', this.project_dir + '/public/stylesheets/' + name.toLowerCase() + '/style.css', {});  
    this.template('./public/stylesheets/bootstrap.css', this.project_dir + '/public/stylesheets/' + name.toLowerCase() + '/bootstrap.css', {});  
    this.template('./public/stylesheets/session_style.css', this.project_dir + '/public/stylesheets/session/style.css', {});  
    this.template('./public/stylesheets/bootstrap.css', this.project_dir + '/public/stylesheets/session/bootstrap.css', {});  

    //Skeleton Views
    this.template('./views/_nav.eco.hbs', this.project_dir + '/views/' + name.toLowerCase() + '/_nav.eco', { name: name });  
    this.template('./views/home.eco.hbs', this.project_dir + '/views/' + name.toLowerCase() + '/home.eco', { name: name });  
    this.template('./views/layout.eco.hbs', this.project_dir + '/views/' + name.toLowerCase() + '/layout.eco', { name: name });  

    //Session Views
    this.template('./views/session/layout.eco.hbs', this.project_dir + '/views/session/layout.eco', { name: name });  
    this.template('./views/session/login.eco.hbs', this.project_dir + '/views/session/login.eco', { name: name });  

    //Routes
    this.template('./routes/controller_routes.coffee.hbs',  this.project_dir + '/routes/' + name.toLowerCase() + '.coffee', {name: name});
    this.template('./routes/routes_users.coffee.hbs',  this.project_dir + '/routes/' + name.toLowerCase() + '_users.coffee', {name: name});
    this.template('./routes/session.coffee.hbs',  this.project_dir + '/routes/session.coffee', {name: name});

    //Users Views
    this.template('./views/users/_form.eco.hbs', this.project_dir + '/views/' + name.toLowerCase() + '/users/_form.eco', { name: name });  
    this.template('./views/users/_page.eco.hbs', this.project_dir + '/views/' + name.toLowerCase() + '/users/_page.eco', { name: name });  
    this.template('./views/users/_search.eco.hbs', this.project_dir + '/views/' + name.toLowerCase() + '/users/_search.eco', { name: name });  
    this.template('./views/users/_table.eco.hbs', this.project_dir + '/views/' + name.toLowerCase() + '/users/_table.eco', { name: name });  
    this.template('./views/users/create.eco.hbs', this.project_dir + '/views/' + name.toLowerCase() + '/users/create.eco', { name: name });  
    this.template('./views/users/edit.eco.hbs', this.project_dir + '/views/' + name.toLowerCase() + '/users/edit.eco', { name: name });  
    this.template('./views/users/index.eco.hbs', this.project_dir + '/views/' + name.toLowerCase() + '/users/index.eco', { name: name });  
    this.template('./views/users/layout.eco.hbs', this.project_dir + '/views/' + name.toLowerCase() + '/users/layout.eco', { name: name });  
    this.template('./views/users/search.eco.hbs', this.project_dir + '/views/' + name.toLowerCase() + '/users/search.eco', { name: name });  


    //UsersModel
    this.template('./models/UsersModel.coffee.hbs',  this.project_dir + '/models/UsersModel.coffee', {name: name});

  }
});
