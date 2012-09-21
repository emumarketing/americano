# Cakefile

{exec} = require "child_process"

REPORTER = "spec"

task "test", "run tests", ->
  exec "NODE_ENV=testing
    ./node_modules/.bin/mocha 
    --compilers coffee:coffee-script
    --reporter #{REPORTER}
    --require coffee-script 
    --require ./test/test_helper.coffee
  ", (err, output) ->
    throw err if err
    console.log output
