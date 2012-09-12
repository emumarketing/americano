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
	create: function (namespace, options) {
    var datatypes = {};
    var resource = namespace.split(':')[0];
    var dataname = namespace.split(':')[1];

    _.each(options, function (item) {
      var ary = item.split(':');
      datatypes[ary[0]] = ary[1];
    }); 

    var params = {name: dataname, data: datatypes, dataname: dataname, resource: resource};

    this.template('model.coffee',  this.project_dir + '/models/' + dataname + 'Model.coffee', { name: dataname + "Model", data: datatypes, dataname: dataname, resource: resource});
    this.template('./mixins/mixin.coffee',  this.project_dir + '/controllers/' + resource + '/' + dataname + '.coffee', params);
    this.mkdir(this.project_dir + '/views/' + resource + '/' + dataname);
    this.template('./subviews/_form.eco',  this.project_dir + '/views/' + resource + '/' + dataname + '/_form.eco', params);
    this.template('./subviews/index.eco',  this.project_dir + '/views/' + resource + '/' + dataname + '/index.eco', params);
    this.template('./subviews/create.eco',  this.project_dir + '/views/' + resource + '/' + dataname + '/create.eco', params);
    this.template('./subviews/edit.eco',  this.project_dir + '/views/' + resource + '/' + dataname + '/edit.eco', params);
    this.template('./subviews/layout.eco',  this.project_dir + '/views/' + resource + '/' + dataname + '/layout.eco', params);

  },

});
