PaginationHelper = require('../lib/pagination_helper')
BlogModel = require('../models/BlogModel')
Q = require("q")

describe 'PaginationHelper', ->

  describe 'Pagination Helper Initializes', ->
    it 'accepts page', ->
      assert.ok(new PaginationHelper(2))

  describe 'method testing', ->

    describe 'render method', ->
        ph = new PaginationHelper(2)
        result = {}

        before (done) ->
          ph.render BlogModel, {}, (err, res) ->
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
        
        describe 'render output testing', ->
          result = undefined

          before (done) ->
            ph = new PaginationHelper(1)
            ph.render BlogModel, {}, (err, res) ->
              result = res
              done()

          it 'returns a number for num_pages', ->
            assert.isNumber(result.num_pages)
            
          it 'returns one if count is zero', ->
            num_pages = ph.pages(0)
            assert.strictEqual(num_pages, 1)

          it 'returns a number for current_page', ->
            assert.isNumber(result.current_page)

          it 'returns string for prev_class', ->
            assert.isString(result.prev_class)

          it 'returns string for next_class', ->
            assert.isString(result.next_class)

          it 'returns a function for paged_route', ->
            assert.isFunction(result.paged_route)

          it 'returns a function for get_inputs', ->
            assert.isFunction(result.get_inputs)

          it 'returns an empty string for _paged_route', ->
            assert.strictEqual(result._paged_route, "")

          it 'returns an empty string for _get_inputs', ->
            assert.strictEqual(result._get_inputs, "")

          describe 'returned helper functions work', ->

            it 'setting a paged_route works', ->
              result.paged_route(result, "search")
              assert.strictEqual(result._paged_route, "search/")

            it 'setting get_inputs works', ->
              result.get_inputs(result, {search: "testing"})
              assert.strictEqual(result._get_inputs, "?search=testing&")


    describe 'results method', ->

      it 'exists', ->
        assert.property(new PaginationHelper(1), 'results')

      it 'returns an object', (done) ->
        ph = new PaginationHelper(1)
        results_promise = ph.results BlogModel, {}
        results_promise.then (items) ->
          assert.isArray(items)
          done()

    describe 'retrieve query count method', ->

      ph = new PaginationHelper(1)

      it 'has a query_count method', ->
        assert.property(ph, 'query_count')

      it 'returns a number', (done) ->
        results = ph.query_count BlogModel, {}
        results.then (count) ->
          assert.isNumber(count)
          done()

    describe 'retrieve number of pages method', ->

      ph = new PaginationHelper(1)

      it 'has a pages method', ->
        assert.property(ph, 'pages')

      it 'returns number of pages', -> 
        pages = ph.pages 130
        assert.isNumber(pages)
      it 'returns correct number of pages', ->
        ph.limit = 50
        pages = ph.pages 130
        assert.strictEqual(pages, 3)

    describe 'check whether disabling the previous pagination class is needed', ->
      ph = undefined

      beforeEach ->
        ph = new PaginationHelper(1)

      it 'has a prev_class method', ->
        assert.property(ph, 'prev_class')

      it 'returns a string', ->
        prev_class = ph.prev_class 1
        assert.isString(prev_class)

      it 'returns "disabled" when the num of pages is one', ->
        prev_class = ph.prev_class 1
        assert.strictEqual(prev_class, "disabled")
      
      it 'returns "disabled" when current page is one', ->
        prev_class = ph.prev_class 10 
        assert.strictEqual(prev_class, "disabled")

      it 'returns "" when num of pages is 10 and current page is 2', ->
        ph.page = 2
        prev_class = ph.prev_class 10
        assert.strictEqual(prev_class, "")

    describe 'check whether disabling the next pagination class is needed', ->
      ph = undefined

      beforeEach ->
        ph = new PaginationHelper(1)

      it 'has a next_class method', ->
        assert.property(ph, 'next_class')

      it 'returns a string', ->
        next_class = ph.next_class 1
        assert.isString(next_class)

      it 'returns "disabled" when the num of pages is one', ->
        next_class = ph.next_class 1
        assert.strictEqual(next_class, "disabled")
      
      it 'returns "disabled" when current page is equal to total pages', ->
        ph.page = 10
        next_class = ph.next_class 10 
        assert.strictEqual(next_class, "disabled")

      it 'returns "" when num of pages is 10 and current page is 2', ->
        ph.page = 2
        next_class = ph.next_class 10
        assert.strictEqual(next_class, "")

    describe 'check next page method', ->

      ph = undefined

      beforeEach ->
        ph = new PaginationHelper(3)

      it 'has a next_page method', ->
        assert.property(ph, 'next_page')

      it 'returns a number', ->
        assert.isNumber(ph.next_page(1))

      it 'returns current page if current page equals total number of pages', ->
        ph.page = 10 
        next_page = ph.next_page(10)
        assert.strictEqual(next_page, 10)

      it 'returns the next page number when > one', ->
        ph.page = 4 
        next_page = ph.next_page(10)
        assert.strictEqual(next_page, 5)

    describe 'check prev page method', ->

      ph = undefined

      beforeEach ->
        ph = new PaginationHelper(3)

      it 'has a prev_page method', ->
        assert.property(ph, 'prev_page')

      it 'returns a number', ->
        assert.isNumber(ph.prev_page())

      it 'returns one if current page is one', ->
        ph.page = 1
        prev_page = ph.prev_page()
        assert.strictEqual(prev_page, 1)

      it 'returns 3 when current page is 4', ->
        ph.page = 4
        prev_page = ph.prev_page()
        assert.strictEqual(prev_page, 3)










