class AppRouter extends Backbone.Router
  routes:
    '': 'index'
    'results': 'results'
    'csvPage': 'csvPage'
    'modelPage': 'modelPage'
    'logIn': 'logIn'
    'newUser': 'newUser'
    'failed': 'logIn'
    'account': 'account'

  index: ->
    console.log "in index"
    $('#content').html new window.welcomeView().$el
    return

  results: ->
    console.log "in results"
    $('#content').html new window.resultsView().$el
    return

  csvPage: ->
    console.log "in csv"
    $('#content').html new window.CSVView().$el
    return

  modelPage: ->
    console.log "in model"
    $('#content').html new window.modelView().$el
    return

  logIn: ->
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