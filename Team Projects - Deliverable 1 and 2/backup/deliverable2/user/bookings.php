<html>
<?php include 'php/usercheck.php'; ?>
<head>
<title>Loughborough University Room Booking System</title>
<link href="../style.css" rel="stylesheet" type="text/css" />
<script src='jquery.js' type='text/javascript'></script>
<script type='text/javascript'>
var depts = [];
var modules = [];
var parts = [];
var partsunique = [];
var modCode = [];
var newoldbool = false;

function addDepts(){
	<?php
		$myconn2=mysql_connect("co-project.lboro.ac.uk",team13,b7c8pbvc);
		mysql_select_db("team13",$myconn2);
		$strSQL="SELECT * FROM Department ORDER BY DepartmentName";
		$result2=mysql_query($strSQL, $myconn2);
		$count = 0;
		while($row=mysql_fetch_array($result2)){
			if($count==0) $firstDept = $row["DepartmentName"];
			echo 'var record={} ; ';
			echo 'record.id="'.$row["DepartmentID"].'" ; ';
			echo 'record.name="'.$row["DepartmentName"].'" ; ';
			echo 'depts['.$count.']=record ; ';
			$count++;
		}
		
		$strSQL="SELECT DISTINCT Part FROM Module ORDER BY Part";
   		$result2=mysql_query($strSQL, $myconn2);
		$count = 0;
		while($row=mysql_fetch_array($result2)){
			echo 'parts['.$count.']="'.$row["Part"].'";';
			$count++;
		}
	?>
}
	
function updateDept(){
	var selectstr = '<strong>Module Department:</strong> <select name="moduledept" id="moduledept" onChange="modulesearch();">';
	for(i=0;i<depts.length;i++) selectstr += '<option>'+depts[i].name+'</option>';
	selectstr += '</select>';
	document.getElementById("deptSelect").innerHTML = selectstr;
}

function updateChoicenewold(){
	var strnewold = "<strong>Enter:</strong> Existing Module<input type='radio' value='0' id='newoldrad' name='newoldrad' onChange='changenewold()' checked /> New Module<input type='radio' value='1' id='newoldrad' name='newoldrad' onChange='changenewold()' />";
	document.getElementById("choicenewold").innerHTML = strnewold;
	
	var string1 = '<strong>Module Code: </strong><input type="text" id="newmodCode1" name="newmodCode1" size="3" maxlength="3" disabled /><input type="text" id="newmodCode2" name="newmodCode2" size="3" maxlength="3" /><strong>Module Name:</strong><input type="text" name="newmodName" size="20" maxlength="50" />';
}

function changenewold(){
		newoldbool = !(newoldbool);
		updatePart();
		updateNameCode(document.getElementById("modulepart").value);
}

function modulesearch(){
	$(document).ready(function(){$("#update").load("modsearch.php", {searchdept: (document.getElementById("moduledept").value)})});
}

function passback(x,y){
	modules = x;
	partsunique = y;
	updatePart();
	updateNameCode(document.getElementById("modulepart").value);
}

function updatePart(){
	var p =[];
	var selectstr = '<strong>Module Part: </strong><select name="modulepart" id="modulepart" onChange="updateNameCode(this.value);">';
	if(!newoldbool){
		selectstr += '<option selected="selected">No Preference</option>';
		p = partsunique;
	}
	else p = parts;

	for(i=0;i<p.length;i++){
		selectstr += '<option>'+p[i]+'</option>';
	}
	selectstr += '</select>';

	document.getElementById("partSelect").innerHTML = selectstr;
}

