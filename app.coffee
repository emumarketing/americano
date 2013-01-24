require "coffee-script"
bootstrapper = require "./core/bootstrapper"

americano = bootstrapper()

americano.listen(8004)

console.log("Americano Ready and Able on port: " + americano.config.port)

#module.exports = americano.express

