mongoose = require 'mongoose'
Schema = mongoose.Schema


userSchema = mongoose.Schema(
   password: String
   email: String
   firstName: String
   surname: String
   promptArray: []
)
user = mongoose.model 'user', userSchema

module.exports =
  user: user