function updateNameCode(selected_part){
	if(!newoldbool){
		modCode = [];
		
		var selectstr = '<strong>Module Name</strong><br><select size="10" onChange="selectCode(this.value);" style="width:330px;" name="modulename" id="modulename"';
		var selectstr2 = '<strong>Module Code</strong><br><select size="10" onChange="selectName(this.value);" style="width:75px;" name="modulecode" id="modulecode"';
		j = 0;
		for(i=0;i<modules.length;i++){
			if(selected_part == "No Preference" || modules[i].part == selected_part){
				selectstr += '<option>'+modules[i].name+'</option>';
				modCode[j] = modules[i].id;
				j++;
			}
		}
		
		modCode.sort();
		for(i=0;i<modCode.length;i++){
			selectstr2 += '<option>'+modCode[i]+'</option>';
		}

		selectstr += '</select>';
		selectstr2 += '</select>';
		document.getElementById("nameSelect").innerHTML = selectstr;
		document.getElementById("codeSelect").innerHTML = selectstr2;
	}
	else{
		document.getElementById("codeSelect").innerHTML = '<strong>Module Code: </strong><input type="text" id="newmodCode1" name="newmodCode1" size="3" maxlength="3" disabled /><input type="text" id="newmodCode2" name="newmodCode2" size="3" maxlength="3" /><br><br> <strong>Module Name: </strong><input type="text" id="newmodName" name="newmodName" size="20" maxlength="50" />';
		document.getElementById("nameSelect").innerHTML = '';
		for(i=0;i<depts.length;i++){
			if(depts[i].name == document.getElementById("moduledept").value){
				document.getElementById("newmodCode1").value = depts[i].id+selected_part;
			}
		}
	}
}

function selectName(selectedCode){
	var j = 0;
	for(i=0;i<modules.length;i++){
		if(modules[i].id == selectedCode){
			document.getElementById("modulename").selectedIndex = j;
		}
		if((document.getElementById("modulepart").value == "No Preference") || (modules[i].part == document.getElementById("modulepart").value)) j++;
	}
}

function selectCode(selectedName){
	nameIndex = 0;
	for(i=0;i<modules.length;i++){
		if(modules[i].name == selectedName && document.getElementById("modulename").selectedIndex == nameIndex){
			for(j=0;j<modCode.length;j++){
				if(modCode[j] == modules[i].id){
					document.getElementById("modulecode").selectedIndex = j;
				}
			}
		}
		if((document.getElementById("modulepart").value == "No Preference") || (modules[i].part == document.getElementById("modulepart").value)){
			nameIndex++;
		}
	}
}


/////////////////////////////////////////////////////////////ROOM SELECTION /////////////////////////////////////////////////////////////////////////////////////////////////////


/////////////////////////////////////////////////////////////ROOM SELECTION /////////////////////////////////////////////////////////////////////////////////////////////////////

var parks = [];
var buildrecord = [];
var facility = [];
var buildnameslist = [];
var buildcodeslist = [];
var roomrecord=[];
var noFacilites = '';
selchosen = 'facility'
roomamnt = ''

buildingcode = '<?php echo $_REQUEST['buildcodeH']; ?>'
buildingname = '<?php echo $_REQUEST['buildnameH']; ?>'
roomname = '<?php echo $_REQUEST['roomH']; ?>'




function makefacilityarray(){
<?php include 'php/facilitySQL.php';?>}

function makeparkrecords(){
<?php include 'php/parkSQL.php';?>}

function makebuildingrecords(){
<?php include 'php/buildSQL.php';?>}

function loadselector(){
	list = '<strong>Number of Rooms:</strong> <select id = "amntrooms" size = "1" onChange="roomselector()">'	
	for(x=1;x<=4;x++){	
		list += '<option value="'+x+'">'+x+'</option>'}
	list += '</select>'
	if(buildingname != ''){a='checked'; b='';selchosen='room'}else{a='';b='checked'}
	list += '<br><br><strong>Choose Room(s) By:</strong> Facilities:<input type="radio" onchange="javascipt:selchosen = this.value;roomselector()"  name="selchoice" id="selchoice"  value="facility" '+b+'>Preferred Room:</input><input type="radio" onchange="javascipt:selchosen = this.value;roomselector()" name="selchoice" id="selchoice" value="room" '+a+'/>'
	list +='<br><br><strong>Filter By Number of Students:<input type="checkbox" id="studentfilter"/>'
	document.getElementById("rmchoicetitle").innerHTML = list;
	roomselector()}

