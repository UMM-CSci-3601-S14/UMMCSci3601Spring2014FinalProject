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
    @$el.html @template()
    this

  createPrompt: ->
    $('#waitingForModel').show(1000)

    # Collecting all the nessesary information from the page
    # Text and title are requeired to create a new prompt
    newTitle = promptTitle
    newText = promptTitle
    # The prompt description is NOT required
    # but used for grading after model is created
    newDescription =  promptDescript
    # The Class description is required for the corpa
    newClass = cDescript

    # Start process to create a new model
    # First create the new Prompt
    newPrompt = new createPrompt({
      title: newTitle
      text: newText
      description: newDescription
    }).save().done ->

      # Then set up the corpus that will hold the model and all of the answers
      newCorpus = new createCorpora({
        prompt: newPrompt.responseJSON.url
        description: newClass
      }).save().done ->

        # Attempting to load a csv for trainging answers in the corpus
        # General upload object
        newCorpusUpload = new corpusUploadTasks().fetch().done ->

          # Getting security parameters for S3 to upload the cvs in mass,
          s3Request = new request()
          s3Request.url = 'https://try-api.lightsidelabs.com/api/corpus-upload-parameters'
          s3Request.fetch().done ->

            # Uploading the CSV to S3
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

              # If the post was successful
              if(xhr.readyState == 4)

                # Getting the s3 key from the returned XML needed for the corpus upload task
                s3Key = $(xhr.responseXML).find("Key").first().text()
                # Posting the Corpus Upload Task to LightSide
                newUploadTask = new corpusUploadTasks({
                  corpus: newCorpus.responseJSON.url
                  s3_key: s3Key
                  content_type: 'text/csv'
                }).save().done ->

                  # Adding the Upload Task to LightSide's Queue
                  uploadQueue = new request()
                  uploadQueue.urlRoot = newUploadTask.responseJSON.process
                  uploadQueue.save().done ->

                    uploadTask = new request()
                    uploadTask.urlRoot = newUploadTask.responseJSON.url
                    count = 0
                    # A loop to wait for the api to build the model, checks the status every second.
                    looping

                    looping = setInterval (->

                      count++
                      # uploadTask checks the status of the Corpus Upload Task
                      uploadTask.fetch().done ->

                        if uploadTask.attributes.status == 'S'
                          trainingTask = new trainingTasks({corpus: newCorpus.responseJSON.url}).save().done ->

                            # Once the corpus is uploaded, a training task is made to produce a trained model from the
                            # corpus.
                            addTrainTask = new request()
                            addTrainTask.url = trainingTask.responseJSON.process;
                            addTrainTask.save().done ->

                              # pollTrainTask checks the status of the model training task
                              pollTrainTask = new request()
                              pollTrainTask.url = trainingTask.responseJSON.url

                              # trainTaskLoop checks the status of the model training task every second
                              trainTaskLoop = setInterval (->
                                pollTrainTask.fetch().done ->

                                  if pollTrainTask.attributes.status == 'S'

                                    # Add the trained model to a prompt
                                    $('#waitMessage').text('Your model has been successfully made!')
                                    window.alert 'Training task was SUCCESSFUL'
                                    finalPrompt = new createPrompt({title: newPrompt.responseJSON.title, text: newPrompt.responseJSON.text, description: newPrompt.responseJSON.description, default_models: [pollTrainTask.attributes.trained_model]})
                                    finalPrompt.save().done ->

                                      # Posting the prompt url to the prompt array associated with the logged in user.
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
                                    $('#waitMessage').text('Making your model was unsuccessful')
                                    window.alert 'Making your model was UNSUCCESSFUL. Please contact LightSide for further assistance'
                                    window.clearInterval trainTaskLoop

                              ), 1000
                          window.clearInterval looping

                        if uploadTask.attributes.status == 'U'
                          $('#waitMessage').text('Uploading your CSV was UNSUCCESSFUL')
                          window.clearInterval looping
                          window.alert("Uploading your CSV was UNSUCCESSFUL. Please review your csv for the proper format and try again.")

                    ), 1000

            xhr.send(form)

  # This function begins the process of visualization. It grabs the inputed csv and sends it to doVizualization
  submitCSV: ->

    document.getElementById('visFields').innerHTML = ""
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

  # doVisualization takes the string format of the csv and begins to visualize the data, first it grabs the first line to determine
  # the names of the feilds. It then seperates each input of the csv into an array, and creates the divs in the html to hold the graphs that will be made.
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
      newLine = "\n"
      if text.search("\n") == -1
        newLine = "\n\r"
        if text.search("\n\r") == -1
          newLine = "\r\n"
          if text.search("\r\n") == -1
            alert("Your CSV does not seem to have any content. Please review and re-submit.")
    until text.search(newLine) is -1
      endPoint = text.search(newLine)
      array.push text.slice(0, endPoint)
      text = text.slice(endPoint + 1, text.length)

    fieldControl = array[0]
    numFields = 0
    until fieldControl.search(",") is -1
      endPoint = fieldControl.search(",")
      fieldNames.push fieldControl.slice(0, endPoint)
      fieldControl = fieldControl.slice(endPoint + 1, fieldControl.length)
      numFields++
    i = numFields
    j = i+1
    while i > 0
      divID = "visField" + (j - i)
      document.getElementById('visFields').innerHTML = document.getElementById('visFields').innerHTML + "<div id='" + divID +  "' class='visualization sideBySide'></div>"
      i--

    # array = array[1..array.length-1]
    # sends the array from the csv into the getFields()
    i = 0
    while i < array.length
      inputText = array[i]
      j = 0
      fieldArray = []
      while j < numFields
        endPoint = inputText.search(",")
        fieldArray.push inputText.slice(0, endPoint)
        inputText = inputText.slice(endPoint + 1, inputText.length)
        j++
      fieldArray.push inputText
      array[i] = fieldArray
      i++

    getFields array
    return

  # This function takes the array made by doVisualization and creates an Array of arrays where each input of the array is an array of all inputs of one field.
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

    countGrades arrayOfArrays
    return
  # this makes an array of Dictionaries that is handed to createData.
  countGrades = (arrayOfArrays) ->

    #arrayOfDicts will contain a dictionary of occurrences for each field
    arrayOfDict = new Array()
    i = 0
    while i < numFields
      #Add the dictionary to arrayOfDicts
      arrayOfDict.push generateMap(arrayOfArrays[i])
      #Runs createData on each field
      createData i, arrayOfDict
      i++
    return
  # this creates a key value pair system that holds each particular vield value (held as the key) and the number of occurences of the value is stored as the value. it then returns the dictionary
  generateMap = (arrayOfStrings) ->
    map = new Dictionary()
    i = 1

    while i < arrayOfStrings.length
      entry = arrayOfStrings[i]
      map.add entry
      i++
    map

  #createData takes the array of dictionaries from countGrades and the number of fields, and creates a graph containing the values and keys for each feild of the csv
  createData = (fieldNum, arrayOfDict) ->
    tempValue = undefined
    tempKey = undefined
    totalValue = 0
    numOfKeys = 0
    #divID = "visField" + (fieldNum + 1)
    #array of the field entries and the occurrences of them in an object for each index of the array
    dataPointsTemplate = new Array()

    i = 0
    areYouGood = "All of the data you submitted looks good! Click the button below to make your model"
    while i < arrayOfDict[fieldNum].keys.length
      tempValue = arrayOfDict[fieldNum].values[i]
      if tempValue <= 100 and tempValue > 50
        areYouGood = "It looks like one or more of your fields doesn't have enough of one value. For an optimal model you should have 100 of each submission. You may proceed to make a model but it is not advised. "
      if tempValue <= 50
        areYouGood = "It looks like one or more of your fields doesn't have enough of one value. For an optimal model you should have 100 of each submission. Add more values before proceeding to make a model. "
      tempKey = (arrayOfDict[fieldNum].keys[i]).toString()
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