var Generator = require('./../../src/Generator');

/**
 *	A generator
 */
module.exports = Generator.extend({

  // set the generator name
  key: 'admin_skeleton',

  project_dir: __dirname + '/../../..',

  /**
   *	What to do on setup (will be reversed for teardown)
   *	@param	{String}	name	the name of the object being generated
   *	@param	{Object}	options	a list of options being passed to the generator
   */
  create: function (name, options) {
    this.mkdir(this.project_dir + '/controllers/' + name);
    this.template('controller.coffee', this.project_dir + '/controllers/' + name + '.coffee', { name: name });  
    this.mkdir(this.project_dir + '/views/' + name);
    this.template('./public/stylesheets/style.css', this.project_dir + '/public/stylesheets/style.css', {});  
    this.template('./public/stylesheets/bootstrap.css', this.project_dir + '/public/stylesheets/bootstrap.css', {});  
    this.template('./views/_nav.eco', this.project_dir + '/views/' + name + '/_nav.eco', { name: name });  
    this.template('./views/home.eco', this.project_dir + '/views/' + name + '/home.eco', { name: name });  
    this.template('./views/layout.eco', this.project_dir + '/views/' + name + '/layout.eco', { name: name });  

  }
});
