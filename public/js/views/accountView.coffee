class window.accountView extends Backbone.View
  tagName: 'div'
  template: _.template $('#account').html()
  model = new window.user()
#  passwordChangeModel = new window.changePassword()

  events:
    'click button.startChangePassword': 'startChangePassword'
    'click button.endChangePassword': 'endChangePassword'
    'click button.cancelPasswordChange': 'cancelPasswordChange'

  initialize: ->
    @render()

  render: ->
    @$el.html @template(model.toJSON())
    this

  startChangePassword: ->
    $('.changePasswordFields').show()
    $('.startChangePassword').hide()
    $('#successPasswordChange').hide()
    $('#failedPasswordChange').hide()
    $('#passwordMismatch').hide()
    $('#passwordTooShort').hide()

  endChangePassword: ->
    $('#successPasswordChange').hide()
    $('#failedPasswordChange').hide()
    $('#passwordMismatch').hide()
    $('#passwordTooShort').hide()
    if $('#newPassword').val() isnt $('#confirmNewPassword').val()
      $('#passwordMismatch').show()
    else if $('#newPassword').val().length < 6
      $('#passwordTooShort').show()
    else
      Backbone.ajax {
        type: "POST"
        url: "/updatePassword"
        data:
          oldPassword: $('#oldPassword').val()
          newPassword: $('#newPassword').val()
        success: ->
          $('.changePasswordFields').hide()
          $('.startChangePassword').show()
          $('#oldPassword').val("")
          $('#newPassword').val("")
          $('#confirmNewPassword').val("")
          $('#successPasswordChange').show()
        error: ->
          $('#failedPasswordChange').show()
      }

  cancelPasswordChange: ->
    $('.changePasswordFields').hide()
    $('.startChangePassword').show()
    $('#oldPassword').val("")
    $('#newPassword').val("")
    $('#confirmNewPassword').val("")
    $('#successPasswordChange').hide()
    $('#failedPasswordChange').hide()
    $('#passwordTooShort').hide()