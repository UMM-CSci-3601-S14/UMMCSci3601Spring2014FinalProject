// Generated by CoffeeScript 1.6.3
(function() {
  var _ref,
    __hasProp = {}.hasOwnProperty,
    __extends = function(child, parent) { for (var key in parent) { if (__hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor(); child.__super__ = parent.prototype; return child; };

  window.user = (function(_super) {
    __extends(user, _super);

    function user() {
      _ref = user.__super__.constructor.apply(this, arguments);
      return _ref;
    }

    user.prototype.defaults = {
      password: '',
      email: '',
      firstName: '',
      surname: '',
      prompts: []
    };

    user.prototype.initialize = function() {
      return console.log('Initializing a user');
    };

    return user;

  })(Backbone.Model);

}).call(this);

/*
//@ sourceMappingURL=user.map
*/
