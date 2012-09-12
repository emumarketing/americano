{{dataname}}Model = require('../../models/blogModel')

module.exports = {{dataname}}Mixin =

  action_index: (req, res) =>
    {{dataname}}Model.find {}, (err, items) ->
      res.render "{{resource}}/{{dataname}}", {data: items, errors: err}
    return

  action_create: (req, res) =>
    res.render "{{resource}}/{{dataname}}/create", {item: {}, action: "/{{resource}}/{{dataname}}/new"}
    return

  action_new: (req, res) =>
    params = req.body
    {{dataname}} = new {{dataname}}Model{{#key_value data}}
      {{key}}: params.{{key}}{{/key_value}}

    {{dataname}}.save (err) ->
      if (err)
        res.render "{{resource}}/{{dataname}}/create", {item: params, errors: err, action: "/{{resource}}/{{dataname}}/new"}
      else
        res.redirect "/{{resource}}/{{dataname}}"
    return

  action_edit: (req, res) =>
    slug = req.params.slug
    {{dataname}}Model.findOne {"slug": slug}, (err, item) ->
      if !err and item?
        res.render "{{resource}}/{{dataname}}/edit", {item: item, errors: err, action: "/{{resource}}/{{dataname}}/update/#{item.slug}"}
      else
        res.send "Not a Valid {{dataname}} To Edit"
    return

  action_update: (req, res) =>
    slug = req.params.slug
    {{dataname}}Model.findOne {"slug", slug}, (err, item) ->{{#key_value data}}
      item.{{key}} = req.body.{{key}}{{/key_value}}
      old_slug = post.slug
      item.slug = req.body.slug
      item.save (err) ->
        if (!err)
          res.redirect "/{{resource}}/{{dataname}}"
        else
          item.slug = old_slug
          res.render "{{resource}}/{{dataname}}/edit", {item: item, errors: err, action: "/{{resource}}/{{dataname}}/update/#{old_slug}"}

