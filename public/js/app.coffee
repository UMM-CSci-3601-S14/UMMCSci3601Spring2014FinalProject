class AppRouter extends Backbone.Router
  routes:
    '': 'index'
    'dash': 'dash'
    'csvPage': 'csvPage'
    'model-maker': 'modelMaker'
    'login': 'login'
    'newUser': 'newUser'
    'failed': 'logIn'
    'account': 'account'
    'uploadCSV': 'uploadCSV'
    'uploadZip': 'uploadZip'


  index: ->
    console.log "in index"
    $('#content').html new window.welcomeView().$el
    return

  dash: ->
    console.log "in dash"
    $('#content').html new window.dashView().$el
    return

  csvPage: ->
    console.log "in csv"
    $('#content').html new window.CSVView().$el
    return

  uploadCSV: ->
    console.log "in uploadCSV"
    $('#content').html new window.uploadCSVView().$el
    return

  uploadZip: ->
    console.log "in uploadZip"
    $('#content').html new window.uploadZipView().$el
    return

  modelMaker: ->
    console.log "in model"
    $('#content').html new window.modelView().$el
    return

  login: ->
    console.log "in Sign in"
    $('#content').html new window.logInView().$el
    return

  newUser: ->
    console.log "in newUser"
    $('#content').html new window.newUserView().$el
    return

  account: ->
    console.log "in account"
    $('#content').html new window.accountView().$el
    return
    
$(document).ready ->
  app = new AppRouter()
  Backbone.history.start pushState: true