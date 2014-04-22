class window.modelView extends Backbone.View
  tagName: 'div'
  template: _.template $('#modelPage').html()

  events:
    'click button#createPrompt': 'createPrompt'
    'click button#hideWait' : 'hideWait'
    'click button#uploadCSV' : 'uploadCSV'
    'click button#makeCSV' : 'makeCSV'


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
    # Text and title are requeired to create a new prompt
    newTitle =  $('#title').val()
    newText =  $('#title').val()
    # The prompt description is NOT required
    # but used for grading after model is created
    newDescription =  $('#description').val()
    # The Class description is required for the corpa
    newClass = $('#cDescription').val()

    # Start process to creat a new model
    # First create the new Prompt
    newPrompt = new createPrompt({
      title: newTitle
      text: newText
      description: newDescription
    }).save().done ->
      console.log newPrompt.responseJSON.url

      # Then set up the corpus that will hold the model and all of the answers
      newCorpus = new createCorpora({
        prompt: newPrompt.responseJSON.url
        description: newClass
      }).save().done ->

        # Attempting to load a csv for trainging answers in the corpus
        # General upload object
        newCorpusUpload = new corpusUploadTasks().fetch().done ->

          # Getting security paramiters for S3 to upload the cvs in mass,
          #  We get access but now have a 412 (Precondition Failed)
          s3Request = new request()
          s3Request.url = 'https://try-api.lightsidelabs.com/api/corpus-upload-parameters'
          s3Request.fetch().done ->
            form = new FormData()
            form.append('AWSAccessKeyId', s3Request.attributes.access_key_id)
            form.append('key', s3Request.attributes.key)
            form.append('policy', s3Request.attributes.policy)
            form.append('signature', s3Request.attributes.signature)
            form.append('acl', 'public-read')
            form.append('success_action_status', '201')
            form.append('file', $('#file').get(0).files[0])
            xhr = new XMLHttpRequest()
            xhr.open('POST', "https://lightsidelabs-try.s3.amazonaws.com/", true)
            xhr.onreadystatechange = ->
              if(xhr.readyState == 4)
                s3Key = $(xhr.responseXML).find("Key").first().text()
                console.log s3Key
                # Start of upload, with the corpus' url, the (unsuccessful) s3 key that containes the csv, and the type id for the csv
                newUploadTask = new corpusUploadTasks({
                  corpus: newCorpus.responseJSON.url
                  s3_key: s3Key
                  content_type: 'text/csv'
                }).save().done ->
                  uploadQueue = new request()
                  uploadQueue.urlRoot = newUploadTask.responseJSON.process
                  uploadQueue.save().done ->
                    uploadTask = new request()
                    console.log newUploadTask.responseJSON.url
                    uploadTask.urlRoot = newUploadTask.responseJSON.url
                    count = 0
                    ## a loop to wait for the api to build the model, waits 1 second(need to make this longer)
                    looping
                    looping = setInterval (->
                      count++
                      uploadTask.fetch().done ->

                          # If the model is complete then the upload task's status will change to 'S' and we can exit the loop
                        # and beging to interact with the model


                        if uploadTask.attributes.status == 'S'
                          console.log "Upload Task was SUCCESSFUL"
                          console.log newUploadTask.responseJSON
                          console.log count
                          trainingTask = new trainingTasks({corpus: newCorpus.responseJSON.url}).save().done ->
                            addTrainTask = new request()
                            addTrainTask.url = trainingTask.responseJSON.process;
                            addTrainTask.save().done ->
                              console.log addTrainTask
                              pollTrainTask = new request()
                              pollTrainTask.url = trainingTask.responseJSON.url

                              trainTaskLoop = setInterval (->
                                pollTrainTask.fetch().done ->

                                  if pollTrainTask.attributes.status == 'S'
                                    window.alert 'Training task was SUCCESSFUL'
                                    finalPrompt = new createPrompt({title: newPrompt.responseJSON.title, text: newPrompt.responseJSON.text, description: newPrompt.responseJSON.description, default_models: [pollTrainTask.attributes.trained_model]})
                                    finalPrompt.save().done ->

                                    window.clearInterval trainTaskLoop

                                  if pollTrainTask.attributes.status == 'U'
                                    window.alert 'Training task was UNSUCCESSFUL'
                                    window.clearInterval trainTaskLoop

                              ), 1000
                          window.clearInterval looping







                        #If the model has failed to be made then the upload task's status will change to 'U' and we need exit the loop
                        if uploadTask.attributes.status == 'U'
                          console.log "Prediction Task was UNSUCCESSFUL"
                          window.clearInterval looping
                          window.alert("Your Model Has Failed. Please review your csv for the proper format and try again.")

                      ), 1000


            xhr.send(form)


  uploadCSV: ->
    $('#uploadBox').html new window.uploadCSVView().$el

  makeCSV: ->
    $('#uploadBox').html new window.CSVView().$el


  hideResults: ->
    $('#waitingForModel').hide(1000);
this