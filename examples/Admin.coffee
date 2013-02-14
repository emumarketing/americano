BaseController = require('./base')
forms = require 'forms-bootstrap'

module.exports = class AdminController extends BaseController

  constructor: (@am) ->
    super(@am)
    @on "blog_index_query", @_query_blog_index
    @on "blog_index_render", @_render_blog_index
    @on "form_error", @_add_form_message
    @on "post_render", @_req_cleanup
    @on "render_blog_save", @_render_blog_save
    @on "blog_save", @_query_blog_save
    @on "error_blog_save", @_error_blog_save
    @on "query_blog_edit", @_query_blog_edit
    @on "render_blog_edit", @_render_blog_edit

    @edit_form = forms.create 
      title: forms.fields.string
        required: true
        widget: forms.widgets.text
          placeholder: 'A title'
          classes: ['span5']
      author: forms.fields.string
        required: true
        widget: forms.widgets.text
          placeholder: "Your name"
          classes: ['span5']
      body: forms.fields.string
        widget: forms.widgets.textarea
          classes: ['span5']
          rows: 5 
      excerpt: forms.fields.string
        widget: forms.widgets.textarea
          classes: ['span5']
          rows: 3
      draft: forms.fields.boolean
        widget: forms.widgets.checkbox()
      slug: forms.fields.string
        required: true
        widget: forms.widgets.text
          classes: ['span5']

  action_index: (req, res) =>
    res.render "admin/index"
    return

  action_blog_index: (req, res) =>
    query = @am.model.blogmodel().find({})
    data = 
      req: req,
      res: res,
      query: query,
    @emit "blog_index_query", data
    return

  action_blog_new: (req, res) =>
    #@emit "form_error", req, "Bad Form"
    res.render "admin/blog_edit", {messages: req.session.messages, form: @edit_form.toHTML()} 
    @emit "post_render", req
    return

  action_blog_edit: (req, res) =>
    query = @am.model.blogmodel().find({slug: req.params.slug})
    data = 
      req: req,
      res: res,
      query: query,
    @emit "query_blog_edit", data 
    #@emit "post_render", req
    return


  action_blog_save: (req, res) =>
    @edit_form.handle req,
      success: (form) =>
        data = 
          res: res,
          req: req,
          form: form
        @emit "blog_save", data
        return
      other: (form) =>
        @emit "form_error", req, "Form Error"
        res.redirect "/admin/blog/edit"
        return
    return

  _query_blog_index: (data) =>
    data.query.exec( (err, results) =>
      data.results = results
      @emit "blog_index_render", data
    )

  _render_blog_index: (data) =>
    data.res.render "admin/blog_index", {posts: data.results}


  _query_blog_edit: (data) =>
    data.query.exec( (err, results) =>
      if (!err)
        data.results = results
        @emit "render_blog_edit", data
      else
        data.err = err
        @emit "error_blog_edit", data
    )
    
  _query_blog_save: (data) =>
    blogmodel = @am.model.blogmodel()
    post = new blogmodel
    post.title = data.form.data.title 
    post.excerpt = data.form.data.excerpt
    post.body = data.form.data.body
    post.slug = data.form.data.slug
    post.author = data.form.data.author
    post.draft = data.form.data.draft
    post.save (err, post) =>
      if (!err)
        @emit "render_blog_save", data
      else
        data.err = err
        @emit "error_blog_save", data

  _render_blog_save: (data) =>
    data.res.redirect "/admin/blog/index"

  _render_blog_edit: (data) =>
    res = data.results[0]
    @edit_form.bind({
      title: res.title, 
      author: res.author,
      body: res.body,
      excerpt: res.excerpt,
      slug: res.slug,
    })
    data.res.render "admin/blog_edit", {messages: data.req.session.messages, form: @edit_form.toHTML()} 

  _error_blog_save: (data) =>
    @emit "form_error", data, "Form DB Error"
    data.res.redirect "/admin/blog/edit"

  _add_form_message: (data, message) =>
    if (!data.req.session.messages) 
      data.req.session.messages = []
    data.req.session.messages.push(message)
    if (data.err)
      console.log(data.err)
      for key, error_type of data.err.errors
        message = error_type.message
        data.req.session.messages.push(message)
    return

  _req_cleanup: (req) =>
    req.session.messages = undefined
    return



