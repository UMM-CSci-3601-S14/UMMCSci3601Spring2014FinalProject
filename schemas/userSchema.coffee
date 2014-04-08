mongoose = require 'mongoose'
Schema = mongoose.Schema


userSchema = mongoose.Schema(
   username: String
   password: String
)

user = mongoose.model 'user', userSchema

module.exports =
  user: user