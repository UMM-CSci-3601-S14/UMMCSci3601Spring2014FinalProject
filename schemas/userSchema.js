// Generated by CoffeeScript 1.7.1
(function() {
  var Schema, mongoose, user, userSchema;

  mongoose = require('mongoose');

  Schema = mongoose.Schema;

  userSchema = mongoose.Schema({
    password: String,
    email: String,
    firstName: String,
    surname: String
  });

  user = mongoose.model('user', userSchema);

  module.exports = {
    user: user
  };

}).call(this);

//# sourceMappingURL=userSchema.map
