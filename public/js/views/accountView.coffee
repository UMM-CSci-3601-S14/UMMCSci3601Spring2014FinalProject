class window.accountView extends Backbone.View
  tagName: 'div'
  template: _.template $('#account').html()
  model = new window.user()
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
    $('.changePasswordFields').hide()

  cancelPasswordChange: ->
    console.log "here"
    $('.changePasswordFields').hide()
    $('.startChangePassword').show()
    $('#oldPassword').val("")
    $('#newPassword').val("")
    $('#confirmNewPassword').val("")