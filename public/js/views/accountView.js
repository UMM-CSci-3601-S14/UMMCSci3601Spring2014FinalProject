// Generated by CoffeeScript 1.7.1
(function() {
  var __hasProp = {}.hasOwnProperty,
    __extends = function(child, parent) { for (var key in parent) { if (__hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor(); child.__super__ = parent.prototype; return child; };

  window.accountView = (function(_super) {
    var model;

    __extends(accountView, _super);

    function accountView() {
      return accountView.__super__.constructor.apply(this, arguments);
    }

    accountView.prototype.tagName = 'div';

    accountView.prototype.template = _.template($('#account').html());

    model = new window.user();

    accountView.prototype.events = {
      'click button.startChangePassword': 'startChangePassword',
      'click button.endChangePassword': 'endChangePassword',
      'click button.cancelPasswordChange': 'cancelPasswordChange'
    };

    accountView.prototype.initialize = function() {
      return this.render();
    };

    accountView.prototype.render = function() {
      this.$el.html(this.template(model.toJSON()));
      return this;
    };

    accountView.prototype.startChangePassword = function() {
      $('.changePasswordFields').show();
      $('.startChangePassword').hide();
      $('#successPasswordChange').hide();
      $('#failedPasswordChange').hide();
      return $('#passwordMismatch').hide();
    };

    accountView.prototype.endChangePassword = function() {
      $('#successPasswordChange').hide();
      $('#failedPasswordChange').hide();
      $('#passwordMismatch').hide();
      if ($('#newPassword').val() !== $('#confirmNewPassword').val()) {
        return $('#passwordMismatch').show();
      } else {
        return Backbone.ajax({
          type: "POST",
          url: "/updatePassword",
          data: {
            oldPassword: $('#oldPassword').val(),
            newPassword: $('#newPassword').val()
          },
          success: function() {
            $('.changePasswordFields').hide();
            $('.startChangePassword').show();
            $('#oldPassword').val("");
            $('#newPassword').val("");
            $('#confirmNewPassword').val("");
            return $('#successPasswordChange').show();
          },
          error: function() {
            return $('#failedPasswordChange').show();
          }
        });
      }
    };

    accountView.prototype.cancelPasswordChange = function() {
      console.log("here");
      $('.changePasswordFields').hide();
      $('.startChangePassword').show();
      $('#oldPassword').val("");
      $('#newPassword').val("");
      return $('#confirmNewPassword').val("");
    };

    return accountView;

  })(Backbone.View);

}).call(this);

//# sourceMappingURL=accountView.map
