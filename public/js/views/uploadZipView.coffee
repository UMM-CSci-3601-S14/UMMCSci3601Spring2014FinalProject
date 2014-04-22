class window.uploadZipView extends Backbone.View
  tagName: 'div'
  template: _.template $('#unzipPage').html()

  events:
   'click button.createZip': 'checkTypes'

  initialize: ->
    @render()

  render: ->
    console.log 'rendering uploadZipView'
    @$el.html @template()
    this