function roomselector(){
	roomamnt = document.getElementById('amntrooms').value
	innerhtml = ''
	if(selchosen== 'room'){
		innerhtml += ''
		for(x=1;x<=roomamnt;x++){
			innerhtml += 	'<div style = "float: left;  margin-left:10px; margin-right: 5px" id="parks'+x+'"></div><div style = "float: left;" id="buildcodes'+x+'"></div>'
			innerhtml += 	'<div style = "float: left;  margin-right: 5px" id="buildnames'+x+'"></div><div style = "float: left;  margin-right: 10px"  id="rooms'+x+'"></div><br><br><br><br><br><br><br><br><br><br><br><br>'}
		document.getElementById("roomsentry").innerHTML = innerhtml;
		document.getElementById("rmfacilities").style.width = '460px'
		document.getElementById("rmfacilities").style.height = (170*roomamnt)+'px';
		makeparkrecords();
		makebuildingrecords();
		makeparklist(roomamnt);}
	if(selchosen== 'facility'){
		innerhtml += '<div id="rmchoice" style="float:left; border-right: solid 1px; height:270px"></div><div style="margin-top:10px;"><b>&nbsp;&nbsp;Suggested<br>&nbsp;&nbsp;Rooms:</b></div>'
		for(x=1;x<=roomamnt;x++){
			innerhtml += 	'<div style = "float: left; margin-left: 3px; margin-top:40px;"  id="rooms'+x+'"></div>'}
		document.getElementById("roomsentry").innerHTML = innerhtml;
		document.getElementById("rmfacilities").style.height = '285px';
		document.getElementById("rmfacilities").style.width = 610+(90*roomamnt)+'px';
		makefacilityarray();
		makeroomfilter();
		updatesuggestions();}}

function makeroomfilter(){
	factable = '<table id ="facilitytable"><tr><th>Room Type: </th><td colspan="3"><select id="type" name="type" size="1" onchange="updatesuggestions()"><option value="facility0">'+facility[0]+'</option><option value="facility1">'+facility[1]+'</option><option value="facility2">'+facility[2]+'</option></select></td></tr>'	
	factable += '<tr><th>Room Style: </th><td colspan="3"><select id="style" name="style" size="1" onchange="updatesuggestions()"><option value="facility3">'+facility[3]+'</option><option value="facility4">'+facility[4]+'</option></select></td></tr>'	
	for(x=5;x<facility.length;x++){
		if(x==5){factable += '<tr><th>Room Facilities: </th>'}
		if(x<=7){factable += '<td><input type="checkbox" onclick="updatesuggestions()"  name="facility'+x+'" value="'+x+'" id="facility'+x+'">'+facility[x]+'</input><br></td>'}
		if(x==7){factable += '</tr><tr><td> </td>'}
		if(x>7){factable += '<td><input type="checkbox" onclick="updatesuggestions()"  name="facility'+x+'" value="'+x+'" id="facility'+x+'">'+facility[x]+'</input><br></td>'}
		if(x>7 && (Math.round((x-1)/3) == ((x-1)/3))){factable += '</tr><tr><td> </td>'}}
	factable += '</tr></table>'
	noFacilities = x
	document.getElementById("rmchoice").innerHTML = factable;
	}

function makeparklist(roomamnt){
	for(x=1;x<=roomamnt;x++){
		var selectpark = '<select size = "10" name="parkselect'+x+'" id="parkselect'+x+'" onchange = "makebuildlist(this.value,'+x+');" style="width: 50px" >'	
		selectpark += '<option value="All" selected>All</option>'	
		for(i=0;i<parks.length;i++){
			selectpark += '<option value="'+parks[i]+'">'+parks[i]+'</option>'}	
		selectpark += '</select>'
	document.getElementById("parks"+x).innerHTML=selectpark
	makebuildlist('All',x)}}

