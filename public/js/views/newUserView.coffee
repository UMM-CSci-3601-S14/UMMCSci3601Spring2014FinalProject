class window.newUserView extends Backbone.View
  tagName: 'div'
  template: _.template $('#newUserPage').html()
  model =  new window.user()
  events:
   'change': 'change'
   'click button.create': 'create'

  initialize: ->
    @render()


  render: ->
    @$el.html @template(model.toJSON())
    this

  renderMain: ->
    @$el.html @template()
    this

  create: ->
    $('#passwordTooShort').hide()
    $('#emptyField').hide()
    if $('#createPassword').val().length < 6
      $('#passwordTooShort').show()
    else if $('#createEmail').val().length == 0 or $('#createFirstName').val().length == 0 or $('#createSurname').val().length == 0
      $('#emptyField').show()
    else
      newAuthor = new author({designator: $('#createEmail').val()}).save().done ->
        Backbone.ajax {
          type: "POST"
          url: "/create"
          data: JSON.stringify(
            password: $('#createPassword').val()
            email: $('#createEmail').val().toLowerCase()
            firstName: $('#createFirstName').val()
            surname: $('#createSurname').val()
            authorURL: newAuthor.responseJSON.url
          )
          success: ->
#            console.log "created"
            $('#backdoorAccessToLogin').click()
          error: ->
#            console.log "email taken"
            $('#emailIsTaken').show()
        }
