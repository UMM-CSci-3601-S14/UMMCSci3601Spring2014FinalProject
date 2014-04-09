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

        #this is not used because we only need one clone
        #theClone = new clonePrompt().save()
        console.log theAuthor
        theAnswerSet = new ourAnswerSet({
        }).fetch().done ->

          console.log theAnswerSet

          theAnswer = new answer({
            author: theAuthor.responseJSON.results[0].url
            answer_set: theAnswerSet.responseJSON.url
            text:  $('#essayContents').val()
          }).save().done ->
            console.log theAnswer

            # We start the process for getting a grade for the essay written in the answer area
            thePredictionTask = new predictionTask({
              answer_set: theAnswerSet.responseJSON.url
              trained_model: thePrompt.responseJSON.default_models[0]
            }).save().done ->
              console.log thePredictionTask.responseJSON.process

              theProcess = new theRequest()
              theProcess.urlRoot = thePredictionTask.responseJSON.process
              theProcess.save().done ->

                thePredictionStatus = new theRequest()

                # a loop to wait for the api to grade the answer, waits 1 second.
                console.log "----------------------------------------"
                count = 0

                looping
                looping = setInterval (->
                  count++

                  # To make sure that we send to https in stead of the http that theProcess returns
                  thePredictionStatus.urlRoot = theProcess.attributes.prediction_task[0..3] + "s" + theProcess.attributes.prediction_task[4..]
                  console.log thePredictionStatus.urlRoot
                  thePredictionStatus.fetch().done ->

                    console.log "Prediction Task status: " + thePredictionStatus.attributes.status
                    console.log theProcess.attributes.prediction_task

                    # If the grading is compleat then the status will be set to 'S' and we can exit the loop and return the grade
                    if thePredictionStatus.attributes.status == 'S'
                      console.log "Prediction Task was SUCCESSFUL"
                      console.log "exited while loop"

                      # Get the result from the api, and grab the grade from that JSON object
                      thePredictionResult = new predictionResult().fetch().done ->
                        console.log thePredictionResult.responseJSON
                        $('#grade').html("Your grade for the submitted essay is " +thePredictionResult.responseJSON.results[0].label+ " out of 5.")
                        answerGraded = new answer
                      console.log count
                      # Stop the loop from continuing
                      window.clearInterval looping

                    # If the grading was rejected then the status will be set to 'U' and there is no point in continuing the loop
                    if thePredictionStatus.attributes.status == 'U'
                      console.log "Prediction Task was UNSUCCESSFUL"
                      $('#grade').html("The grading process was unsucessful. Pleas wait befor resubmitting.")
                      # Stop the loop from continuing
                      window.clearInterval looping
                ), 1000


  hideResults: ->
    $('#sandboxResults').hide(1000);