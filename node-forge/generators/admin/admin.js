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

    this.template('model.coffee.hbs',  this.project_dir + '/models/' + dataname + 'Model.coffee', {name: dataname + "Model", data: datatypes, dataname: dataname, resource: resource});
    this.template('./mixins/mixin.coffee.hbs',  this.project_dir + '/controllers/' + resource + '/' + dataname + 'Mixin.coffee', params);
    this.mkdir(this.project_dir + '/views/' + resource + '/' + dataname.toLowerCase());
    this.template('./subviews/_form.eco.hbs',  this.project_dir + '/views/' + resource + '/' + dataname + '/_form.eco', params);
    this.template('./subviews/_page.eco.hbs',  this.project_dir + '/views/' + resource + '/' + dataname + '/_page.eco', params);
    this.template('./subviews/_search.eco.hbs',  this.project_dir + '/views/' + resource + '/' + dataname + '/_search.eco', params);
    this.template('./subviews/_table.eco.hbs',  this.project_dir + '/views/' + resource + '/' + dataname + '/_table.eco', params);
    this.template('./subviews/search.eco.hbs',  this.project_dir + '/views/' + resource + '/' + dataname + '/search.eco', params);
    this.template('./subviews/index.eco.hbs',  this.project_dir + '/views/' + resource + '/' + dataname + '/index.eco', params);
    this.template('./subviews/create.eco.hbs',  this.project_dir + '/views/' + resource + '/' + dataname + '/create.eco', params);
    this.template('./subviews/edit.eco.hbs',  this.project_dir + '/views/' + resource + '/' + dataname + '/edit.eco', params);
    this.template('./subviews/layout.eco.hbs',  this.project_dir + '/views/' + resource + '/' + dataname + '/layout.eco', params);
    this.template('./routes/mixin_routes.coffee.hbs',  this.project_dir + '/routes/' + resource.toLowerCase() + '_' + dataname.toLowerCase() + '.coffee', params);


  },

});
