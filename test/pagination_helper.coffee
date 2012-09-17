PaginationHelper = require('../lib/pagination_helper')
BlogModel = require('../models/BlogModel')

describe 'PaginationHelper', ->

  describe 'Pagination Helper Initializes', ->
    it 'accepts page', ->
      assert.ok(new PaginationHelper(2))

  describe 'Render returns', ->
    ph = new PaginationHelper(2)
    result = {}

    before (done) ->
      ph.render BlogModel, {}, (res) ->
        result = res
        done()

    it 'returns object', ->
      assert.isObject(result)

    it 'returns object with num_pages', ->
      assert.property(result, "num_pages")

    it 'returns object with current_page', ->
      assert.property(result, 'current_page')

    it 'returns object with prev_class', ->
      assert.property(result, 'prev_class')

    it 'returns object with next_class', ->
      assert.property(result, 'next_class')
    
  describe 'logic testing', ->
    result = undefined

    before (done) ->
      ph = new PaginationHelper(1)
      ph.render BlogModel, {}, (res) ->
        result = res
        done()

    it 'returns a number for num_pages', ->
      assert.isNumber(result.num_pages)

    it 'returns a number for current_page', ->
      assert.isNumber(result.current_page)

    it 'returns string for prev_class', ->
      assert.isString(result.prev_class)

    it 'returns string for next_class', ->
      assert.isString(result.next_class)

  describe 'results method', ->

    it 'exists', ->
      assert.property(new PaginationHelper(1), 'results')

    it 'returns an object', (done) ->
      ph = new PaginationHelper(1)
      ph.results BlogModel, {}, (err, items) ->
        assert.isArray(items)
        done()




