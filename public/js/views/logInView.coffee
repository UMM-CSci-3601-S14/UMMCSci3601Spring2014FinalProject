class window.logInView extends Backbone.View
  tagName: 'div'
  template: _.template $('#login').html()

  initialize: ->
    @render()

  render: ->
    @$el.html @template()
    this