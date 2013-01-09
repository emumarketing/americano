require "coffee-script"
bootstrapper = require "./core/bootstrapper"

americano = bootstrapper()

americano.listen(8004)

#module.exports = americano.express

