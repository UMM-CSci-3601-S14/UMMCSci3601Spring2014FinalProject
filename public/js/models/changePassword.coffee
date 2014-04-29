class window.changePassword extends Backbone.Model
  url: '/updatePassword'
#  idAttribute: '_id' #conforming to mongodb id syntax
  defaults:
    oldPassword: ''
    newPassword: ''



  initialize: ->
    console.log 'Initializing a user'