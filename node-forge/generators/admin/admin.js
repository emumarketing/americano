var Generator = require('./../../src/Generator')
, _ = require("underscore");

/**
 *	A generator
 */
module.exports = Generator.extend({
	
    // set the generator name
	key: 'admin',

  project_dir: __dirname + '/../../..',

    /**
	 *	What to do on setup (will be reversed for teardown)
	 *	@param	{String}	name	the name of the object being generated
	 *	@param	{Object}	options	a list of options being passed to the generator
	 */
	create: function (name, options) {
    var datatypes = {};

    _.each(options, function (item) {
      var ary = item.split(':');
      datatypes[ary[0]] = ary[1];
    }); 

    this.template('model.coffee',  this.project_dir + '/models/' + name + '.coffee', { name: name, data: datatypes });
  },

});
