Q = require("q")
module.exports = class PaginationHelper

  constructor: (page) ->
    @page = if page then parseInt(page) else 1
    @limit = 1

  render: (model, query, cb) =>
    self = @ 

    count_promise = @query_count model, query
    result_promise = @results model, query

    Q.all([count_promise, result_promise])

    .fail (errors) ->
      cb(errors, {})

    .then (results) ->

      count = results[0]
      query_results = results[1]
      pages = self.pages(count)
      prev_class = self.prev_class(pages)
      next_class = self.next_class(pages)
      prev_page = self.prev_page(pages)
      next_page = self.next_page(pages)

      cb(null, {
        num_pages: pages, 
        current_page: self.page,
        prev_class: prev_class,
        next_class: next_class,
        prev_page: prev_page,
        next_page: next_page,
        results: query_results,
        paged_route: self.paged_route,
        get_inputs: self.get_inputs,
        _paged_route: "",
        _get_inputs: "",
      })
    
    return

  results: (model, query) ->
    defer = Q.defer()
    offset = (@limit * @page) - @limit
    q = model.find(query).limit(@limit).skip(offset)
    q.exec (err, items) ->
      if err
        defer.reject(err)
      else
        defer.resolve(items)
      return
    return defer.promise

  query_count: (model, query) ->
    defer = Q.defer()
    model.count query, (err, res) ->
      if err
        defer.reject(err)
      else
        defer.resolve(res)
      return
    return defer.promise

  pages: (count) ->
    if count == 0
      return 1
    double_pages = (count/@limit)
    int_pages = Math.ceil(double_pages)
    return int_pages

  prev_class: (pages) ->
    if pages == 1 or @page == 1
      return "disabled"
    return ""

  next_class: (pages) ->
    if pages == 1 or @page == pages
      return "disabled"
    return ""

  next_page: (pages) ->
    if @page == pages
      return @page
    return @page + 1 

  prev_page: ->
    if @page == 1
      return 1
    return @page - 1

  paged_route: (context, paged_route) ->
    if paged_route
      context._paged_route = "#{paged_route}/"
    else
      context._paged_route = ""

  get_inputs: (context, get_inputs) ->
      if get_inputs
        url_string = "?"
        for get_name of get_inputs
          url_string += "#{get_name}=#{get_inputs[get_name]}&"
        context._get_inputs = url_string
      else
        context._get_inputs = ""


