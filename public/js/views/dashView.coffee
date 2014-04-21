class window.dashView extends Backbone.View
  tagName: 'div'
  template: _.template $('#dashboard').html()

  events:
    'click button#createModelBox' : 'loadCSVPage'
    'click button#yourModels': 'loadModelsInAccount'

    'click button#pickEssay1' : 'loadEssay1'
    'click button#pickEssay2' : 'loadEssay2'

    'click button.submitEssay': 'submitEssay'
    'click button#hidePrompt': 'hidePrompt'
    'click button#hideResults' : 'hideResults'

  thePrompt = null
  theAuthor = null
  theAnswerSet = null

  initialize: ->
    @render()
    return

  render: ->
    console.log 'dash'
    @$el.html @template()
    this

  loadCSVPage: ->
    window.location.href = '/csvPage'

  loadModelsInAccount: ->
    $('#modelsInAccount').show()

  loadEssay1: ->
    thePrompt = new prompt1().fetch().done ->
      $('#promptTitle').html('Prompt: ' +thePrompt.responseJSON.text)
      $('#promptDescription').html(thePrompt.responseJSON.description)

      theAuthor = new author({designator: "BG2", email: "test@gmail.com"}).fetch().done ->

      theAnswerSet = new answerSet1({
      }).fetch().done ->

      $('#essayArea').show()

  loadEssay2: ->
    thePrompt = new prompt2().fetch().done ->
      $('#promptTitle').html('Prompt: ' +thePrompt.responseJSON.text)
      $('#promptDescription').html(thePrompt.responseJSON.description)

      theAuthor = new author({designator: "BG2", email: "test@gmail.com"}).fetch().done ->

      theAnswerSet = new answerSet2({
      }).fetch().done ->

      $('#essayArea').show()


  submitEssay: ->
    # alerts user if no text has been entered
    if $('#essayContents').val() is ""
      alert "Please enter text to for LightSide to Grade."

    else
      #Start calls to LightSide API

      #Show results area
      $('#sandboxResults').show(500)

      #Begin calls to the LightSide API
#      theAuthor = new author({designator: "BG2", email: "test@gmail.com"}).fetch().done ->
#
#        theAnswerSet = new answerSet1({
#        }).fetch().done ->

      theAnswer = new answer({
        author: theAuthor.responseJSON.results[0].url
        answer_set: theAnswerSet.responseJSON.url
        text:  $('#essayContents').val()
      }).save().done ->

        # We start the process for getting a grade for the essay written in the answer area
        thePredictionTask = new predictionTask({
          answer_set: theAnswerSet.responseJSON.url
          trained_model: thePrompt.responseJSON.default_models[0]
        }).save().done ->

          #request sent to the api for processing
          theProcess = new request()
          theProcess.urlRoot = thePredictionTask.responseJSON.process
          theProcess.save().done ->

            #request used to checks status of the prediction process
            thePredictionStatus = new request()


            # a loop to wait for the api to grade the answer, waits 1 second.
            looping = setInterval (->

              # To make sure that we send to https in stead of the http that theProcess returns
              thePredictionStatus.urlRoot = theProcess.attributes.prediction_task[0..3] + "s" + theProcess.attributes.prediction_task[4..]
              thePredictionStatus.fetch().done ->

                console.log "Prediction Task status: " + thePredictionStatus.attributes.status

                # If the grading is compleat then the status will be set to 'S' and we can exit the loop and return the grade
                if thePredictionStatus.attributes.status == 'S'
                  console.log "Prediction Task was SUCCESSFUL"

                  # Get the result from the api, and grab the grade from that JSON object
                  thePredictionResult = new predictionResult().fetch().done ->
                    $('#grade').html("Your grade for the submitted essay is " +
                    thePredictionResult.responseJSON.results[0].label + " out of 5.")

                    answerGraded = new answer

                  # Ternimate loop.
                  window.clearInterval looping

                # If the grading was rejected then the status will be set to 'U' and there is no point in continuing the loop
                if thePredictionStatus.attributes.status == 'U'
                  console.log "Prediction Task was UNSUCCESSFUL"
                  $('#grade').html("The grading process was unsucessful. Please wait before resubmitting.")

                  # Terminate loop
                  window.clearInterval looping
            ), 1000

  hidePrompt: ->
    $('#essayArea').hide()

  hideResults: ->
    $('#sandboxResults').hide(500)