class window.modelView extends Backbone.View
  tagName: 'div'
  template: _.template $('#modelPage').html()

  events:
    'click button.submitEssay': 'submitEssay'

  initialize: ->
    @render()

  render: ->
    console.log 'Model'
    @$el.html @template()
    this

  submitEssay: ->
    console.log 'in function'
    #    console.log this.get 'essayContents'
    this