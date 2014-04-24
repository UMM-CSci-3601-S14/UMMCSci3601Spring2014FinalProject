###
Module dependencies.
###
express = require 'express'
routes = require './routes'
http = require 'http'
path = require 'path'
mongoose = require 'mongoose'
passport = require('./routes/user')
app = express()

mongoose.connect 'mongodb://localhost/test'
db = mongoose.connection
db.on 'error', console.error.bind(console, 'connection error:')
db.once 'open', ->
  console.log 'DB connection opened'

app.set 'layout', 'layouts/main'
app.set 'partials',
  welcome: 'partials/welcome',
  results: 'partials/results',
  csv: 'partials/csv',
  scripts: 'partials/scripts',
  model: 'partials/model',
  tutorial: 'partials/tutorial',
  dashboard: 'partials/dashboard',
  functions: 'partials/functions',
  visualization: 'partials/visualization',
  uploadCSV: 'partials/uploadCSV',
  unzip: 'partials/unzip',


# all environments
app.engine 'html', require ("hogan-express")
app.enable 'view cache'
app.configure ->
  app.set "port", process.env.PORT or 3000
  app.set "views", __dirname + "/views"
  app.set "view engine", "html"
  app.use express.favicon()
  app.use express.logger("dev")
  app.use express.json()
  app.use express.urlencoded()
  app.use express.methodOverride()
  app.use express.cookieParser('csci3601')
  app.use express.session(
    cookie: {
      maxAge: 3600000
    }
    secret: 'csci3601')
  app.use passport.initialize()
  app.use passport.session()
  app.use app.router

app.use express.static(path.join(__dirname, "public"))
app.use express.static(path.join(__dirname, 'bower_components'))

# development only
app.configure 'development', ->
  app.use express.errorHandler()

app.get "/", routes.index
app.get "/dash", routes.dash
app.get "/model-maker", routes.modelMaker
app.get "/failed", routes.failed
app.get "/user", routes.user
app.get "/login", routes.login
app.get "/newUser", routes.newUser
app.get "/logout", routes.logout
app.get "/account", routes.account
app.post '/create', routes.create
app.post '/updatePassword', routes.updatePassword

app.post '/', passport.authenticate 'local-login',
  failureRedirect: '/failed',
  successRedirect: '/dash'


http.createServer(app).listen app.get("port"), ->
  console.log "Express server listening on port " + app.get("port")