function makebuildlist(chosen,x){
	var select1 = '<select size = "10" name="buildidselect'+x+'" id="buildidselect'+x+'" onchange="changebuildname(this.value,'+x+');" style="width: 70px" >'
	var select2 = '<select size = "10" name="buildnameselect'+x+'" id="buildnameselect'+x+'" onchange="changebuildid(this.value,'+x+');" style="width: 225px" >'
	var buildcodeslist1 = []
	var buildnameslist1= []
	if(chosen=='All'){
		for(i=0;i<buildrecord.length;i++){
			buildnameslist1[i] = buildrecord[i].name
			buildcodeslist1[i] = buildrecord[i].buildingid}}
	else{
		var z = 0
		for(i=0;i<buildrecord.length;i++){
			if(buildrecord[i].park == chosen){
				buildnameslist1[z] = buildrecord[i].name
				buildcodeslist1[z] = buildrecord[i].buildingid
				z++}}}
	buildnameslist[x] = buildnameslist1
	buildcodeslist[x] = buildcodeslist1
	buildnameslist[x].sort()
	for(y=0;y<buildnameslist[x].length;y++){
		if(buildcodeslist[x][y]==buildingcode){c='selected'}else{c=''}
		if(buildnameslist[x][y]==buildingname){d='selected'}else{d=''}
		select1 += '<option value ="'+buildcodeslist[x][y]+'"'+c+'>'+buildcodeslist[x][y]+'</option>'
		select2 += '<option value ="'+buildnameslist[x][y]+'"'+d+'>'+buildnameslist[x][y]+'</option>'}
	select1 += '</select>'
	select2 += '</select>'
	document.getElementById("buildcodes"+x).innerHTML=select1
	document.getElementById("buildnames"+x).innerHTML=select2
	var roomselector = '<select size = "10" style="width: 85px" >'	
	roomselector += '</select>'	
	document.getElementById("rooms"+x).innerHTML=roomselector
	if(buildingname != ''){updaterooms(1)}	
	}

function changebuildid(chsnbuild,y){
	for(x=0;x<buildrecord.length;x++){
		if(buildrecord[x].name == chsnbuild){buildno = x; var newbuildcode = buildrecord[x].buildingid}}
	for(x=0;x<buildcodeslist[y].length;x++){
		if(buildcodeslist[y][x]==newbuildcode){document.getElementById('buildidselect'+y).selectedIndex = x}}
	updaterooms(y)}

function changebuildname(chsnbuild,z){
	var buildname = ''
	for(x=0;x<buildrecord.length;x++){
		if(buildrecord[x].buildingid == chsnbuild)
			{buildno = x; buildname = buildrecord[x].name}}
	for(y=0;y<buildnameslist[z].length;y++){
		if(buildnameslist[z][y] == buildname)
			{document.getElementById("buildnameselect"+z).selectedIndex = y}}
	updaterooms(z)}

function makeroomlist(x,y){
	roomrecord = x
	selectroom = '<select size = "10" style="width: 85px" >'
	for (i=0;i<roomrecord.length;i++){
		if(roomrecord[i].roomid==roomname){z='selected'}else{z=''}
		selectroom += '<option value="'+roomrecord[i].roomid+'"'+z+'>'+roomrecord[i].roomid+'</option>'}
	selectroom += '</select>'
	document.getElementById("rooms"+y).innerHTML = selectroom;}

function makeroomsuggestion(x){
	roomrecord = x
	for(z=1;z<=roomamnt;z++){
		selectroom = '<select size = "10" style="width: 85px" id="roomsuggest'+z+'">'
	selectroom += '<option value="Any" selected>Any</option>'
	for (i=0;i<roomrecord.length;i++){
		selectroom += '<option value="'+roomrecord[i].roomid+'">'+roomrecord[i].roomid+'</option>'}
	selectroom += '</select>'
	
	
	document.getElementById("rooms"+z).innerHTML = selectroom;}}

function updaterooms(x){
	$(document).ready(function(){$("#update").load("php/bookingroomslist.php", {var1: (document.getElementById("buildidselect"+x).value), var2:(document.getElementById("buildnameselect"+x).value), var3: x })});}


