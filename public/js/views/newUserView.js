// Generated by CoffeeScript 1.7.1
(function() {
  var __hasProp = {}.hasOwnProperty,
    __extends = function(child, parent) { for (var key in parent) { if (__hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor(); child.__super__ = parent.prototype; return child; };

  window.newUserView = (function(_super) {
    var model;

    __extends(newUserView, _super);

    function newUserView() {
      return newUserView.__super__.constructor.apply(this, arguments);
    }

    newUserView.prototype.tagName = 'div';

    newUserView.prototype.template = _.template($('#newUserPage').html());

    newUserView.prototype.templateMain = _.template($('#welcomePage').html());

    model = new window.user();

    newUserView.prototype.events = {
      'change': 'change',
      'click button.create': 'create'
    };

    newUserView.prototype.initialize = function() {
      return this.render();
    };

    newUserView.prototype.render = function() {
      this.$el.html(this.template(model.toJSON()));
      return this;
    };

    newUserView.prototype.renderMain = function() {
      this.$el.html(this.template());
      return this;
    };

    newUserView.prototype.create = function() {
      model.set({
        username: $('#createUsername').val(),
        password: $('#createPassword').val(),
        email: $('#createEmail').val(),
        firstName: $('#createFirstName').val(),
        surname: $('#createSurname').val()
      });
      console.log('saving...');
      model.save({}, {
        success: function() {
          return console.log('saved');
        },
        error: function() {
          return console.log('error');
        }
      });
      return this.renderMain;
    };

    return newUserView;

  })(Backbone.View);

}).call(this);
