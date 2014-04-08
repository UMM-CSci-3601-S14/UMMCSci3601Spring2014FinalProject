
###
Module dependencies.
###
express = require("express")
User = require('../schemas/userSchema').user
passport = require("passport")
LocalStrategy = require("passport-local").Strategy

#
# * GET users listing.
#
User.count {},(err, c) ->
  console.log err if err
  if c == 0
    console.log 'Populating database'
    populateDB()

exports.getByUsername = (req, res) ->
  id = req.params.id
  user.findById id, (err, result) ->
    res.send result

exports.list = (req, res) ->
  res.send "respond with a resource"
  return

populateDB = ->
  usernames = [
    {
      username: 'skippy'
      password: '1234'
    },
    {
      username: 'justin'
      password: '4321'
    },
    {
      username: 'david'
      password: '9hnMILd23145'
    }
  ]
  createAndAdd user for user in usernames

createAndAdd = (u) ->
  newUser = new User(u)
  console.log 'user logged'
  newUser.save()

passport.serializeUser (user, done) ->
  done null, user
  return

passport.deserializeUser (user, done) ->
  done null, user
  return

passport.use 'local-login', new LocalStrategy((username, password, done) ->
  process.nextTick ->
    User.findOne
      username: username, (err, user) ->
        return done(err) if err
        return done(null, false) unless user
        return done(null, false) unless user.password is password
        done null, user
    return
  return
)



module.exports = passport
