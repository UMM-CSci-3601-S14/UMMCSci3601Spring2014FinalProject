class window.dashView extends Backbone.View
  tagName: 'div'
  template: _.template $('#dashboard').html()

  events:
    'click button#createModelBox' : 'loadModelMaker'
    'click button.yourPrompt': 'loadYourPrompts'

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

#    if user.prompts is undefined
#      $('#yourPrompt').hide()
#      $('#noPrompts').show()

    console.log 'loading models'
    i=0
    buttonString = ""
    buttonString1 = '<button class="box yourPrompts" id="'#id will be a url
    buttonString2 = '"><span class="glyphicon-large glyphicon glyphicon-ok-sign"></span><br /><span class="center dashBtn">'
    buttonString3 = '</span></button>'
    userPrompts = $.getJSON("/getPrompts").done ->
      console.log "success"
      userPrompts = userPrompts.responseJSON
      console.log userPrompts

      for i in userPrompts
        do (i) ->
          if i.length <= 50
            if i.indexOf(" ") >= 14
              x = i[0..14]
              x += '...'
              buttonString += buttonString1 + i + buttonString2 + x + buttonString3
            else

                buttonString += buttonString1 + i + buttonString2 + i + buttonString3
          else
            x = i[0..30]
            x += '...'
            buttonString += buttonString1 + i + buttonString2 + x + buttonString3

      $('#customModels').append(buttonString)

    this

  loadModelMaker: ->
    window.location.href = '/model-maker'

  loadYourPrompts: ->
    $('.yourPrompt').click ->
      prompt = this.id
      thePrompt = new request
      thePrompt.urlRoot = prompt
      thePrompt.fetch().done ->
        $('#promptTitle').html(thePrompt.attributes.title)
        $('#promptDescription').html(thePrompt.attributes.description)

  #    yourAnswerSet
        $('#yourModel').show()
        $('#essayContents').val("")
        $('#essayArea').show()

  loadEssay1: ->
    thePrompt = new prompt1().fetch().done ->
      $('#promptTitle').html('Prompt: ' +thePrompt.responseJSON.text)
      $('#promptDescription').html(thePrompt.responseJSON.description)
      theAuthor = new author({designator: "BG2", email: "test@gmail.com"}).fetch().done ->
      theAnswerSet = new answerSet1({
      }).fetch().done ->

      $('#yourModel').hide()
      $('#essayContents').val("")
      $('#essayArea').show()

  loadEssay2: ->
    thePrompt = new prompt2().fetch().done ->
      $('#promptTitle').html('Prompt: ' +thePrompt.responseJSON.text)
      $('#promptDescription').html(thePrompt.responseJSON.description)
      theAuthor = new author({designator: "BG2", email: "test@gmail.com"}).fetch().done ->
      theAnswerSet = new answerSet2({
      }).fetch().done ->

      $('#yourModel').hide()
      $('#essayContents').val("")
      $('#essayArea').show()

  hidePrompt: ->
    $('#essayArea').hide()

  submitEssay: ->
    # alerts user if no text has been entered
    if $('#essayContents').val() is ""
      alert "Please enter text to for LightSide to Grade."

    else

      $('#sandboxResults').show(500)

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
                    answerGraded = new answer

                  window.clearInterval looping

                if thePredictionStatus.attributes.status == 'U'

                  $('#grade').html("The grading process was unsucessful. Please wait before resubmitting.")
                  window.clearInterval looping

            ), 1000

  hideResults: ->
    $('#sandboxResults').hide(500)