class window.resultsView extends Backbone.View
  tagName: 'div'
  template: _.template $('#resultsPage').html()

  initialize: ->
    @render()
    return

  render: ->
    console.log 'blaaa'
    @$el.html @template()
    this
