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
      var newAuthor;
      $('#passwordTooShort').hide();
      $('#emptyField').hide();
      if ($('#createPassword').val().length < 6) {
        return $('#passwordTooShort').show();
      } else if ($('#createEmail').val().length === 0 || $('#createFirstName').val().length === 0 || $('#createSurname').val().length === 0) {
        return $('#emptyField').show();
      } else {
        return newAuthor = new author({
          designator: $('#createEmail').val()
        }).save().done(function() {
          return Backbone.ajax({
            type: "POST",
            url: "/create",
            data: JSON.stringify({
              password: $('#createPassword').val(),
              email: $('#createEmail').val().toLowerCase(),
              firstName: $('#createFirstName').val(),
              surname: $('#createSurname').val(),
              authorURL: newAuthor.responseJSON.url
            }),
            success: function() {
              return $('#backdoorAccessToLogin').click();
            },
            error: function() {
              return $('#emailIsTaken').show();
            }
          });
        });
      }
    };

    return newUserView;

  })(Backbone.View);

}).call(this);
