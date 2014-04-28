class window.uploadCSVView extends Backbone.View
  tagName: 'div'
  template: _.template $('#uploadCSV').html()

  events:
    'change input#fileInput': 'submitCSV'
    'click button.submitCSV1': 'createPrompt'

  numFields = 0
  fieldArray = []
  fieldNames = []
  currentField = 1



  initialize: ->
    @render()

  render: ->
    console.log 'rendering uploadCSVView'
    @$el.html @template()
    this



  createPrompt: ->
    console.log 'in function'
    $('#waitingForModel').show(1000)

    # Collecting all the nessesary information from the page
    # Text and title are requeired to create a new prompt
    newTitle = promptTitle
    newText = promptTitle
    console.log newTitle + 'hello'
    # The prompt description is NOT required
    # but used for grading after model is created
    newDescription =  promptDescript
    # The Class description is required for the corpa
    newClass = cDescript

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
            form.append('file', $('#fileInput').get(0).files[0])
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
                                      console.log finalPrompt.attributes.url
                                      Backbone.ajax {
                                        type: "POST"
                                        url: "/addPrompt"
                                        data: JSON.stringify(
                                          promptArray: finalPrompt.attributes.url
                                        )
                                        success: ->
                                          console.log "worked"
                                        error: ->
                                          console.log "failed"
                                      }
                                      newAnswerSet = new createAnswerSet({"prompt": finalPrompt.attributes.url, "trained_models": finalPrompt.attributes.trained_models})

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


  submitCSV: ->
    document.getElementById('visFields').innerHTML = ""

    console.log numFields
    fileInput = document.getElementById("fileInput")
    fileDisplayArea = document.getElementById("fileDisplayArea")
    file = fileInput.files[0]
    textType = /text.*/
    if file.type.match(textType)
      reader = new FileReader()
      reader.onload = (e) ->
        doVisualization reader.result
        return

      reader.readAsText file
    else
      alert "File not supported!"

  #This function will call every visualization function in a chain.
  doVisualization = (csvString) ->
    currentField = 1
    numFields = 0
    fieldArray = []
    fieldNames = []
    #Hides #visHeader if nothing has been added
    $("#visHeader1").show()  if documentsAdded > 0

    #uses CSVParser.js to parse the myCSV string into an array
    parser = new CSVParser(csvString)

    #CSVarray is an array of arrays. The arrays inside the main array contain the information from one document and its fields.
    CSVArray = parser.array()
    array = new Array()
    endPoint = 0
    text = csvString
    newLine = "\r"
    if text.search("\r") == -1
      console.log "msagjhdfg"
      newLine = "\n"
    until text.search(newLine) is -1
      endPoint = text.search(newLine)
      array.push text.slice(0, endPoint)
      text = text.slice(endPoint + 1, text.length)

    fieldControl = array[0]
    console.log(fieldControl)
    numFields = 0
    until fieldControl.search(",") is -1
      console.log numFields
      endPoint = fieldControl.search(",")
      fieldNames.push fieldControl.slice(0, endPoint)
      fieldControl = fieldControl.slice(endPoint + 1, fieldControl.length)
      numFields++
    i = numFields
    j = i+1
    console.log('numFields:' + numFields)
    while i > 0
      divID = "visField" + (j - i)
      document.getElementById('visFields').innerHTML = document.getElementById('visFields').innerHTML + "<div id='" + divID +  "' class='visualization'></div>"
      i--

    ##array = array[1..array.length-1]
    #sends the array from the csv into the getFields()
    i = 0
    while i < array.length
      inputText = array[i]
      #console.log inputText
      j = 0
      fieldArray = []
      while j < numFields
        #console.log inputText
        endPoint = inputText.search(",")
        fieldArray.push inputText.slice(0, endPoint)
        inputText = inputText.slice(endPoint + 1, inputText.length)
        j++
      fieldArray.push inputText
      array[i] = fieldArray
      i++
    console.log "Hended to getFields"
    console.log array

    getFields array
    return
  getFields = (CSVArray) ->
    arrayOfArrays = new Array()
    i = 0

    while i < numFields
      arrayOfArrays[i] = new Array()
      j = 0

      while j < CSVArray.length
        arrayOfArrays[i][j] = CSVArray[j][i]
        j++
      i++

    #sets arrayOfArrays to be an array of each field (including the field name at the first index of each sub-array!).
    countGrades arrayOfArrays
    return
  countGrades = (arrayOfArrays) ->

    #arrayOfDicts will contain a dictionary of occurrences for each field
    arrayOfDict = new Array()
    i = 0
    while i < numFields
      #Add the dictionary to arrayOfDicts
      arrayOfDict.push generateMap(arrayOfArrays[i])
      console.log "LOOK AT MNENAKLRJ"
      console.log arrayOfDict
      #Runs createData on each field
      createData i, arrayOfDict
      i++
    return
  generateMap = (arrayOfStrings) ->

    #Makes a dictionary of key value pairs based on occurrences within the given array. Returns the dictionary.
    map = new Dictionary()
    i = 1

    while i < arrayOfStrings.length
      entry = arrayOfStrings[i]
      map.add entry
      i++
    map

  #fieldNum is the index that a field is on
  createData = (fieldNum, arrayOfDict) ->
    tempValue = undefined
    tempKey = undefined
    totalValue = 0
    numOfKeys = 0
    #divID = "visField" + (fieldNum + 1)
    #array of the field entries and the occurrences of them in an object for each index of the array
    dataPointsTemplate = new Array()

    i = 0
    console.log arrayOfDict[0]
    areYouGood = "All of the data you submitted looks good! Click the button below to make your model"
    while i < arrayOfDict[fieldNum].keys.length
      tempValue = arrayOfDict[fieldNum].values[i]
      if tempValue <= 100 and tempValue > 50
        areYouGood = "It looks like one or more of your fields doesn't have enough of one value. For a optimal model you should have 100 of each submition. You may proceed to make a model but it is not advised. "
      if tempValue <= 50
        areYouGood = "It looks like one or more of your fields doesn't have enough of one value. For a optimal model you should have 100 of each submition. Add more values before proceeding to make a model. "
      tempKey = (arrayOfDict[fieldNum].keys[i]).toString()
      console.log
      dataPointsTemplate.push
        y: tempValue
        indexLabel: tempKey
      totalValue += tempValue
      numOfKeys++

      i++

    dataTemplate = [
      type: "doughnut"
      dataPoints: dataPointsTemplate
    ]

    #This "if" is here so only graphs with less than 200 sections are shown
    if numOfKeys < 150
      divID = "visField" + currentField

      #chart object
      chart = new CanvasJS.Chart(divID,
        title:
          text: fieldNames[currentField]

        data: dataTemplate
        backgroundColor: "transparent"
      )


      #renders the chart
      console.log "SOMTHIN"
      chart.render()
      document.getElementById("results").innerHTML = areYouGood
      currentField++
    return

  #Dictionary class and methods. Custom data structure!! :D
  Dictionary = ->
    @keys = []
    @values = []
    @add = (entry) ->
      index = @keys.indexOf(entry)
      if -1 is index
        @keys.push entry
        @values.push 1
        @length is (@length + 1)
      else
        @values[index ] = (@values[index] + 1)
      return

    @getValue = (key) ->
      index = @keys.indexOf(key)
      @values[index]

    return