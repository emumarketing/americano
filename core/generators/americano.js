//Configuration
var path = require("path");
var fs = require("fs");
var americano = {}

americano.generatorpath = path.join(path.dirname(fs.realpathSync(__filename)), '../..');

module.exports = americano;

