class window.resultsView extends Backbone.View
  tagName: 'div'
  template: _.template $('#resultsPage').html()

  initialize: ->
    @render()

  render: ->
    console.log 'blaaa'
    $('#content').html @template()
    this
