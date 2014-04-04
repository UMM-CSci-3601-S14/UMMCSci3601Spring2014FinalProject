class window.welcomeView extends Backbone.View
  tagName: 'div'
  template: _.template $('#welcomePage').html()
  events:
    'click button.submitEssay': 'submitEssay'
    'click button#hideResults' : 'hideResults'



  initialize: ->
    thePrompt = new prompt().fetch().done ->
      console.log thePrompt
    @render()
    return

  render: ->
    @$el.html @template()
    this

  submitEssay: ->
    $('#sandboxResults').show(1000);
    thePrompt = new prompt().fetch().done ->
      console.log thePrompt
      #console.log(thePrompt.responseJSON)
      $('#promptContents').html(thePrompt.responseJSON.text)
      theAuthor = new author({designator: "BG2", email: "test@gmail.com"}).fetch().done ->

        #theClone = new clonePrompt().save()
        console.log theAuthor
        theAnswerSet = new ourAnswerSet({
        }).fetch().done ->

          console.log theAnswerSet
          theAnswer = new answer({
            author: theAuthor.responseJSON.results[0].url
            answer_set: theAnswerSet.responseJSON.url
          #text: "sup."
            text:  $('#essayContents').val()
          }).save().done ->

            console.log theAnswer
            thePredictionTask = new predictionTask({
              answer_set: theAnswerSet.responseJSON.url
              trained_model: thePrompt.responseJSON.default_models[0]
            }).save().done ->

              thePredictionResult = new predictionResult().fetch().done ->
                console.log thePredictionResult.responseJSON
                answerGraded = new answer

  hideResults: ->
    $('#sandboxResults').hide(1000);