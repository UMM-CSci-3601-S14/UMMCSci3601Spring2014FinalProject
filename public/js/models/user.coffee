class window.user extends Backbone.Model
  url: '/create'
#  idAttribute: '_id' #conforming to mongodb id syntax
  defaults:
   password: ''
   email: ''
   firstName: ''
   surname: ''

  initialize: ->
    console.log 'Initializing a user'


