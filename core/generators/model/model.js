var Generator = require('./../../node-forge/src/Generator');
var _ = require("underscore")
var americano = require('./../americano');

/**
 *	A generator
 */
module.exports = Generator.extend({
	
    // set the generator name
	key: 'model',
  project_dir: americano.generatorpath,

  /**
	 *	What to do on setup (will be reversed for teardown)
	 *	@param	{String}	name	the name of the object being generated
	 *	@param	{Object}	options	a list of options being passed to the generator
	 */
  create: function (name, options) {
    datatypes = {}
    _.each(options, function (item) {
      var ary = item.split(':');
      datatypes[ary[0]] = ary[1];
    }); 

    this.template('model.coffee.tmpl',  this.project_dir + '/models/' + name + 'Model.coffee', {name: name + "Model", data: datatypes});


  }
});
