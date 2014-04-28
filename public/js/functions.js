var myCSV = "";
var documentsAdded = 0;
var numFields;
var fieldNames = [];
var selected = 0;
var promptTitle = "";
var promptDescript = "";
var cDescript = "";

/***************ADD/SAVE FIELDS*****************/
//Sets the number of text fields for number of scorers. Runs when dropdown is selected.
function addFields(numToAdd) {
    numFields = numToAdd;
    var template1 = '<div class="fields">\n</div><input class="field form-control" id="field';
    var template2 = '" placeholder="Enter Field Name (Ex: Grade)">\n</div>\n';
    var temp = "<label>Fields</label>";
    //For making the first field called "label"
    temp += '<div class="fields">\n</div><input class="field form-control" id="field1" placeholder="label (the first field must be called label)" disabled>\n</div>\n';
    //Set i to equal 1 if the first field does not need to be "label". Also delete the line above and the jQuery call in saveFields()
    for (var i = 2; i < numToAdd + 1; i++) {
        temp += template1 + i + template2;
    }
    document.getElementById("moreFields").innerHTML=temp;
    $("#saveFields").show();
}

//Runs when you hit save. Inserts the name of the fields into the fields.
function saveFieldNames() {
    var tempbool = true;
    //For making the first field called "label"
    $("#field1").val("label");
    for (var i = 1; i <= numFields; i++) {
        if ($("#field" + i + "").val()== "") {
            tempbool = false;
        }
    }
    if (tempbool == true) {
        for (var i = 1; i <= numFields; i++) {
            fieldNames.push($("#field" + i + "").val());
            myCSV += $("#field" + i + "").val() + ",";
        }
        var template1 = '<div class="input-group fields">\n<span class="input-group-addon">';
        var template2 = '</span>\n<input type="text" class="form-control" id="toScore';
        var template3 = '"placeholder="Enter grade for ';
        var template4 = '">\n</div>\n';
        var temp = "<label>Scores</label>";
        for (var i = 1; i < numFields+ 1; i++) {
            temp += template1 + fieldNames[i-1] + template2 + i + template3 + fieldNames[i-1] + template4;
        }
        document.getElementById("fieldScores").innerHTML=temp;
        myCSV += "text\r\n"
        $("#fieldNames").hide();
        $("#workZone").show();
    } else {
        window.alert("Please fill all field names");
    }
}
/*************Save prompt for when we hit the blue button on modelPage or after edit**********************/
function fieldsFilled(){
    if ($("#promptTitle").val() === "") {
        window.alert("Please enter the prompt title");
        return false;
    } else if ($("#promptDescription").val() === "") {
        window.alert("Please enter the prompt description");
        return false;
    } else if ($("#cDescription").val() === "") {
        window.alert("Please enter the class description");
        return false;
    } else {
        return true
    }
}

function fieldCollapse() {
    promptTitle = $("#promptTitle").val();
    promptDescript = $("#promptDescription").val();
    cDescript = $("#cDescription").val();
    $('#promptSpaceSmall').html("<strong>Prompt Title: </strong>" + promptTitle + "<br /><strong>Prompt Description: </strong>" + promptDescript + "<br /><strong>Class Description: </strong>" + cDescript).show();
    $('#promptSpace').hide();
    $('#editPrompt').show();
}
/******************************************************/

/**************************DOWNLOADING***********************************/
//If no documents have been added, prompts user to add documents. Else it asks for confirmation of download, then runs the download method.
function exportToCSV() {
    if (documentsAdded == 0){
        window.alert("Please add some documents");
    } else if (confirm("Do you want to download the CSV?")) {
        download(promptTitle, myCSV);
    }
}

//Uses "filesaver.js" and "blob.js" to export string and download.
function download(fileName, text) {
    var blob = new Blob([myCSV], {type: "text/csv;charset=utf-8"});
    saveAs(blob, fileName + ".csv");
}
/**********************************************************************/


