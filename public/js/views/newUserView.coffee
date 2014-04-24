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
    Backbone.ajax {
      type: "POST"
      url: "/create"
      data:
        password: $('#createPassword').val()
        email: $('#createEmail').val()
        firstName: $('#createFirstName').val()
        surname: $('#createSurname').val()
      success: ->
        console.log "created"
        $('#backdoorAccessToLogin').click()
      error: ->
        console.log "email taken"
        $('#emailIsTaken').show()
    }