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
    res.redirect '/login'
  else
    res.locals = {
      title: 'LightSide'
      header: 'Dashboard'
      user: req.user
    }
    res.render 'index'

exports.uploadCSV = (req, res) ->
  if req.user is undefined
    res.redirect '/login'
  else
    res.locals = {
      title: 'LightSide'
      header: 'LightSide CSV Upload Page'
      username: req.user.username
    }
    res.render 'index'

exports.csvPage = (req, res) ->
  if req.user is undefined
    res.redirect '/login'
  else
   res.locals = {
     title: 'LightSide'
     header: 'LightSide CSV Upload Page'
     user: req.user
   }
   res.render 'index'

exports.uploadZip = (req, res) ->
  if req.user is undefined
    res.redirect '/login'
  else
    res.locals = {
      title: 'LightSide'
      header: 'LightSide CSV Upload Page'
      user: req.user
    }
    res.render 'index'

exports.modelMaker = (req, res) ->
  if req.user is undefined
    res.redirect '/login'
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
    failed: 'Your email or password is incorrect!'
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

exports.login = (req, res) ->
  res.locals = {
    title: 'LightSide'
    header: 'Sign In'
  }
  res.render 'index'

exports.newUser = (req, res) ->
  res.locals = {
    title: 'LightSide'
    header: 'Register'
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
    res.redirect '/login'
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
    currentUser = req.user.email
    newPass = req.body.newPassword
    req.user.password = newPass
    User.update({email: currentUser}, {password: newPass}, (err, numAffected, raw) ->
      console.log err if err
      console.log 'The number of updated documents was %d', numAffected
    )
    res.send(200, "Password changed successfully!")
  else
    res.send(500, "Passwords do not match!")

exports.create = (req, res) ->
  User.findOne({email: req.body.email}, (err, result) ->
    if err
      console.log "err"
    if result
      console.log result
      res.send(500, "Email is already being used")
    else
      newUser = new User req.body
      newUser.save()
      res.send(200, "Password changed successfully!")
  )

exports.addPrompt = (req, res) ->
  currentUser = req.user.email
  promptToAdd = req.body.promptArray
  console.log req.body.promptArray
  User.update({email: currentUser}
    $push:
      promptArray: promptToAdd
    (err, numAffected, raw) ->
      console.log err if err
      console.log 'The number of updated documents was %d', numAffected
  )
  res.send(200, "Prompt was added to the user.")