function updatesuggestions(){
	total = document.getElementById('type').selectedIndex+document.getElementById('style').selectedIndex+3
	var writeSQL = 'SELECT * FROM Room WHERE RoomID IN(SELECT RoomID FROM RoomFacility WHERE '
	writeSQL += ' FacilityID = "'+document.getElementById('type').selectedIndex+'" '
	writeSQL += ' OR FacilityID = "'+(document.getElementById('style').selectedIndex+3)+'" '
	for(x=5;x<noFacilities;x++){
		if(document.getElementById('facility'+x).checked==true){
			writeSQL += ' OR FacilityID = "'+x+'" '
			total = parseInt(total)+x}}
	writeSQL += ' GROUP BY RoomID HAVING SUM(FacilityID)='+total+')'
	$(document).ready(function(){$("#update").load("php/bookingroomfilter.php", {sql: writeSQL})});}


//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

var weeks = 15;
var dayarray = ["Mon","Tue","Wed","Thu","Fri"];
var periods = 9;
var times = ["9am-<br>10am","10am-<br>11am","11am-<br>12pm","12pm-<br>1pm","1pm-<br>2pm","2pm-<br>3pm","3pm-<br>4pm","4pm-<br>5pm","5pm-<br>6pm"];

function select1(chosen){if(document.getElementById(chosen).value=="1"){document.getElementById(chosen).style.backgroundColor="#F5FFFA";document.getElementById(chosen).value="0"}
				else{document.getElementById(chosen).style.backgroundColor="#488AC7";document.getElementById(chosen).value="1"}}

function maketimes(){
	var strtt = '<table id="times"><tr><th>Period:</th>';
	for(i=1;i<=periods;i++) strtt += '<th>'+i+'</th>';
	strtt += '</tr><tr><th>Times:</th>'
	for(i=0;i<times.length;i++) strtt += '<th>'+times[i]+'</th>';

	for(j=0;j<dayarray.length;j++){
		strtt += '</tr>';
		strtt += '<tr><th>'+dayarray[j]+'</th>';
		for(i=1;i<=periods;i++) strtt += '<td value="0" id="'+dayarray[j]+i+'" onclick="select1(this.id)"></td>';
	}

	strtt += '</tr></table>';

	strtt += '<br><br><strong>Weeks in Semester:</strong><input value="0" name="sem1" type="radio" onChange="activeSem1(this.value);" checked />All <input value="1" name="sem1" type="radio" onChange="activeSem1(this.value)" />Let me choose<br></br>';
	for(i=1;i<=weeks;i++) strtt += '<input name="s1w'+i+'" id="s1w'+i+'" type="checkbox" checked disabled>'+i;

	document.getElementById("times").innerHTML = strtt;
}

function activeSem1(inval){
	for(i=1;i<=weeks;i++) document.getElementById("s1w"+i).disabled = !(document.getElementById("s1w"+i).disabled);
	if(inval == '0'){
		for(i=1;i<=weeks;i++) document.getElementById("s1w"+i).checked = true;
	}
}

////////////////////////////////////////////////////VALIDATION////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

