class window.user extends Backbone.Model
#  idAttribute: '_id' #conforming to mongodb id syntax
  defaults:
   username: 'admin'
   password: 'lightside'
  initialize: ->
    console.log 'Initializing a user'


