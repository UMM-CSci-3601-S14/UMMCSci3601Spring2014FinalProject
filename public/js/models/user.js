// Generated by CoffeeScript 1.7.1
(function() {
  var __hasProp = {}.hasOwnProperty,
    __extends = function(child, parent) { for (var key in parent) { if (__hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor(); child.__super__ = parent.prototype; return child; };

  window.user = (function(_super) {
    __extends(user, _super);

    function user() {
      return user.__super__.constructor.apply(this, arguments);
    }

    user.prototype.defaults = {
      password: '',
      email: '',
      firstName: '',
      surname: '',
      prompts: []
    };

    user.prototype.initialize = function() {};

    return user;

  })(Backbone.Model);

}).call(this);
