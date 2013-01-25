module.exports = () ->

  fs = require("fs")
  path = require("path")
  events = require('events')


  americano = {}

  americano.do = new events.EventEmitter()

  americano.path = path.join(path.dirname(fs.realpathSync(__filename)), '../../')
  americano.corepath = path.join(path.dirname(fs.realpathSync(__filename)), '../')

  americano.config = require(americano.path + "/config/app.json")

  americano.controllers = {}

  # Controller Bootstrapper
  americano.load_controllers = () =>
    fs.readdirSync(americano.path + "/controllers").forEach (file) ->
      if file_name = file.match(/(\w+)\.coffee$/)
        className = file_name[1].toLowerCase()
        klass = require(americano.path + "/controllers/" + file)
        americano.controllers[className] = new klass(americano)

  # Routes Bootstrapper
  americano.load_routes = () =>
    fs.readdirSync(americano.path + "/routes").forEach (file) ->
      if file_name = file.match(/[\w|\_]+\.coffee$/)
        route_file = require(americano.path + '/routes/' + file_name[0])
        if route_file instanceof Function
          route_file(americano)

  #Model Bootstrapper
  americano.load_models = () =>
    fs.readdirSync(americano.path + "/models").forEach (file) ->
      if file_name = file.match(/[\w|\_]+\.coffee$/)
        model_name = file_name[0].split(".")[0]
        model_name = model_name.toLowerCase()
        model_file = require(americano.path + '/models/' + file_name[0])
        if model_file instanceof Function
          americano.model.register(model_name, model_file(americano))

  americano.load_express = () =>
    express = require(americano.corepath + '/express')
    americano.express = express(americano)

  americano.load_database = () =>
    database = require(americano.corepath + '/database')
    americano = database(americano)

  americano.load_core_libraries = () =>

  americano.load_bundles = () =>

  americano.debug = () =>
    #console.log(americano.model)
    #BlogModel = americano.model.blogmodel()
    #BlogModel.find({}).exec((err, data) ->
    #  console.log(data)
    #)
    
    #americano.do.on('blah', (data) ->
    #  console.log(data)
    #)
    #americano.do.emit('blah', {test: "ing"})

  americano.listen = (port) =>
    americano.load_express()
    americano.load_database()
    americano.load_core_libraries()
    americano.load_bundles()
    americano.load_models()
    americano.load_controllers()
    americano.load_routes()
    americano.express.listen(port)
    americano.debug()

  return americano
