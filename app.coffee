
###
Module dependencies.
###
express = require("express")
routes = require("./routes")
#user = require("./routes/user")
http = require("http")
path = require("path")
app = express()

# all environments
app.set "port", process.env.PORT or 3000
app.set "views", path.join(__dirname, "views")

#set main layout
app.set 'layout', 'layouts/main'
#expose templates to all views
app.set 'partials',
  scripts: 'partials/scripts'

app.engine "html", require("hogan-express")
app.set "view engine", "html"
app.use express.favicon()
app.use express.logger("dev")
app.use express.json()
app.use express.urlencoded()
app.use express.methodOverride()
app.use app.router
app.use express.static(path.join(__dirname, "public"))

# development only
app.use express.errorHandler()  if "development" is app.get("env")
app.get "/", routes.index
#app.get "/users", user.list
http.createServer(app).listen app.get("port"), ->
    console.log "Express server listening on port " + app.get("port")
return