/**********************ADDING********************************/
function add() {
    /***************************/
    if (emptyFields() == true) {                             //If any of the fields/text areas are empty, will alert the user.
        window.alert("Please fill all fields for the text");
    } else {                                                 //If all fields are populated will add the entry.
        for (var i = 1; i <= numFields; i++) {
            myCSV += $("#toScore" + i + "").val() + ",";
        }
        myCSV += "\"" + $("#text").val().replace(/"/g,"'") + "\"\r\n"; //Adds the string in the text area to myCSV string, replacing double quotes with single quotes.
        documentsAdded++;
        clearAllFields();
        document.getElementById("documentAmount").innerHTML = documentsAdded;
        doVisualization();

        /***************************/
        document.getElementById("pastDocs").innerHTML += "<div class='docBox' id ='docBox" + documentsAdded + "'>" + documentsAdded + "</div>"; //Adds boxes of past entries.

        $(".docBox").slideDown(130);
        $(".docBox").mouseover(function() { //Hover effect.
            if (parseInt($(this).text()) != selected) {
                docBoxColors(this, '#506696', 'white', '#5E79B2');
            }
        });

        $(".docBox").mouseout(function() { //Returns to normal color.
            if (parseInt($(this).text()) != selected) {
                docBoxColors(this, '#BAD0FF', 'black', '#5E79B2');
            }
        });

        $(".docBox").click(function() { //Edits CSV document by clicking the specified docBox
            addingButtons();
            $("#docTut").hide();
            selected = (parseInt($(this).text()));
            deselect();
            docBoxColors(this, '#EBADFF', 'black', '#BA80CC');
            var counter = 1;
            for(var i = 0; i < myCSV.length; i++) {
                if (myCSV.charAt(i) == "\n") {
                    if (counter < (parseInt($(this).text()))) counter++;
                    else {
                        var index = i;
                        for (var j = 1; j <= numFields; j++) {
                            $("#toScore" + j + "").val(myCSV.substring(index, myCSV.indexOf(',', index + 1)));
                            index = myCSV.indexOf(',', index + 1) + 1;
                        }
                        /*Note that '"' is a double quotation in two single quotes, rather than the empty string*/
                        var text = myCSV.substring(myCSV.indexOf('"', i) + 1, myCSV.indexOf("\n", i + 1) - 2);
                        $("#text").val(text);
                        return;
                    }
                }
            }
        });
    }
}

//Returns true or false. False if all fields and text area have contents.
function emptyFields() {
    for (var i = 1; i <= numFields; i++) {
        if ($("#toScore" + i + "").val() == "") {
            return true;
        }
    }
    return $("#text").val() == "";
}

//Hides cancel, the edit tutorial, and replace, shows submit, the text tutorial, and add
function editButtons() {
    $("#cancel").hide();
    $("#replace").hide();
    $("#delete").hide();
    $("#submit").show();
    $("#add").show();
    $("#textTut").show();
    $("#editDocs").hide();
}
/****************************************************************************************/

//Changes the color of the docBox.
function docBoxColors(element, bgColor, color, bdColor) {
    $(element).css("background-color", bgColor);
    $(element).css("color", color);
    $(element).css("border-color",bdColor);
}

/******************************REPLACING/EDITING ESSAYS******************************************/
//Performs the replacing in myCSV. UGLY! But it works.
function replace() {
    editButtons();
    var counter = 1;
    for(var i = 0; i < myCSV.length; i++) {
        if (myCSV.charAt(i) == "\n") {
            if (counter < (selected)) counter++;
            else {
                var toReplace = "";
                for (var j = 1; j <= numFields; j++) {
                    toReplace += $("#toScore" + j + "").val() + ",";
                }
                toReplace += "\"" + $("#text").val().replace(/"/g,"'") + "\"\r\n";
                myCSV = replaceAt(myCSV, myCSV.indexOf('\n', i - 1) + 1, myCSV.indexOf("\n", i + 1), toReplace); //Finds the ith instance of a line break, then replaces starting at            that line.

                selected = 0;
                clearAllFields();
                deselect();
                doVisualization();
                return;
            }
        }
    }
}

//  Much of this function was found here:
//  http://stackoverflow.com/questions/1431094/how-do-i-replace-a-character-at-a-particular-index-in-javascript
//Used in the replace function, takes in two indices of a string and replaces that range of the string with other given text
function replaceAt(str, start, end, text) {
    return str.substring(0, start) + text + str.substring(end + 1);
}

//Deselects all docBoxes
function deselect() {
    var boxes = document.getElementById('pastDocs').getElementsByTagName('*');
    for (var j = 0; j < boxes.length; j++) {
        var e = boxes[j];

        e.style.backgroundColor = '#BAD0FF';
        e.style.color = 'black';
        e.style.borderColor = '#5E79B2';
    }
}

//Clears all text in text boxes in all field EXCEPT title
function clearAllFields() {
    for (var k = 1; k <= numFields; k++) {
        $("#toScore" + k + "").val("");
    }
    $("#text").val("");
}

//Runs cancel.
function cancelReplace() {
    deselect();
    editButtons();
    clearAllFields();
}

//Hides submit, the text tutorial, and add, shows cancel, edit tutorial, and replace.
function addingButtons() {
    $("#add").hide();
    $("#submit").hide();
    $("#replace").show();
    $("#delete").show();
    $("#cancel").show();
    $("#textTut").hide();
    $("#editDocs").show();
}
/*******************************************************************************/


//Deletes an essay document
function del() {
    editButtons();
    var newCSV = myCSV;
    var selectedSection = selected;
    var toDelete = 0;
    var i = 0;
    var nextLine = 0;
    console.log(selectedSection);
    while(i < selectedSection) {
        nextLine = newCSV.search("\n");
        toDelete += newCSV.search("\n");
        newCSV = newCSV.slice(nextLine + 1,newCSV.length);
        i++;
    }
    myCSV = myCSV.slice(0, toDelete) + myCSV.slice(toDelete + newCSV.search("\n") + 1);
    console.log(myCSV);
    $('#docBox' + documentsAdded).remove();
    documentsAdded--;
    document.getElementById("documentAmount").innerHTML = documentsAdded;
    selected = 0;
    clearAllFields();
    deselect();
    doVisualization();
    return;
}

