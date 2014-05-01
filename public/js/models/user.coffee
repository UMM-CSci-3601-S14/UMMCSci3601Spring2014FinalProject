class window.user extends Backbone.Model
#  idAttribute: '_id' #conforming to mongodb id syntax
  defaults:
   password: ''
   email: ''
   firstName: ''
   surname: ''
   prompts: []

  initialize: ->
#    console.log 'Initializing a user'