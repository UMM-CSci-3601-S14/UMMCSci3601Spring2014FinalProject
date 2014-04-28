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
      password: '1234'
      email: 'vinkx009@morris.umn.edu'
      firstName: 'Zachary'
      surname: 'Vink'
      promptArray: ["Informative essay on goat milking", "Underwater basket-weaving", "Above water basket-weaving"]
    },
    {
      password: '4321'
      email: 'lal@lol.com'
      firstName: 'Justin'
      surname: 'YaDeau'
    },
    {
      password: '9hnMILd23145'
      email: 'Ha@lol.com'
      firstName: 'David'
      surname: 'Donatuccshio'
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

passport.use 'local-login', new LocalStrategy({
    usernameField: 'email'
    passwordField: 'password'
  }
    (email, password, done) ->
      process.nextTick ->
        User.findOne
          email: email, (err, user) ->
            return done(err) if err
            return done(null, false) unless user
            return done(null, false) unless user.password is password
            done null, user
        return
      return
    )

module.exports = passport
