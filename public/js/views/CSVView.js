// Generated by CoffeeScript 1.7.1
(function() {
  var __hasProp = {}.hasOwnProperty,
    __extends = function(child, parent) { for (var key in parent) { if (__hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor(); child.__super__ = parent.prototype; return child; };

  window.CSVView = (function(_super) {
    __extends(CSVView, _super);

    function CSVView() {
      return CSVView.__super__.constructor.apply(this, arguments);
    }

    CSVView.prototype.tagName = 'div';

    CSVView.prototype.template = _.template($('#csvPage').html());

    CSVView.prototype.events = {
      'click button.submitEssay': 'submitEssay'
    };

    CSVView.prototype.initialize = function() {
      return this.render();
    };

    CSVView.prototype.render = function() {
      console.log('adsfasdf');
      $('#content').html(this.template());
      return this;
    };

    CSVView.prototype.submitEssay = function() {
      console.log('in function');
      return this;
    };

    return CSVView;

  })(Backbone.View);

}).call(this);
