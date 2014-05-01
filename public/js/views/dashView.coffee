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
#    console.log 'dash'
    @$el.html @template()

#    console.log 'loading models'
    i=0
    buttonString = ""
    buttonString1 = '<button class="box yourPrompts" id="'#id will be a url
    buttonString2 = '"><span class="glyphicon-large glyphicon glyphicon-ok-sign"></span><br /><span class="center dashBtn">'
    buttonString3 = '</span></button>'
    userPrompts = $.getJSON("/getPrompts").done ->
#      console.log "success"
      userPrompts = userPrompts.responseJSON
#      console.log userPrompts

      for p in userPrompts
        #The p is the url that holds the prompt within Lightside
        do (p) ->
          #yourPrompt = new request
          #yourPrompt.urlRoot = p
          #yourPrompt.fetch().done ->

            #promptTitle = yourPrompt.attributes.title
            #check if the prompt title is to long to fit on the button
            #if promptTitle.length <= 50
            if p.length <= 50
              #check for spaces with in reasonable length,
              # if so shorten to 14 characters and add ...
              #if promptTitle.indexOf(" ") >= 14
              if p.indexOf(" ") >= 14
                shortTitle = p[0..14]
                shortTitle += '...'
                buttonString += buttonString1 + p + buttonString2 + shortTitle + buttonString3
              #if the length of the title is less than 50 and there are reasonable spaces
              #then add the title as is
              else
                  buttonString += buttonString1 + p + buttonString2 + p + buttonString3

            #if the title is more than 50 characters
            else
              #check for spaces with in reasonable length,
              # if so shorten further to 14 characters and add ...
              if p.indexOf(" ") >= 14
                shorterTitle = p[0..14]
                shorterTitle += '...'
                buttonString += buttonString1 + p + buttonString2 + shorterTitle + buttonString3
              else
                shortTitle = p[0..25]
                shortTitle += '...'
                buttonString += buttonString1 + p + buttonString2 + shortTitle + buttonString3

#     append the buttons to the div 'customModels'
      $('#customModels').append(buttonString)

    this

  loadModelMaker: ->
    window.location.href = '/model-maker'

  loadYourPrompts: ->
    #when you click any of your made prompts
    $('.yourPrompts').click ->
      prompt = this.id
      thePrompt = new request
      thePrompt.urlRoot = prompt
      thePrompt.fetch().done ->
        $('#promptTitle').html(thePrompt.attributes.title)
        $('#promptDescription').html(thePrompt.attributes.description)

  #    yourAnswerSet

        $('#essayContents').val("")
        $('#yourModel').show()
        $('#essayArea').show()

  loadEssay1: ->
    thePrompt = new prompt1().fetch().done ->
      $('#promptTitle').html('Prompt: ' +thePrompt.responseJSON.text)
      $('#promptDescription').html(thePrompt.responseJSON.description)
      theAuthor = new author({designator: "BG2", email: "test@gmail.com"}).fetch().done ->
      theAnswerSet = new answerSet1({
      }).fetch().done ->

      $('#essayContents').val("")
      $('#yourModel').hide()
      $('#essayArea').show()

  loadEssay2: ->
    thePrompt = new prompt2().fetch().done ->
      $('#promptTitle').html('Prompt: ' +thePrompt.responseJSON.text)
      $('#promptDescription').html(thePrompt.responseJSON.description)
      theAuthor = new author({designator: "BG2", email: "test@gmail.com"}).fetch().done ->
      theAnswerSet = new answerSet2({
      }).fetch().done ->

      $('#essayContents').val("")
      $('#yourModel').hide()
      $('#essayArea').show()

  hidePrompt: ->
    $('#essayArea').hide()

  submitEssay: ->
#   alerts user if no text has been entered
    if $('#essayContents').val() is ""
      alert "Please enter text to for LightSide to Grade."

    else

      $('#sandboxResults').show(500)

      theAnswer = new answer({
        author: theAuthor.responseJSON.results[0].url
        answer_set: theAnswerSet.responseJSON.url
        text:  $('#essayContents').val()
      }).save().done ->

#       Post a prediction task to calculate the grade of the essay.
        thePredictionTask = new predictionTask({
          answer_set: theAnswerSet.responseJSON.url
          trained_model: thePrompt.responseJSON.default_models[0]
        }).save().done ->

#         Adds the prediction task to the process queue
          theProcess = new request()
          theProcess.urlRoot = thePredictionTask.responseJSON.process
          theProcess.save().done ->

#           Request for checking status of essay grade calculation every second
            thePredictionStatus = new request()
            looping = setInterval (->

              thePredictionStatus.urlRoot = theProcess.attributes.url
              thePredictionStatus.fetch().done ->

                if thePredictionStatus.attributes.status == 'S'

#                 Gets the grade
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