function validateRequest(){
	var ok = true;
	if(newoldbool){
		if(document.getElementById("newmodCode2").value.length < 3){
			alert('The new Module Code must be 6 characters.');
			ok = false;
		}
		else{
			for (i = 0 ; ok && (i < 3) ; i++) {
				if ((document.getElementById("newmodCode2").value.charAt(i) < '0') || (document.getElementById("newmodCode2").value.charAt(i) > '9')){
					alert('The new Module Code must have digits only as the last three characters.');
					ok = false;
				}
			}
			if(ok){
				for(i=0;ok && (i<modules.length);i++){
					if(modules[i].id == (document.getElementById("newmodCode1").value + document.getElementById("newmodCode2").value)){
						alert('The new Module Code already exists.');
						ok = false;
					}
				}
			}
			if(document.getElementById("newmodName").value.length < 1){
				alert("You must enter a new Module Name.");
				ok = false;
			}
			
			for(i=0;ok && (i<document.getElementById("newmodName").value.length);i++){
				if(document.getElementById("newmodName").value.charAt(i) == "'"){
					alert("The new Module Name cannot contain an apostrophe.");
					ok = false;
				}
			}
		}
	}
	else{
		if(!(document.getElementById("modulecode").selectedIndex >= 0 && document.getElementById("modulecode").selectedIndex < modules.length)){
			alert("You have not chosen a Module.");
			ok = false;
		}
	}
	
	var found = false;
	for(i=0;i<dayarray.length;i++){
		for(j=1;j<=periods;j++){
			if(document.getElementById(dayarray[i]+j).value=='1') found = true;
		}
	}
	if(!found){
		alert("You must select at least one period.");
		ok = false;
	}
	
	found = false;
	for(i=1;i<=weeks;i++){
		if(document.getElementById("s1w"+i).checked) found = true;
	}
	if(!found){
		alert("You must select at least one week.");
		ok = false;
	}
	
	if(document.getElementById("numOfStudents").value.length < 1){
		alert("You have not entered the number of students.");
		ok = false;
	}
	for (i = 0 ; ok && (i < document.getElementById("numOfStudents").value.length) ; i++) {
		if ((document.getElementById("numOfStudents").value.charAt(i) < '0') || (document.getElementById("numOfStudents").value.charAt(i) > '9')){
			alert("You have not entered a valid number of students.");
			ok = false;
		}
	}
	if(ok && (document.getElementById("numOfStudents").value < 1)){
		alert("You must have at least one student.");
		ok = false;
	}
	
	if(ok) submitRequest();
}

////////////////////////////////////////////////////////SUBMIT REQUEST/////////////////////////////////////////////////////////////////////////////////////////////////////////////

function submitRequest(){
	$(document).ready(function(){$("#update2").load("getrequestid.php")});
}

function passlastReqID(lastReqID){
	lastReqID ++;
	var str = '';
	var strArray = [];
	var strArrayCount = 0;
	
	if(newoldbool){
		var modID = document.getElementById("newmodCode1").value + document.getElementById("newmodCode2").value;
		
		for(i=0;i<depts.length;i++){
			if(document.getElementById("moduledept").value == depts[i].name){
				var deptID = depts[i].id;
			}
		}
		var modName = document.getElementById("newmodName").value;
		var partName = document.getElementById("modulepart").value;
		strSQL = "INSERT INTO Module (Name,ModuleID,DepartmentID,Part) VALUES ('"+modName+"','"+modID+"','"+deptID+"','"+partName+"')";
		strArray[strArrayCount] = strSQL;
		strArrayCount ++;
	}
	else var modID = document.getElementById("modulecode").value;
	
	var noStu = document.getElementById('numOfStudents').value;
	strSQL = "INSERT INTO Request (RequestID,UserID,ModuleID,NoStudents) VALUES ('"+lastReqID+"','AndyW','"+modID+"','"+noStu+"')";
	strArray[strArrayCount] = strSQL;
	strArrayCount ++;
	
	strSQL = "INSERT INTO RequestTime (RequestID,Week,Day,Period) VALUES (";
	for(i=1;i<=weeks;i++){
		if(document.getElementById("s1w"+i).checked){
			for(j=0;j<dayarray.length;j++){
				for(k=1;k<=periods;k++){
					if(document.getElementById(dayarray[j]+k).value=='1'){
						strSQL += "'"+lastReqID+"','"+i+"','"+dayarray[j]+"','"+k+"'),(";
					}
				}
			}
		}
	}
	strSQL = strSQL.substr(0,strSQL.length - 2);
	strArray[strArrayCount] = strSQL;
	strArrayCount ++;
	
	factable = '<table id ="facilitytable"><tr><th>Room Type: </th><td colspan="3"><select id="type" name="type" size="1"><option value="facility0">'+facility[0]+'</option><option value="facility1">'+facility[1]+'</option><option value="facility2">'+facility[2]+'</option></select></td></tr>'	
	factable += '<tr><th>Room Style: </th><td colspan="3"><select id="style" name="style" size="1"><option value="facility3">'+facility[3]+'</option><option value="facility4">'+facility[4]+'</option></select></td></tr>'	
	
	strSQL = "INSERT INTO RequestFacility (RequestID,FacilityID) VALUES (";
	if(document.getElementById("type").value == "facility0"){
		strSQL += "'"+lastReqID+"','"+0+"'),(";
	}
	else if(document.getElementById("type").value == "facility1"){
		strSQL += "'"+lastReqID+"','"+1+"'),(";
	}
	else{
		strSQL += "'"+lastReqID+"','"+2+"'),(";
	}
	
	if(document.getElementById("style").value == "facility3"){
		strSQL += "'"+lastReqID+"','"+3+"'),(";
	}
	else{
		strSQL += "'"+lastReqID+"','"+4+"'),(";
	}
	
	for(i=5;i<facility.length;i++){
		if(document.getElementById("facility"+i).checked){
			strSQL += "'"+lastReqID+"','"+i+"'),(";
		}
	}
	strSQL = strSQL.substr(0,strSQL.length - 2);
	strArray[strArrayCount] = strSQL;
	strArrayCount ++;
	
	var roomChosen = false;
	strSQL = "INSERT INTO RequestRoom (RequestID,RoomID) VALUES (";
	for(i=1;i<=roomamnt;i++){
		if(!(document.getElementById("roomsuggest"+i).value == 'Any')){
			roomChosen = true;
			var roomCODE = document.getElementById("roomsuggest"+i).value;
			strSQL += "'"+lastReqID+"','"+roomCODE+"'),(";
		}
	}
	
	strSQL = strSQL.substr(0,strSQL.length - 2);
	if(roomChosen){
		strArray[strArrayCount] = strSQL;
		strArrayCount ++;
	}
	
	$(document).ready(function(){$("#update").load("writesql.php", {stringArray: (strArray)})});
}

