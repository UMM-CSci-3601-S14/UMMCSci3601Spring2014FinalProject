// Generated by CoffeeScript 1.7.1
(function() {
  var __hasProp = {}.hasOwnProperty,
    __extends = function(child, parent) { for (var key in parent) { if (__hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor(); child.__super__ = parent.prototype; return child; };

  window.prompt = (function(_super) {
    __extends(prompt, _super);

    function prompt() {
      return prompt.__super__.constructor.apply(this, arguments);
    }

    prompt.prototype.defaults = {
      description: ''
    };

    prompt.prototype.urlRoot = 'https://try-api.lightsidelabs.com/api/prompts/114';

    prompt.prototype.sync = function(method, model, options) {
      $.ajaxSetup({
        headers: {
          Authorization: 'Token a9c60d6b68ca214e595cbdd44a21e832df8f8216',
          'Content-Type': 'application/json'
        },
        method: 'post'
      });
      return Backbone.sync(method, model, options).done(function() {
        return console.log(model);
      });
    };

    prompt.prototype.parse = function(response, options) {
      return response;
    };

    return prompt;

  })(Backbone.Model);

}).call(this);
