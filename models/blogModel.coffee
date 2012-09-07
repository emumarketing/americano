Db = require('./db')

BlogPost = new Db.Schema
  title: String,
  slug:
    type: String,
    unique: true,
  category: String,
  date: Date,
  dj: String,
  body: String,
  excerpt: String,

BlogPost.path('slug').validate (v) ->
  return Db.Validator.check(v).notEmpty() != false
, 'Slug Is Empty'

BlogPost.path('date').validate (v) ->
  return Db.Validator.check(v).isDate() != false
, 'Date Is Empty or Invalid'

BlogPost.path('slug').validate (v) ->
  return
, 'Slug is not unique'

module.exports = Db.Model.register 'BlogPost', BlogPost

