/**
 * Created by fello056 on 4/15/14.
 */
// SUPER IMPORTANT ASSUMPTIONS AND COMPATIBILITY INFO
// READ THE COMMENTS ABOUT THE REGULAR EXPRESSIONS USED
// IN FUNCTIONS processEssay AND getGrades.

//This was meant to be a zip to CSV converter; while the api supports batch upload, our limited time stopped it.
//Ideally we'd use the API, but as a stop-gap, we tried to use the ZipJs library. It was way beyond my understanding,
// so i'll leave this here


function processEssay(aString) {
//returns one complete line for a csv, given an essay.
  var regex = /{#.*}/
  //This regex finds our grade segment - which has the form {#grade1#grade2}.
  //It assumes that it is among the first elements of a Essay.
  //So similar forms *CAN* be in an essay, but ours *HAS* to be first.
  var grades = getGrades(aString.match(regex))
  var csvLine = "";
  for (var i = 0; i <= grades.length; i++){
      csvLine = csvLine + grades[i] + ", ";
  }
    //here we add the essay to the line, removing our grade construct.
  return (csvLine + aString.replace(regex, "") + "\r\n")
}

function getGrades(aString){
    var regex = /#([^#{}\s]*)/gm
    //Matches hash tags, globally, with any non hash character in them.
    //So the hash ## is *NOT* ok, but all other hashes work.
    //Even Unicode characters - #漢字 should work!
    return aString.match(regex);
}

function dezip(zip){
   //get the contents of a zip file
   //return the compressed contents of a zip.
}

function decompress(entries){
    var fileArray = [];
    //decompress here
    return fileArray
}

function getExtension(aString) {
    return aString.match(/\..*/);
}

function readTxt(file) {
    // dummy function ; returns a string
}

function makeCSVFromZip(zip){
    console.log("in MakeCSVFromZip");
    var entries = dezip(zip);
    var fileArray = decompress(entries);
    var csv =""
        //check to see what extension the file is.
    if (".txt" == getExtension(fileArray[0])){
        for (var i = 0; i <= fileArray.length; i++){
            csv = csv + processEssay(readTxt(fileArray[i]));
        }
        return csv;
    }
    return "";
}