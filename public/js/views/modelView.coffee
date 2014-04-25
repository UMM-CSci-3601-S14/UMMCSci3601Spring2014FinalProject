class window.modelView extends Backbone.View
  tagName: 'div'
  template: _.template $('#modelMaker').html()

  events:
    'click button#createPrompt': 'createPrompt'
    'click button#hideWait' : 'hideWait'
    'click button#uploadCSV' : 'uploadCSV'
    'click button#makeCSV' : 'makeCSV'
    'click button#uploadZip' : 'uploadZip'
    'click button#submitCSV1': 'createPrompt'



  initialize: ->
    @render()


  render: ->
    console.log 'Model'
    @$el.html @template()
    this


  uploadCSV: ->
    if $("#promptTitle").val() is ""
      window.alert "Please enter the prompt title"
    else if $("#promptDescription").val() is ""
      window.alert "Please enter the prompt description"
    else if $("#cDescription").val() is ""
      window.alert "Please enter the class description"
    else
      fieldCollapse()
      $('#csvArea').html new window.uploadCSVView().$el

  uploadZip: ->
    if $("#promptTitle").val() is ""
      window.alert "Please enter the prompt title"
    else if $("#promptDescription").val() is ""
      window.alert "Please enter the prompt description"
    else if $("#cDescription").val() is ""
      window.alert "Please enter the class description"
    else
      fieldCollapse()
      $('#csvArea').html new window.uploadZipView().$el

  makeCSV: ->
    if $("#promptTitle").val() is ""
      window.alert "Please enter the prompt title"
    else if $("#promptDescription").val() is ""
      window.alert "Please enter the prompt description"
    else if $("#cDescription").val() is ""
      window.alert "Please enter the class description"
    else
      fieldCollapse()
      $('#csvArea').html new window.CSVView().$el
      $('#welcomeTut').hide()
      $('#makeTut').show()


  hideResults: ->
    $('#waitingForModel').hide(1000);
this