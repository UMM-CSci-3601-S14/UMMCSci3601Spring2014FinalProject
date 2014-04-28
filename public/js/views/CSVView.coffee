class window.CSVView extends Backbone.View
  tagName: 'div'
  template: _.template $('#csvPage').html()

  events:
    'click button#downloadCSV': 'downloadCSV'
    'click button#add': 'add'
    'click button#delete': 'delete'
    'click button#saveFields': 'saveFields'
    'click button#replace': 'replace'
    'click button#cancel': 'cancel'


  initialize: ->
    @render()

  render: ->
    console.log 'rendering CSVView'
    @$el.html @template()
    #REFRESH WARNING:
    window.onbeforeunload = ->
      "WARNING: Reloading the page will restart the process and you will lose all of your data!"
    this

  ###
  These functions are found in funtions.html
  ###

  downloadCSV: ->
    exportToCSV()

  add: ->
    add()
    $("#titleV").show()

  delete: ->
    del()

  saveFields: ->
    saveFieldNames();
    $("#fieldTut").hide()
    $("#textTut").show()

  cancel: ->
    cancelReplace()

  replace: ->
     replace()