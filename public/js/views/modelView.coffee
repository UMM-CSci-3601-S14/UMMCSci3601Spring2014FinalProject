class window.modelView extends Backbone.View
  tagName: 'div'
  template: _.template $('#modelMaker').html()

  events:
    'click button#hideWait' : 'hideWait'

      ###Big Blue Buttons###
    'click button#uploadCSV' : 'uploadCSV'
    'click button#makeCSV' : 'makeCSV'
    'click button#uploadZip' : 'uploadZip'

      ###Buttons Hidden Initally###
    'click button#editPrompt': 'editPrompt'
    'click button#savePrompt': 'savePrompt'

  initialize: ->
    @render()

  render: ->
    console.log 'Model'
    @$el.html @template()
    this

  uploadCSV: ->
    if fieldsFilled() is true
      fieldCollapse()
      $('#uploadZip').hide();
      $('#uploadCSV').hide();
      $('#makeCSV').hide();

      $('#welcomeTut').hide()
      $('#refreshWarning').hide()
      $('#csvArea').html new window.uploadCSVView().$el

  uploadZip: ->
    if fieldsFilled() is true
      fieldCollapse()
      $('#uploadZip').hide();
      $('#uploadCSV').hide();
      $('#makeCSV').hide();

      $('#welcomeTut').hide()
      $('#refreshWarning').hide()
      $('#whatIsCSV').hide()
      $('#csvArea').html new window.uploadZipView().$el

  makeCSV: ->
    if fieldsFilled() is true
      fieldCollapse()
      $('#uploadZip').hide();
      $('#uploadCSV').hide();
      $('#makeCSV').hide();

      $('#welcomeTut').hide()
      $('#whatIsCSV').hide()
      $('#fieldTut').show()
      $('#csvArea').html new window.CSVView().$el

  editPrompt: ->
    $('#editPrompt').hide();
    $('#savePrompt').show();

    $('#promptSpaceSmall').hide();
    $('#promptSpace').show();

  savePrompt: ->
    if fieldsFilled() is true
      fieldCollapse()
      $('#savePrompt').hide();

  hideWait: ->
    $('#waitingForModel').hide(1000);

this