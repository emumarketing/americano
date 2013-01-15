var Generator = require('./../../node-forge/src/Generator');
var americano = require('../americano');
var path = require("path");
var fs = require("fs");

/**
 *	A generator
 */
module.exports = Generator.extend({

  // set the generator name
  key: 'controller',

  project_dir: americano.generatorpath,

  /**
   *	What to do on setup (will be reversed for teardown)
   *	@param	{String}	name	the name of the object being generated
   *	@param	{Object}	options	a list of options being passed to the generator
   */
  create: function (name, options) {

    function makeLowerCase(string) {
      return string.toLowerCase();
    }

    options = options.map(makeLowerCase)

    var params = {name: name, methods: options};
    this.template('controller.coffee.tmpl', this.project_dir + '/controllers/' + name + '.coffee', params);  
    this.template('routes.coffee.tmpl', this.project_dir + '/routes/' + name.toLowerCase() + '.coffee', params);  
    this.mkdir(this.project_dir + '/views/' + name.toLowerCase());
    this.template('layout.swig.tmpl', this.project_dir + '/views/' + name.toLowerCase() + '/layout.swig', params);  

    for (i in options) {
      this.template('view.swig.tmpl', this.project_dir + '/views/' + name.toLowerCase() + '/' + options[i].toLowerCase() + '.swig', {name: name, method: options[i]});
    }
  }
});
