module.exports = (americano) =>
  
  validate = americano.validator

  valid_title = [validate('notEmpty')]

  valid_date = [validate('isDate')]

  valid_author = [validate('notEmpty')]

  valid_excerpt = [validate('notEmpty')]

  valid_body = [validate('notEmpty')]

  BlogModel = new americano.model.schema
    title: 
      type: String,
      validate: valid_title,
    date: 
      type: Date,
      validate: valid_date,
    author: 
      type: String,
      validate: valid_author,
    excerpt: 
      type: String,
      validate: valid_excerpt,
    body: 
      type: String,
      validate: valid_body,
    slug:
      type: String,
      unique: true,
  
  return BlogModel

