###
Module dependencies.
###
express = require 'express'
routes = require './routes'
http = require 'http'
path = require 'path'
mongoose = require 'mongoose'
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
  navbar: 'partials/navbar',
  scripts: 'partials/scripts'

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
  app.use express.cookieParser('your secret here')
  app.use app.router

app.use express.static(path.join(__dirname, "public"))
app.use express.static(path.join(__dirname, 'bower_components'))

# development only
app.configure 'development', ->
  app.use express.errorHandler()

app.get "/", routes.index
app.get "/results", routes.results
app.get "/csvPage", routes.csvPage
app.get "/users", routes.list


http.createServer(app).listen app.get("port"), ->
  console.log "Express server listening on port " + app.get("port")