function finishsubmit(){
	alert("Your booking request has been successfully submitted. It will now appear under MY SUMMARY.");
	window.location.reload();
}

</script>

</head>

<body onload="addDepts();updateDept();updateChoicenewold();modulesearch();updatePart();updateNameCode(document.getElementById('modulepart').value);maketimes();loadselector();">

<?php include 'php/header.php'; ?>
<div id="menu">
		<BR>
		<ul>
			<li><a href="start.php">Home</a></li>
			<li class="current_page_item"><a href="bookings.php">Make A Booking</a></li>
        	<li><a href="roominfo.php">Room Information / Availibility</a></li>		
        	<li><a href="roundinfo.php">Round Information</a></li>
			<li><a href="summary.php">My Summary</a></li>
			<li><a href="help.php">Contact / Help</a></li>
			<li><a href="../login.php">Logout</a></li>
 		</ul>
</div>


<div id="bookingspage">
<div id="content">

<div id='topbooking'><strong><center>Booking Form</center></strong></div>
<div id='allmodule'>
<br><center><strong><u>MODULE INFORMATION</u></strong></center><br>
	<div id='deptSelect'></div>
	<br></br>
	<div id='choicenewold'></div>
	<div id='moduleselection'>
		<div id='partSelect' style='margin-left:15px;'></div>
		<br>
		<div style='float:left;' id='codeSelect'></div>
		<div id='nameSelect'></div>
	</div>
<i>Note: If a module is repeated it means there are mutiple entries of the same name, so ensure the module code auto-selected is correct</i>
<br><br>
<strong>Number of Students:</strong> <input type='text' id='numOfStudents' name='numOfStudents' size='5' maxlength='4' loadselector();/>

</div>
	
	<div id='alltimes'>
<br><center><strong><u>TIME INFORMATION</u></strong></center><br>

	<div id='times'></div></div>




<div id="allroom">
<br><center><strong><u>ROOM INFORMATION</u></strong></center><br>
	<div id="rmchoicetitle" style="margin-bottom:20px; margin-left:10px"></div>
	<div id="rmfacilities">
		<div id='roomsentry'></div>
	</div>
</div>

<div id="button">
<input type="button" value="Make Booking Request" onClick="validateRequest();"/>
</div>


       
</div>
</div>

<div id="footer">
<p>Loughborough University Computer science Group 13</p>
</div>

<div id='update'></div>
<div id='update2'></div>

</body>
</html>
