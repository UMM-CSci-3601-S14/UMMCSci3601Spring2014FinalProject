class window.dashView extends Backbone.View
  tagName: 'div'
  template: _.template $('#dashboard').html()

  events:
    'click button#createModelBox' : 'loadCSVPage'

  initialize: ->
    @render()
    return

  render: ->
    console.log 'dash'
    @$el.html @template()
    this

  loadCSVPage: ->
    window.location.href = '/csvPage'

