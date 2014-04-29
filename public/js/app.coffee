class AppRouter extends Backbone.Router
  routes:
    '': 'index'
    'dash': 'dash'
    'csvPage': 'csvPage'
    'model-maker': 'modelMaker'
    'login': 'login'
    'newUser': 'newUser'
    'failed': 'login'
    'account': 'account'
    'uploadCSV': 'uploadCSV'
    'uploadZip': 'uploadZip'



  index: ->
    $('#content').html new window.welcomeView().$el
    return

  dash: ->
    $('#content').html new window.dashView().$el
    return

  csvPage: ->
    $('#content').html new window.CSVView().$el
    return

  uploadCSV: ->
    $('#content').html new window.uploadCSVView().$el
    return

  uploadZip: ->
    $('#content').html new window.uploadZipView().$el
    return

  modelMaker: ->
    $('#content').html new window.modelView().$el
    return

  login: ->
    $('#content').html new window.logInView().$el
    return

  newUser: ->
    $('#content').html new window.newUserView().$el
    return

  account: ->
    $('#content').html new window.accountView().$el
    return
    
$(document).ready ->
  app = new AppRouter()
  Backbone.history.start pushState: true