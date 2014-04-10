User = require('../schemas/userSchema').user
#
# * GET home page.
#
exports.index = (req, res) ->
  console.log 'inside index'
  res.locals = {
    title: 'LightSide'
    header: 'LightSide Test Page'
  }
  res.render 'index'

exports.results = (req, res) ->
  console.log 'inside results'
  res.locals = {
    title: 'LightSide'
    header: 'LightSide Results Page'
  }
  res.render 'index'

exports.csvPage = (req, res) ->
  if req.user is undefined
    res.redirect '/logIn'
  else
   res.locals = {
     title: 'LightSide'
     header: 'LightSide CSV Upload Page'
   }
   res.render 'index'

exports.modelPage = (req, res) ->
  if req.user is undefined
    res.redirect '/logIn'
  else
   res.locals = {
     title: 'LightSide'
     header: 'LightSide Model Maker'
   }
   res.render 'index'

exports.list = (req, res) ->
  res.send "respond with a resource"

exports.failed = (req, res) ->
  res.locals = {
    title: 'Lightside'
    header: 'Failed Login'
    failed: 'Your username or password does not match!'
  }
  res.render 'index'

exports.user = (req, res) ->
  if (req.session.passport.user is undefined)
    res.redirect '/'
  else
    res.locals = {
      title: 'Lightside'
      header: 'Welcome ' + req.session.passport.user.username + '!'
    }
    res.render 'index'

exports.logIn = (req, res) ->
  res.locals = {
    title: 'LightSide'
    header: 'LightSide Sign In'
  }
  res.render 'index'

exports.newUser = (req,res) ->
  res.locals = {
    title: 'LightSide'
    header: 'LightSide Register'
  }
  res.render 'index'

exports.create = (req, res) ->
  newUser = new User req.body
  console.log 'created user'
  newUser.save()
  res.send newUser