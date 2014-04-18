class window.dashView extends Backbone.View
  tagName: 'div'
  template: _.template $('#dashboard').html()

  initialize: ->
    @render()
    return

  render: ->
    console.log 'dash'
    @$el.html @template()
    this