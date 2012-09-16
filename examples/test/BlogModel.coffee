BlogModel = require('../models/BlogModel')

describe "Blog Model", ->
  it 'should find all records without errors', (done) ->
    BlogModel.find {}, (err, items) ->
      assert.isNull(err)
      done()
