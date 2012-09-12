Db = require('./db')
{{name}} = new Db.Schema{{#key_value data}}
  {{key}}: {{value}},{{/key_value}}
  slug:
    type: String,
    unique: true,

{{#key_value data}}
{{../name}}.path('{{key}}').validate (v) ->
  return Db.Validator.check(v).isEmpty() == false
, '{{key}} is Empty'
{{/key_value}}

module.exports = Db.Model.register '{{ name }}', {{ name }}
