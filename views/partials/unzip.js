/**
 * Created by fello056 on 4/15/14.
 */
// SUPER IMPORTANT ASSUMPTIONS AND COMPATIBILITY INFO
// READ THE COMMENTS ABOUT THE REGULAR EXPRESSIONS USED
// IN FUNCTIONS processEssay AND getGrades.



function stripXml(aString) {
    //Xml stripping
    //probably full of bugs
    //"/s/<[^>]\{1,\}>//g; s/[^[:print:]]\{1,\}//g/
  return  aString.replace(foo, "")
}

function processEssay(aString) {
//returns the whole line for csv, given an essay.
  var regex = /{#.*}/
  //This regex finds our grade segment - which has the form {#...}.
  //It assumes that it is among the first elements of a Essay.
  //So similar forms *CAN* be in an essay, but ours *HAS* to be first.
  var grades = getGrades(aString.match(regex))
  var csvLine = "";
   aString.match(regex);
  for (var j = 0; j <= grades.length; j++){
      csvLine = csvLine + grades[j] + ", ";
  }
  return (csvLine + aString.replace(regex, "\r\n"))
}

function getGrades(aString){
    var regex = /#([^#{}]*)/g
    //Matches hash tags, globally, with any non hash character in them.
    //So the hash ## is *NOT* ok, but all other hashes work.
    //Even Unicode characters - #漢字 should work!
    return aString.match(regex)
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
        csv = csv + processEssay(read(docx[5]))//fix the number
    }

}