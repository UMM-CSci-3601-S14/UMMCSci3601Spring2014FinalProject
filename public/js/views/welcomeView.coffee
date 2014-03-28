class window.welcomeView extends Backbone.View
  tagName: 'div'
  template: _.template $('#welcomePage').html()
  events:
    'click button.submitEssay': 'submitEssay'
    'click button#hideResults' : 'hideResults'



  initialize: ->
    thePrompt = new prompt().fetch().done ->
        #console.log(thePrompt.responseJSON)
        $('#promptContents').html(thePrompt.responseJSON.text)
#    theAnswer = new answer().fetch().done ->
#      console.log(theAnswer.responseJSON)
    @render()
    return

  render: ->
    @$el.html @template()
    this

  submitEssay: ->
    $('#sandboxResults').show(1000);
    console.log 'in function' #currently not firing
    postAnswer = new answer({text: $('#essayContents').val()})
    postAnswer.fetch().done ->
      newTask = new predictionTask()
      newTask.fetch()
    this

  hideResults: ->
    $('#sandboxResults').hide(1000);