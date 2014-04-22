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

  endChangePassword: ->
    if $('#newPassword').val() isnt $('#confirmNewPassword').val()
      $('.passwordMismatch').show()
    else
      Backbone.ajax {
        type: "POST"
        url: "/updatePassword"
        data:
          oldPassword: $('#oldPassword').val()
          newPassword: $('#newPassword').val()
        success: ->
          console.log "worked"
        error: ->
          console.log "failed"
      }


  cancelPasswordChange: ->
    console.log "here"
    $('.changePasswordFields').hide()
    $('.startChangePassword').show()
    $('#oldPassword').val("")
    $('#newPassword').val("")
    $('#confirmNewPassword').val("")