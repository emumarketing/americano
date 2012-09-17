Q = require("q")
module.exports = class PaginationHelper

  constructor: (page) ->
    @page = if page then parseInt(page) else 1
    @limit = 1

  render: (model, query, cb) =>
    self = @
    count = 0
      
    query_count = () ->
      defer = Q.defer()
      model.count query, (err, res) ->
        if err then defer.reject(err)
        defer.resolve(res)
        return
      return defer.promise

    query_count().then (res) ->
      count = parseInt(res)

      pages = (count/self.limit)

      pages = Math.floor(pages)

      pages = if pages == 0 then 1 else pages

      prev_class = if pages == 1 or self.page == 1 then 'disabled' else ''

      next_class = if pages == 1 or self.page == pages then 'disabled' else ''

      prev_page = if self.page == 1 then 1 else self.page - 1

      next_page = if self.page == pages then pages else self.page + 1

      cb({num_pages: pages, current_page: self.page, prev_class: prev_class, next_class: next_class, prev_page: prev_page, next_page: next_page})

    , (err) ->
      throw new Error(err)

    return

  results: (model, query, cb) ->
    offset = (@limit * @page) - @limit
    q = model.find(query).limit(@limit).skip(offset)
    q.exec (err, items) ->
      cb(err, items)
    return

