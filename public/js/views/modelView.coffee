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
    # Text and title are requeired to create a new prompt
    newTitle =  $('#title').val()
    newText =  $('#text').val()
    # The prompt description is NOT required
    # but used for grading after model is created
    newDescription =  $('#description').val()
    # The Class description is required for the corpa
    newClass = $('#cDescription').val()
    # The CSV is required to send to s3
    newcsv = $('#file').val()

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
          s3Request.urlRoot = 'https://try-api.lightsidelabs.com/api/corpus-upload-parameters'

          s3Request.fetch().done ->
            s3Post = new request({
              AWSAccessKeyId: s3Request.attributes.access_key_id
              key: s3Request.attributes.key
              acl: 'public-read'
              Policy: s3Request.attributes.policy
              Signature: s3Request.attributes.signature
              success_action_status: '201'}
              {file: newcsv})
            s3Post.urlRoot= s3Request.attributes.s3_endpoint
            s3Post.save().done ->

              # Start of upload, with the corpus' url, the (unsuccessful) s3 key that containes the csv, and the type id for the csv
              newUploadTask = new corpusUploadTasks({
                corpus: newCorpus.responseJSON.url
                ##s3_key: '/home/harre096/Downloads/essay.csv' to be changed after we get s3 permission
                content_type: 'text/csv'
              }).save().done ->
                console.log newUploadTask.responseJSON
                uploadQueue = new request()
                uploadQueue.urlRoot = newUploadTask.responseJSON.process
                console.log newUploadTask.responseJSON.process
                uploadQueue.save().done ->
                  console.log 'helllp'
                  console.log uploadQueue
                  uploadTask = new request()
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