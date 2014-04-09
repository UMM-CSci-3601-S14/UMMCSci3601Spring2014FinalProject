class window.newUserView extends Backbone.View
  tagName: 'div'
  template: _.template $('#newUserPage').html()
  templateMain: _.template $('#welcomePage').html()
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

  change: (event) ->
    # when the value of the text area changes, update the model on the client
    console.log 'changed'
    change = {}
    changeTarget = event.target
    change[changeTarget.name] = changeTarget.value #uses name attribute from html
    # change = {body: 'whatever'}
    model.set(change)

  create: ->
    #save all changes made to the model back to the database
    console.log 'saving...'
    model.save {},
      success: ->
        console.log 'saved'
      error: ->
        console.log 'error'
    @renderMain