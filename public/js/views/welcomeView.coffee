class window.welcomeView extends Backbone.View
  tagName: 'div'
  template: _.template $('#welcomePage').html()
  events:
    'click button.submitEssay': 'submitEssay'
    'click button#hideResults' : 'hideResults'

  thePrompt = null

  initialize: ->
    thePrompt = new prompt().fetch().done ->
      $('#promptTitle').html('Prompt: ' +thePrompt.responseJSON.text)
      $('#promptDescription').html(thePrompt.responseJSON.description)
      console.log thePrompt
    @render()
    return

  render: ->
    @$el.html @template()
    this



  submitEssay: ->
    $('#sandboxResults').show(1000)
#    thePrompt = new prompt().fetch().done ->
#      console.log thePrompt
      #console.log(thePrompt.responseJSON)

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
              console.log thePredictionTask.responseJSON.process
              theProcess = new predictionProcess()
              theProcess.urlRoot = thePredictionTask.responseJSON.process
              theProcess.save().done ->
                thePredictionStatus = new predictionStatus()

                # a loop to wait for the api to return contact
                console.log "----------------------------------------"

                looping = setInterval (->
                  #delay for 1 second
                  thePredictionStatus.urlRoot = theProcess.attributes.prediction_task[0..3] + "s" + theProcess.attributes.prediction_task[4..]
                  thePredictionStatus.fetch().done ->
                    console.log "Prediction Task status: " + thePredictionStatus.responseJSON.attributes.status
                    console.log theProcess.attributes.prediction_task

                    if thePredictionStatus.responseJSON.attributes.status == 'S'
                      console.log "Prediction Task was SUCCESSFUL"
                      console.log "exited while loop"
                      thePredictionResult = new predictionResult().fetch().done ->
                        console.log thePredictionResult.responseJSON
                        answerGraded = new answer
                      window.clearInterval looping

                    if thePredictionStatus.responseJSON.attributes.status == 'U'
                      console.log "Prediction Task was UNSUCCESSFUL"
                      window.clearInterval looping
                ), 1000


  hideResults: ->
    $('#sandboxResults').hide(1000);