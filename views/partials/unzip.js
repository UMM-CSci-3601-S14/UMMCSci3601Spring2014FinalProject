/**
 * Created by fello056 on 4/15/14.
 */

// upload -> unzip -> make csv & fix formatting -> to API

//Xml stripping
 //probably full of bugs
 //"/s/<[^>]\{1,\}>//g; s/[^[:print:]]\{1,\}//g/

function stripXml(aString) {
  return  aString.replace(foo, "")
}

function processEssay(aString) {
//returns the whole line for csv, given an essay.
  // fixme; the regex <fix> should match {#foo#bar#baz}
  // as foo bar baz, separately.
  var regex = /{#.*}/
  var csvLine = "";
  var grades = aString.match(regex);
  for (var j = 0; j <= grades.length; j++){
      csvLine = csvLine + grades[j] + ", ";
  }
  return (csvLine + aString.replace(regex, "\r\n"))
}

function unzip(zip) {
    //dummy function ; magic unzip procedure
    //returns an array of files
}

function read(file) {
    // dummy function ; returns a string
}

function makeCSV(zip){
    var fileArray = unzip(zip)
    var csv =""
    //add a check that each file in the array is a .docx
    for (var i = 0; i <= fileArray.length; i++){
        //unzip the .docx
        var docx = unzip(fileArray[i])
        processEssay(read(docx[5]))//fix the number
    }

}