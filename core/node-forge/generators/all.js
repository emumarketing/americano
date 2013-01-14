// scan generators/ for known generators
var fs = require('fs');

var generators = {},
	dir = __dirname + '/../../generators/',
	me = __filename.substr(dir.length);
// check this directory for all javascript files that aren't this one.
files = fs.readdirSync(dir);
files.forEach(function (generator) {
	var path = dir + generator + "/" + generator + ".js";

	if (fs.existsSync(path)) {
		generators[generator] = new (require(path));
	}
});

module.exports = generators;
