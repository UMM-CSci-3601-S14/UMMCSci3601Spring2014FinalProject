User = require('../schemas/userSchema').user
#
# * GET home page.
#
exports.index = (req, res) ->
  console.log 'inside index'
  if req.user is undefined
    res.locals = {
      title: 'LightSide'
      header: 'LightSide Test Page'
    }
  else
    res.locals = {
      title: 'LightSide'
      header: 'LightSide Test Page'
      user: req.user
    }
  res.render 'index'

exports.dash = (req, res) ->
  if (req.session.passport.user is undefined)
    res.redirect '/logIn'
  else
    res.locals = {
      title: 'LightSide'
      header: 'Dashboard'
      user: req.user
  }
  res.render 'index'

exports.results = (req, res) ->
  console.log 'inside results'
  res.locals = {
    title: 'LightSide'
    header: 'LightSide Results Page'
    user: req.user
  }
  res.render 'index'

exports.csvPage = (req, res) ->
  if req.user is undefined
    res.redirect '/logIn'
  else
   res.locals = {
     title: 'LightSide'
     header: 'LightSide CSV Upload Page'
     user: req.user
   }
   res.render 'index'

exports.modelPage = (req, res) ->
  if req.user is undefined
    res.redirect '/logIn'
  else
   res.locals = {
     title: 'LightSide'
     header: 'LightSide Model Maker'
     user: req.user
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
      user: req.user
    }
    res.render 'index'

exports.logIn = (req, res) ->
  res.locals = {
    title: 'LightSide'
    header: 'LightSide Sign In'
  }
  res.render 'index'

exports.newUser = (req, res) ->
  res.locals = {
    title: 'LightSide'
    header: 'LightSide Register'
  }
  res.render 'index'

exports.logout = (req, res) ->
  if (req.session.passport.user is undefined)
    res.redirect '/'
  else
    req.logout()
    res.redirect('/')

exports.account = (req, res) ->
  if (req.session.passport.user is undefined)
    res.redirect '/logIn'
  else
    console.log req.user
    res.locals = {
      title: 'LightSide'
      header: 'Welcome ' + req.user.firstName
      user: req.user
    }
  res.render 'index'

exports.updatePassword = (req, res) ->
  if req.user.password is req.body.oldPassword
    currentUser = req.user.username
    newPass = req.body.newPassword
    User.update({username: currentUser}, { password: newPass}, (err, numAffected, raw) ->
      console.log err if err
      console.log 'The number of updated documents was %d', numAffected
      #console.log 'The raw response from Mongo was ', raw
    )
  else
    console.log 'incorrect password'


exports.create = (req, res) ->
  newUser = new User req.body
  console.log req.body
  newUser.save()
  res.send newUser
  res.redirect '/logIn'