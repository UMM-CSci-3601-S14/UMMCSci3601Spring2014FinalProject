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
      theAuthor = new author({designator: "BG2", email: "test@gmail.com"}).fetch()
      #theClone = new clonePrompt().save()
      theAnswerSet = new answerSet({prompt: thePrompt.responseJSON.url, "trained-models": thePrompt.responseJSON.default_models[0]}).save()

    @render()
    return

  render: ->
    @$el.html @template()
    this

  submitEssay: ->
    $('#sandboxResults').show(1000);
    console.log 'in function'
    postAnswer = new answer({parent: null, author: null, answer_set: null, text: "blah"}).save()



  hideResults: ->
    $('#sandboxResults').hide(1000);