AdminPanel = require('../controllers/AdminPanel')
BlogModel = require('../models/BlogModel')
app = require('../app')

describe 'AdminPanel has BlogMixin', ->
  admin_panel = new AdminPanel(app)
  
  describe 'Check for properties', ->

    it 'should have action_blog_index', ->
      assert.property(admin_panel, 'action_blog_index')

    it 'should have action_blog_edit', ->
      assert.property(admin_panel, 'action_blog_edit')

    it 'should have action_blog_create', ->
      assert.property(admin_panel, 'action_blog_create')

    it 'should have action_blog_update', ->
      assert.property(admin_panel, 'action_blog_update')

    it 'should have action_blog_new', ->
      assert.property(admin_panel, 'action_blog_new')

  describe 'Render or Redirect is called in each route', ->
    req =
      body:
        title: 'Testing'
        body: 'Lorem ipsum dolar sit amet'
        excerpt: 'Lorem ipsum'
        slug: 'testing'
      params:
        slug: 'his-majesty'

    res =
      render: (path, options) ->
        return
      redirect: (path) ->
        return
      send: (text) ->
        return

    before ->
      Blog = new BlogModel
        title: "His majesty"
        body: "And Friends"
        excerpt: "eat slugs"
        slug: "his-majesty"

      Blog.save (err) ->
        if err then throw new Error(err)

    beforeEach ->
      sinon.spy(res, "render")
      sinon.spy(res, "redirect")

    afterEach ->
      res.render.restore()
      res.redirect.restore()

    after ->
      BlogModel.remove {}, (err) ->
        if err then throw new Error(err)

    it 'action_blog_index should call render', (done) ->
      admin_panel.action_blog_index req, res, ->
        assert.isTrue(res.render.calledOnce)
        done()

    it 'action_blog_edit should call render', (done) ->
      admin_panel.action_blog_edit req, res, ->
        assert.isTrue(res.render.calledOnce)
        done()
    
    it 'action_blog_create should call render', (done) ->
      admin_panel.action_blog_create req, res, ->
        assert.isTrue(res.render.calledOnce)
        done()

    it 'action_blog_update should call redirect', (done) ->
      admin_panel.action_blog_update req, res, ->
        assert.isTrue(res.redirect.calledOnce)
        done()

    it 'action_blog_new should call render', (done) ->
      admin_panel.action_blog_new req, res, ->
        assert.isTrue(res.render.calledOnce)
        done()
 
