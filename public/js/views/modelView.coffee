class window.modelView extends Backbone.View
  tagName: 'div'
  template: _.template $('#modelPage').html()

  events:
    'click button#createPrompt': 'createPrompt'
    'click button#hideWait' : 'hideWait'

  initialize: ->
    @render()

  render: ->
    console.log 'Model'
    @$el.html @template()
    this

  createPrompt: ->
    console.log 'in function'
    $('#waitingForModel').show(1000)

    # Collecting all the nessesary information from the page
    newTitle =  $('#title').val()
    newText =  $('#text').val()
    newDescription =  $('#description').val()
    newClass = $('#cDescription').val()
    newcsv = $('#file').val()

    # Start process to creat a new model
    # First the new Prompt
    newPrompt = new createPrompt({
      title: newTitle
      text: newText
      description: newDescription
    }).save().done ->
      console.log newPrompt.responseJSON.url

      # Then the corpus that will hold the model and all of the answers
      newCorpus = new createCorpora({
        prompt: newPrompt.responseJSON.url
        description: newClass
      }).save().done ->

        # Attempting to load a csv for trainging answers in the corpus,not currently working
        # General upload object
        newCorpusUpload = new corpusUploadTasks().fetch().done ->
          # Attempt to load the csv in mass, unsure of s3_key's
          newUploadTask = new corpusUploadTasks({
            corpus: newCorpus.responseJSON.url
            s3_key: '/home/harre096/Downloads/essay.csv'
            content_type: 'text/csv'
          }).save().done ->
            console.log newUploadTask.responseJSON
            uploadQueue = new theRequest()
            uploadQueue.urlRoot = newUploadTask.responseJSON.process
            console.log newUploadTask.responseJSON.process
            uploadQueue.save().done ->
              console.log 'helllp'
              console.log uploadQueue
              uploadTask = new theRequest()
              uploadTask.urlRoot = uploadQueue.attributes.corpus_upload_task[0..3] + "s" + uploadQueue.attributes.corpus_upload_task[4..]
              console.log "----------------------------------------"
              count = 0

              ## a loop to wait for the api to build the model, waits 1 second(need to make this longer)
              looping
              looping = setInterval (->
                count++
                uploadTask.fetch().done ->

                    # If the model is compleat then the upload task's status will change to 'S' and we can exit the loop
                  # and beging to interact with the model


                  if uploadTask.attributes.status == 'S'
                    console.log "Prediction Task was SUCCESSFUL"
                    console.log "exited while loop"
                    console.log newUploadTask.responseJSON
                    console.log count
                    window.clearInterval looping
                    window.alert("Your Model Has Been Made")

                  #If the model has failed to be made then the upload task's status will change to 'U' and we need exit the loop
                  if uploadTask.attributes.status == 'U'
                    console.log "Prediction Task was UNSUCCESSFUL"
                    window.clearInterval looping
                    window.alert("Your Model Has Failed. Please review your csv for the proper format and try again.")

                ), 1000


  hideResults: ->
    $('#waitingForModel').hide(1000);
this