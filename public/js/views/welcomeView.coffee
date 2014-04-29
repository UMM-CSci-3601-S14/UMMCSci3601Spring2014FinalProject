class window.welcomeView extends Backbone.View
  tagName: 'div'
  template: _.template $('#welcomePage').html()

  events:
    'click button.submitEssay': 'submitEssay'
    'click button#hideResults' : 'hideResults'
    'click button#more' : 'showExtra'
    'click button#less' : 'hideExtra'

  thePrompt = null

  initialize: ->
    thePrompt = new prompt1().fetch().done ->
      $('#promptTitle').html('Prompt: ' + thePrompt.responseJSON.text)
      $('#promptDescription').html(thePrompt.responseJSON.description)
    @render()
    return

  render: ->
    @$el.html @template()
    this

  showExtra: ->
    $('.extra').show()
    $('.hide').show()
    $('#more').hide()
    $('#less').show()

  hideExtra: ->
    $('.extra').hide()
    $('#more').show()
    $('#less').hide()

  submitEssay: ->
    # Alerts user if no text has been entered
    if $('#essayContents').val() is ""
      alert "Please enter text to for LightSide to Grade."

    else

      $('#sandboxResults').show(500)
      # Get default author and answer set
      theAuthor = new author({designator: "LightsideDefault", email: "test@gmail.com"}).fetch().done ->
        theAnswerSet = new answerSet1().fetch().done ->

          # Create answer from contents of #essayContents
          theAnswer = new answer({
            author: theAuthor.responseJSON.results[0].url
            answer_set: theAnswerSet.responseJSON.url
            text:  $('#essayContents').val()
          }).save().done ->

            # Post a prediction task to calculate the grade of the essay.
            thePredictionTask = new predictionTask({
              answer_set: theAnswerSet.responseJSON.url
              trained_model: thePrompt.responseJSON.default_models[0]
            }).save().done ->

              # Adds the prediction task to the process queue
              theProcess = new request()
              theProcess.urlRoot = thePredictionTask.responseJSON.process
              theProcess.save().done ->

                # Request for checking status of essay grade calculation every second
                thePredictionStatus = new request()
                looping = setInterval (->

                  thePredictionStatus.urlRoot = theProcess.attributes.url
                  thePredictionStatus.fetch().done ->

                    if thePredictionStatus.attributes.status == 'S'

                      # Gets the grade
                      thePredictionResult = new predictionResult().fetch().done ->
                        $('#grade').html("Your grade for the submitted essay is " +
                        thePredictionResult.responseJSON.results[0].label + " out of 5.")

                      window.clearInterval looping

                    if thePredictionStatus.attributes.status == 'U'

                      $('#grade').html("The grading process was unsucessful. Please wait before resubmitting.")
                      window.clearInterval looping

                ), 1000

  hideResults: ->
    $('#sandboxResults').hide(500);