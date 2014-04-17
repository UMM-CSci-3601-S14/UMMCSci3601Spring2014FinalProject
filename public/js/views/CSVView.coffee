class window.CSVView extends Backbone.View
  tagName: 'div'
  template: _.template $('#csvPage').html()

  events:
    'click button.submitEssay': 'submitEssay'

  initialize: ->
    @render()

  render: ->
    console.log 'rendering CSVView'
    @$el.html @template()
    #REFRESH WARNING:
    window.onbeforeunload = ->
      "WARNING: Reloading the page will restart the process and you will lose all of your data!"
    this

  submitEssay: ->
    console.log 'in function'
    #    console.log this.get 'essayContents'
    this