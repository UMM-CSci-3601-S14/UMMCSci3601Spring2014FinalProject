// Generated by CoffeeScript 1.7.1
(function() {
  var __hasProp = {}.hasOwnProperty,
    __extends = function(child, parent) { for (var key in parent) { if (__hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor(); child.__super__ = parent.prototype; return child; };

  window.superPost = (function(_super) {
    __extends(superPost, _super);

    function superPost() {
      return superPost.__super__.constructor.apply(this, arguments);
    }

    superPost.prototype.sync = function(method, model, options) {
      $.ajaxSetup({
        headers: {
          Authorization: 'Token a9c60d6b68ca214e595cbdd44a21e832df8f8216',
          'Content-Type': 'application/json'
        }
      });
      return Backbone.sync(method, model, options).done(function() {});
    };

    superPost.prototype.parse = function(response, options) {
      return response;
    };

    return superPost;

  })(Backbone.Model);

}).call(this);
