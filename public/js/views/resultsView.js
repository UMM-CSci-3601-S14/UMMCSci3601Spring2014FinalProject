// Generated by CoffeeScript 1.7.1
(function() {
  var __hasProp = {}.hasOwnProperty,
    __extends = function(child, parent) { for (var key in parent) { if (__hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor(); child.__super__ = parent.prototype; return child; };

  window.resultsView = (function(_super) {
    __extends(resultsView, _super);

    function resultsView() {
      return resultsView.__super__.constructor.apply(this, arguments);
    }

    resultsView.prototype.tagName = 'div';

    resultsView.prototype.template = _.template($('#resultsPage').html());

    resultsView.prototype.initialize = function() {
      this.render();
    };

    resultsView.prototype.render = function() {
      console.log('blaaa');
      this.$el.html(this.template());
      return this;
    };

    return resultsView;

  })(Backbone.View);

}).call(this);
