class window.uploadCSVView extends Backbone.View
  tagName: 'div'
  template: _.template $('#uploadCSV').html()

  events:
    'click button.submitCSV1': 'submitCSV'

  numFields = 0
  fieldArray = []
  fieldNames = []
  currentField = 0

  initialize: ->
    @render()

  render: ->
    console.log 'rendering uploadCSVView'
    @$el.html @template()
    this

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

    #Hides #visHeader if nothing has been added
    $("#visHeader1").show()  if documentsAdded > 0

    #uses CSVParser.js to parse the myCSV string into an array
    parser = new CSVParser(csvString)

    #CSVarray is an array of arrays. The arrays inside the main array contain the information from one document and its fields.
    CSVArray = parser.array()
    array = new Array()
    endPoint = 0
    text = csvString
    until text.search("\r") is -1
      endPoint = text.search("\r")
      array.push text.slice(0, endPoint)
      text = text.slice(endPoint + 1, text.length)

    fieldControl = array[0]
    numFields = 0
    until fieldControl.search(",") is -1
      console.log numFields
      endPoint = fieldControl.search(",")
      fieldNames.push fieldControl.slice(0, endPoint)
      fieldControl = fieldControl.slice(endPoint + 1, fieldControl.length)
      numFields++
    i = numFields
    j = i+1
    while i > 0
      divID = "visField" + (j - i)
      document.getElementById('visFields').innerHTML = document.getElementById('visFields').innerHTML + "<div id='" + divID +  "' class='visualization'></div>"
      i--

    ##array = array[1..array.length-1]
    #sends the array from the csv into the getFields().
    console.log "yup"
    console.log fieldNames
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
    divID = "visField" + (fieldNum + 1)
#    document.getElementById('visFields').innerHTML = document.getElementById('visFields').innerHTML + "<div id='" + divID +  "' class='visualization'></div>"
#    console.log document.getElementById('visFields').innerHTML
    #array of the field entries and the occurrences of them in an object for each index of the array
    dataPointsTemplate = new Array()

    i = 0
    console.log arrayOfDict[0]
    while i < arrayOfDict[fieldNum].keys.length
      tempValue = arrayOfDict[fieldNum].values[i]
      if tempValue <= 100 and tempValue > 50
        console.log "warning"
      if tempValue <= 50
        console.log "uh no!"
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


    #chart object
    chart = new CanvasJS.Chart(divID,
      title:
        text: fieldNames[currentField]

      data: dataTemplate
      backgroundColor: "transparent"
    )



    #renders the chart
    console.log "SOMTHIN"
    currentField++
    chart.render()
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