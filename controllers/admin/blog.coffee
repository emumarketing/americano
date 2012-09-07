BlogModel = require('../../models/blogModel')

module.exports = BlogMixin =

  blogIndex: (req, res) =>
    BlogModel.find {}, (err, posts) ->
      res.render "admin/blog", {data: posts, errors: err}
    return

  blogCreate: (req, res) =>
    res.render "admin/blog/create", {post: {}, action: "/admin/blog/new"}
    return

  blogNew: (req, res) =>
    params = req.body
    blog = new BlogModel
      title: params.title
      slug: params.slug
      category: params.category
      date: params.date
      dj: params.dj
      body: params.body
      excerpt: params.excerpt
    blog.save (err) ->
      if (err)
        res.render "admin/blog/create", {post: params, errors: err, action: "/admin/blog/new"}
      else
        res.redirect "/admin/blog"
    return

  blogEdit: (req, res) =>
    slug = req.params.slug
    BlogModel.findOne {"slug": slug}, (err, post) ->
      if !err and post?
        res.render "admin/blog/edit", {post: post, errors: err, action: "/admin/blog/update/#{post.slug}"}
      else
        res.send "Not a Valid Post To Edit"
    return

  blogUpdate: (req, res) =>
    slug = req.params.slug
    BlogModel.findOne {"slug", slug}, (err, post) ->
      post.title = req.body.title
      old_slug = post.slug
      post.slug = req.body.slug
      post.category = req.body.category
      post.date = req.body.date
      post.dj = req.body.dj
      post.body = req.body.body
      post.excerpt = req.body.excerpt
      post.save (err) ->
        if (!err)
          res.redirect "/admin/blog"
        else
          post.slug = old_slug
          res.render "admin/blog/edit", {post: post, errors: err, action: "/admin/blog/update/#{old_slug}"}

