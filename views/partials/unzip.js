/**
 * Created by fello056 on 4/15/14.
 */
// SUPER IMPORTANT ASSUMPTIONS AND COMPATIBILITY INFO
// READ THE COMMENTS ABOUT THE REGULAR EXPRESSIONS USED
// IN FUNCTIONS processEssay AND getGrades.

var zip = require('zipJs');

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
  return (csvLine + aString.replace(regex, "") + "\r\n")
}

function getGrades(aString){
    var regex = /#([^#{}]*)/g
    //Matches hash tags, globally, with any non hash character in them.
    //So the hash ## is *NOT* ok, but all other hashes work.
    //Even Unicode characters - #漢字 should work!
    return aString.match(regex);
}



function unzip(aBlob) {

}

function decompress(fullsavepath, filename){
    zip.useWebWorkers = false;

    var fileInput = document.getElementById("fileInput")
    var file = fileInput.files[0]
//   file_system.root.getFile("app_cache/temp.zip", {}, function(fileEntry){
//        fileEntry.file(function (file) {

            zip.createReader(new zip.BlobReader(file), function(reader) {

                // get all entries from the zip
                reader.getEntries(function(entries) {
                    if (entries.length) {
                        //Output zip file contents
                        for(var i=0; i<entries.length;i++){
                            console.log(entries[i].filename);
                        }

                        //Try to decompress all the files
                        var fileArray = []
                        for (var j=0;j<entries.length;j++){
                        console.log('attempting to get ' + entries[j].filename);
                            //the blobwriter might not be the right choice.
                        entries[j].getData(new zip.BlobWriter(), function(unzipData){
                            console.log(j.toString() + "'s data: " + unzipData);
                            fileArray.push(unzipData);
                        },null, null);
                        return fileArray}
                    }
                });
            }, null);


}

function stripXml(aString) {
    //Xml stripping
    //full of bugs
    //"/s/<[^>]\{1,\}>//g; s/[^[:print:]]\{1,\}//g/
    return  aString.replace(/foo/, "")
}

function readDocx(file) {
    // dummy function ; returns a string
}

function readTxt(file) {
    // dummy function ; returns a string
}

function makeCSV(zipFile){
    var fileArray = unzip(zipFile)
    var csv =""
    if ("docx" == typeof(fileArray[0])){
        //docx not supported yet.
//        for (var i = 0; i <= fileArray.length; i++){
//            //unzip the .docx
//            var docx = unzip(fileArray[i])
//            csv = csv + processEssay(readDocx(docx[5]))//fix the number
//        }
        return csv;
    }
    if ("txt" == typeof(fileArray[0])){
        for (var i = 0; i <= fileArray.length; i++){
            csv = csv + processEssay(readTxt(docx[i]))
        }
        return csv;
    }


}