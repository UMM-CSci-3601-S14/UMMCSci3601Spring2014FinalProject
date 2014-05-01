//This function will call every visualization function in a chain.
function doVisualization(){
    //Hides #visHeader if nothing has been added
    if (documentsAdded > 0) {
        $('#visHeader').show();
    }
    //uses CSVParser.js to parse the myCSV string into an array
    var parser = new  CSVParser(myCSV);
    //CSVarray is an array of arrays. The arrays inside the main array contain the information from one document and its fields.
    var CSVArray = parser.array();
    //sends the array from the csv into the getFields().
    getFields(CSVArray);
}

function getFields (CSVArray) {
    var arrayOfArrays = new Array();
    for (var i = 0; i < numFields; i++) {
        arrayOfArrays[i] = new Array();
        for (var j = 0; j < CSVArray.length; j++) {
            arrayOfArrays[i][j] = CSVArray[j][i];
        }
    }
    //sets arrayOfArrays to be an array of each field (including the field name at the first index of each sub-array!).
    countGrades(arrayOfArrays);
}

function countGrades (arrayOfArrays){
    //arrayOfDicts will contain a dictionary of occurrences for each field
    var arrayOfDict = new Array();
    for (var i = 0; i < numFields; i++){
        //Add the dictionary to arrayOfDicts
        arrayOfDict.push(generateMap(arrayOfArrays[i]));
        //Runs createData on each field
        createData(i, arrayOfDict);
    }
}

function generateMap (arrayOfStrings) {
    //Makes a countingMap of key value pairs based on occurrences within the given array. Returns the countingMap.
    var map = new countingMap();
    for (var i = 0; i < arrayOfStrings.length; i++) {
        var entry = arrayOfStrings[i];
        map.add(entry)
    }
    return map
}

//fieldNum is the index that a field is on
function createData(fieldNum, arrayOfDict){
    var tempValue;
    var tempKey;
    var divID = "visField" + (fieldNum + 1);
    var title = fieldNames[fieldNum];
    //array of the field entries and the occurrences of them in an object for each index of the array
    var dataPointsTemplate = new Array();
    for(var i = 0; i < arrayOfDict[fieldNum].keys.length; i++) {
        tempValue = arrayOfDict[fieldNum].values[i];
        tempKey = (arrayOfDict[fieldNum].keys[i]).toString();
        dataPointsTemplate.push({y: tempValue, indexLabel: tempKey});
    }
    var dataTemplate = [
        {
            type:"doughnut",
            dataPoints:dataPointsTemplate
        }
    ];

    //chart object
    var chart = new CanvasJS.Chart(divID,
        {
            title:{
            text: title
        },
    data:dataTemplate,
    backgroundColor: "inherit"
    });
    //renders the chart
    chart.render();
}

//countingMap class and methods. Custom data structure!! :D
function countingMap(){
    this.keys = [];
    this.values = [];

    //This object has a key-value pair interface;
    //The value is the number of times the key has been added. (clarification: it starts at one)

    this.add = function(entry) {
        var index = this.keys.indexOf(entry);
        if (-1 == index){
            this.keys.push(entry);
            this.values.push(1);
            this.length = (this.length + 1);
        } else {
            this.values[index] = (this.values[index] + 1);
        }
    };

    this.getValue = function(key) {
        var index = this.keys.indexOf(key);
        return this.values[index];
    };
}

module.exports.countingMap = countingMap;
module.exports.generateMap = generateMap;