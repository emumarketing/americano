module.exports = () ->

  fs = require("fs")
  path = require("path")

  americano = {}
  americano.path = path.join(path.dirname(fs.realpathSync(__filename)), '../../')
  americano.corepath = path.join(path.dirname(fs.realpathSync(__filename)), '../')

  americano.cookies = {maxAge: 60000 * 20}
  americano.secret = 'americano'

  americano.controllers = {}

  # Controller Bootstrapper
  americano.load_controllers = () =>
    fs.readdirSync(americano.path + "/controllers").forEach (file) ->
      if file_name = file.match(/(\w+)\.coffee$/)
        className = file_name[1].toLowerCase()
        klass = require(americano.path + "/controllers/" + file)
        americano.controllers[className] = new klass(americano.express)

  # Routes Bootstrapper
  americano.load_routes = () =>
    fs.readdirSync(americano.path + "/routes").forEach (file) ->
      if file_name = file.match(/[\w|\_]+\.coffee$/)
        route_file = require(americano.path + '/routes/' + file_name[0])
        if route_file instanceof Function
          route_file(americano.express, americano.controllers)

  americano.load_express = () =>
    express = require(americano.corepath + '/express')
    americano.express = express(americano)

  americano.load_core_libraries = () =>

  americano.load_bundles = () =>

  americano.listen = (port) =>
    americano.load_express()
    americano.load_core_libraries()
    americano.load_bundles()
    americano.load_controllers()
    americano.load_routes()
    americano.express.listen(port)

  return americano
