class window.user extends Backbone.Model
  url: '/create'
#  idAttribute: '_id' #conforming to mongodb id syntax
  defaults:
   username: ''
   password: ''
  initialize: ->
    console.log 'Initializing a user'


