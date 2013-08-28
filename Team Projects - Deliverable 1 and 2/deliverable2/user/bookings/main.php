<!--this script makes the booking form page and the editing request page
Written by Andrew Wallis, room info by Peter Krepa, room filter implemented by both, styling by Peter Krepa--!>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<?php include '../shared/usercheck.php'; ?>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>Loughborough University Room Booking System</title>
<link href="../../style.css" rel="stylesheet" type="text/css" />
<script src='../shared/jquery.js' type='text/javascript'></script>
<script type='text/javascript'>

//gets information on if new booking or old being edited
var loadediting =false;

//gets the users id
<?php echo 'var user = "'.$_SESSION['systemlogged1'].'" ; '; ?>

<?php
	if(!$_REQUEST['passreqid']) echo 'var editbool = false;';
	else{
		echo 'var editbool=true;';
		echo 'var editID='.$_REQUEST['passreqid'].';';
	}
?>


//makes appropriate page title

function maketitle(){
	if(editbool){
		var strtitle = 'Editing a Request';
		var strbutton ='Save Changes';
	}
	else{
		var strbutton ='Make Booking Request';
		var strtitle = 'Booking Form';
	}
	document.getElementById("titlediv").innerHTML = strtitle;
	document.getElementById("thesubmitbutton").value = strbutton;
}


//////////////////////////////////////////MAKE ROUNDS//////////////////////////////////////

var currentround = [];


//gets current rounds from database

<?php 
	$myconn2=mysql_connect("co-project.lboro.ac.uk",team13,b7c8pbvc);
	mysql_select_db("team13",$myconn2);
	$today = date("Y-m-d");
	$strSQL="SELECT * FROM RoundClosing WHERE Open<='".$today."' AND Close>'".$today."'";
	$result2=mysql_query($strSQL, $myconn2);
	$count=0;
	while($row=mysql_fetch_array($result2)){
		echo 'var record={} ; ';
		echo 'record.id="'.$row["RoundID"].'" ; ';
		echo 'record.semesterid="'.$row["SemesterID"].'" ; ';
		echo 'record.name="'.$row["Round"].'" ; ';
		echo 'currentround['.$count.']= record ; ';
		$count++;
	}
	if($pointer=='0'){
		echo'<i>none</i>';
	}
?>


//makes select of rounds

function makerounds(){
	<?php
		if(!$_REQUEST['roundH']) echo 'var prevround = -1;';
		else echo 'var prevround ="'.$_REQUEST['roundH'].'";';
	?>

	var strselect = '<strong>Round: </strong><select id="roundselect" onChange="getallocated();">';

	for(i=0;i<currentround.length;i++){
		strselect += '<option value="'+currentround[i].name+'">'+currentround[i].name+'</option>';
	}

	strselect += '</select>';
	
	document.getElementById("rounddiv").innerHTML = strselect;
	
	if(prevround != -1){
		for(i=0;i<currentround.length;i++){
			if(currentround[i].id == prevround || currentround[i].name == prevround)document.getElementById("roundselect").selectedIndex = i;
		}
	}
}

//////////////////////////////////////MAKE ALLOCATED REQUESTS///////////////////////////////////////////////


//makes an array of allocated records in the current semester

var allocatedrecord=[];
var weeks = 15;
var dayarray = ["Mon","Tue","Wed","Thu","Fri"];
var periods = 9;
var times = ["9am-<br>10am","10am-<br>11am","11am-<br>12pm","12pm-<br>1pm","1pm-<br>2pm","2pm-<br>3pm","3pm-<br>4pm","4pm-<br>5pm","5pm-<br>6pm"];

function getallocated(){
	for(i=0;i<currentround.length;i++){
		if(document.getElementById("roundselect").value == currentround[i].name){
			semester_ID = currentround[i].semesterid;
		}
	}
	$("#update").load("getallocatedtime.php", {searchsemester: (semester_ID)})
}

function passallocated(allocated){
	allocatedrecord = allocated;
	updatenumOfStudents();
}

//////////////////////////////////////////////////MAKING MODULE SELECTION//////////////////////////////////////

var depts = [];
var modules = [];
var parts = [];
var partsunique = [];
var modCode = [];
var newoldbool = false;
var modcodeH= <?php echo "'".$_REQUEST['modcodeH']."'" ?>;
var modnameH=<?php echo "'".$_REQUEST['modnameH']."'" ?>;
var nostuH=<?php echo "'".$_REQUEST['nostuH']."'" ?>;


///gets departments from database

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


//makes select list of departments

function updateDept(){
	var selectstr = '<strong>Module Department:</strong> <select name="moduledept" id="moduledept" onChange="modulesearch();">';
	for(i=0;i<depts.length;i++){selectstr += '<option value = "'+depts[i].name+'">'+depts[i].name+'</option>';}
	selectstr += '</select>';
	document.getElementById("deptSelect").innerHTML = selectstr;
	
	<?php
		if(!$_REQUEST['roundH']) echo 'var prevdept = -1;';
		else echo 'var prevdept ="'.$_REQUEST['departmentH'].'";';
	?>
	
	if(prevdept != -1){
		for(i=0;i<depts.length;i++){
			if(depts[i].name == prevdept)document.getElementById("moduledept").selectedIndex = i;
		}
	}
	
	if(nostuH>0){document.getElementById('numOfStudents').value=nostuH}
}


//makes choice of new or existing module

function updateChoicenewold(){
	var strnewold = "<strong>Enter:</strong> Existing Module<input type='radio' value='0' id='newoldrad' name='newoldrad' onClick='changenewold()' checked /> New Module<input type='radio' value='1' id='newoldrad' name='newoldrad' onClick='changenewold()' />";
	document.getElementById("choicenewold").innerHTML = strnewold;
	
	var string1 = '<strong>Module Code: </strong><input type="text" id="newmodCode1" name="newmodCode1" size="3" maxlength="3" disabled /><input type="text" id="newmodCode2" name="newmodCode2" size="3" maxlength="3" /><strong>Module Name:</strong><input type="text" name="newmodName" size="20" maxlength="50" />';
}


//changes page according to new or existing module

function changenewold(){
		newoldbool = !(newoldbool);
		updatePart();
		updateNameCode(document.getElementById("modulepart").value);
}


//gets modules from database according to department selected

function modulesearch(){
	$("#update").load("modsearch.php", {searchdept: (document.getElementById("moduledept").value)})
}

function passback(x,y){
	modules = x;
	partsunique = y;
	updatePart();
	updateNameCode(document.getElementById("modulepart").value);
}


//makes parts select acording to department selected

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


//makes module code select list and module name select list or makes entry for new ones

function updateNameCode(selected_part){
	if(!newoldbool){
		modCode = [];
		
		var selectstr = '<strong>Module Name</strong><br><select size="10" onChange="selectCode(this.value);" style="width:330px;" name="modulename" id="modulename"';
		var selectstr2 = '<strong>Module Code</strong><br><select size="10" onChange="selectName(this.value);" style="width:75px;" name="modulecode" id="modulecode"';
		j = 0;
		for(i=0;i<modules.length;i++){
			if(selected_part == "No Preference" || modules[i].part == selected_part){
				if(modules[i].name==modnameH){z=' selected '}else{z=''}
				selectstr += '<option'+z+'>'+modules[i].name+'</option>';
				modCode[j] = modules[i].id;
				j++;
			}
		}
		
		modCode.sort();
		for(i=0;i<modCode.length;i++){
		if(modCode[i]==modcodeH){z=' selected '}else{z=''}
			selectstr2 += '<option'+z+'>'+modCode[i]+'</option>';
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


//changes selected module name according to selected code

function selectName(selectedCode){
	var j = 0;
	for(i=0;i<modules.length;i++){
		if(modules[i].id == selectedCode){
			document.getElementById("modulename").selectedIndex = j;
		}
		if((document.getElementById("modulepart").value == "No Preference") || (modules[i].part == document.getElementById("modulepart").value)) j++;
	}
}


//changes selected module code according to module name

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


/////////////////////////////////////////////////////////////MAKING ROOM SELECTION /////////////////////////////////////////////////////////////////////////////////////////////////////


//start with empty records to be populated by the imported php

var parks = [];
var buildrecord = [];
var facility = [];
var buildnameslist = [];
var buildcodeslist = [];
var roomrecord=[];
var noFacilites = '';
selchosen = 'facility'
roomamnt = ''
options = '<br><strong>Filter By Number of Students:<input type="checkbox" id="studentfilter" onchange="updatesuggestions();"/><br><br><strong>Filter By Times Chosen:<input type="checkbox" id="timeschosen" onchange="updatesuggestions();"/>'

buildingcode = '<?php echo $_REQUEST['buildcodeH']; ?>'
buildingname = '<?php echo $_REQUEST['buildnameH']; ?>'
roomname = '<?php echo $_REQUEST['roomH']; ?>'


<?php include '../shared/facilitySQL.php';?>

<?php include '../shared/parkSQL.php';?>

<?php include '../shared/buildSQL.php';?>


//creates the option for the type of selector and starts up the roomselector function

function loadselector(){
	list = '<strong>Number of Rooms:</strong> <select id = "amntrooms" size = "1" onChange="roomselector()">'	
	for(x=1;x<=4;x++){	
		list += '<option value="'+x+'">'+x+'</option>'}
	list += '</select>'
	if(buildingname != ''){a='checked'; b='';selchosen='room'}else{a='';b='checked'}
	list += '<br><br><strong>Choose Room(s) By:</strong> Facilities:<input type="radio" onchange="javascipt:selchosen = this.value;roomselector()"  name="selchoice" id="javascipt:selchosen = this.value;selchoice"  value="facility" '+b+'>Preferred Room:</input><input type="radio" onchange="javascipt:selchosen = this.value;roomselector()" name="selchoice" id="selchoice" value="room" '+a+'/>'
	list += "<div id='options'>"+options+"</div>"
	document.getElementById("rmchoicetitle").innerHTML = list;
	roomselector()}


//creates the list of rooms or calls the facility maker depending on the way
//the user wishes to select a room

function roomselector(){
	<?php if(!$_REQUEST['roomAmount']) echo 'roomamnt = -1;';
		else echo 'roomamnt ='.$_REQUEST['roomAmount'].';';
	?>
	if(loadediting || roomamnt == -1 || roomamnt == 0){
		roomamnt = document.getElementById('amntrooms').value;
	}
	
	innerhtml = ''
	if(selchosen== 'room'){
		document.getElementById('options').innerHTML = ''
		innerhtml += ''
		for(x=1;x<=roomamnt;x++){
			innerhtml += 	'<div style = "float: left;  margin-left:10px; margin-right: 5px" id="parks'+x+'"></div><div style = "float: left;" id="buildcodes'+x+'"></div>'
			innerhtml += 	'<div style = "float: left;  margin-right: 5px" id="buildnames'+x+'"></div><div style = "float: left;  margin-right: 10px"  id="rooms'+x+'"></div><br><br><br><br><br><br><br><br><br><br><br><br>'}
		document.getElementById("roomsentry").innerHTML = innerhtml;
		document.getElementById("rmfacilities").style.width = '460px'
		document.getElementById("rmfacilities").style.height = (170*roomamnt)+'px';
		makeparklist(roomamnt);}
	if(selchosen== 'facility'){
		document.getElementById('options').innerHTML = options
		innerhtml += '<div id="rmchoice" style="float:left; border-right: solid 1px; height:270px"></div><div style="margin-top:10px;"><b>&nbsp;&nbsp;Suggested<br>&nbsp;&nbsp;Rooms:</b></div>'
		for(x=1;x<=roomamnt;x++){
			innerhtml += 	'<div style = "float: left; margin-left: 3px; margin-top:40px;"  id="rooms'+x+'"></div>'}
		document.getElementById("roomsentry").innerHTML = innerhtml;
		document.getElementById("rmfacilities").style.height = '285px';
		document.getElementById("rmfacilities").style.width = 610+(90*roomamnt)+'px';
		makeroomfilter();
		updatesuggestions();}}
		

//creates the table with the list of facilities which had been loaded previously from the database

function makeroomfilter(){
	factable = '<table id ="facilitytable"><tr><th>Room Type: </th><td colspan="1"><select id="type" name="type" size="1" onchange="updatesuggestions()"><option value="Any">Any</option><option value="facility0">'+facility[0]+'</option><option value="facility1">'+facility[1]+'</option><option value="facility2">'+facility[2]+'</option></select></td><td><strong>Park: </strong>'
	factable +='<select size="1" onchange="updatesuggestions()" id="sugpark"><option value="Any">Any</option>'
	for(a=0;a<parks.length;a++){factable +='<option value="'+parks[a]+'">'+parks[a]+'</option>'}	
	factable += '<tr><th>Room Style: </th><td colspan="3"><select id="style" name="style" size="1" onchange="updatesuggestions()"><option value="Any">Any</option><option value="facility3">'+facility[3]+'</option><option value="facility4">'+facility[4]+'</option></select></td></tr>'	
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
	

//makes a list of parks (repeats this for the amount of rooms chosen)

function makeparklist(roomamnt){
	for(x=1;x<=roomamnt;x++){
		var selectpark = '<select size = "10" name="parkselect'+x+'" id="parkselect'+x+'" onchange = "makebuildlist(this.value,'+x+');" style="width: 50px" >'	
		selectpark += '<option value="All" selected>All</option>'	
		for(i=0;i<parks.length;i++){
			selectpark += '<option value="'+parks[i]+'">'+parks[i]+'</option>'}	
		selectpark += '</select>'
	document.getElementById("parks"+x).innerHTML=selectpark
	makebuildlist('All',x)}}


//makes a list of buildings (again repeats this for the amount of rooms chosen)

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
	
	
//changed the buildid on the corresponding table when a name is clicked

function changebuildid(chsnbuild,y){
	for(x=0;x<buildrecord.length;x++){
		if(buildrecord[x].name == chsnbuild){buildno = x; var newbuildcode = buildrecord[x].buildingid}}
	for(x=0;x<buildcodeslist[y].length;x++){
		if(buildcodeslist[y][x]==newbuildcode){document.getElementById('buildidselect'+y).selectedIndex = x}}
	updaterooms(y)}


//changed the buildname on the corresponding table when a name is clicked

function changebuildname(chsnbuild,z){
	var buildname = ''
	for(x=0;x<buildrecord.length;x++){
		if(buildrecord[x].buildingid == chsnbuild)
			{buildno = x; buildname = buildrecord[x].name}}
	for(y=0;y<buildnameslist[z].length;y++){
		if(buildnameslist[z][y] == buildname)
			{document.getElementById("buildnameselect"+z).selectedIndex = y}}
	updaterooms(z)}


//makes a list of rooms

function makeroomlist(x,y){
	roomrecord = x
	selectroom = '<select size = "10" id="roomlist'+y+'" style="width: 85px" >'
	for (i=0;i<roomrecord.length;i++){
		if(roomrecord[i].roomid==roomname){z='selected'}else{z=''}
		selectroom += '<option value="'+roomrecord[i].roomid+'"'+z+'>'+roomrecord[i].roomid+'</option>'}
	selectroom += '</select>';
	document.getElementById("rooms"+y).innerHTML = selectroom;}


//makes a list of suggested rooms when a user is selecting by facility, from the suggested room array

function makeroomsuggestion(x){
	roomrecord = x
	for(z=1;z<=roomamnt;z++){
		selectroom = '<select size = "10" style="width: 85px" id="roomsuggest'+z+'">'
	selectroom += '<option value="Any" selected>Any</option>'
	for (i=0;i<roomrecord.length;i++){
		selectroom += '<option value="'+roomrecord[i].roomid+'">'+roomrecord[i].roomid+'</option>'}
	selectroom += '</select>'
	
	
	document.getElementById("rooms"+z).innerHTML = selectroom;}
	if(!loadediting){
		loadediting = true;
		fillediting();	
	}
	}


//loads the record of rooms into the list depending on the building selected

function updaterooms(x){
	$(document).ready(function(){$("#update").load("bookingroomslist.php", {var1: (document.getElementById("buildidselect"+x).value), var2:(document.getElementById("buildnameselect"+x).value), var3: x })});}


//updates the suggested room array

function updatesuggestions(){
	var writeSQL = 'SELECT RoomID FROM Room WHERE ';
	//adds to select statement to filter rooms according to chosen number of students
	if(document.getElementById("studentfilter").checked){writeSQL += 'Capacity >= '+document.getElementById("numOfStudents").value}else{writeSQL += 'Capacity >= 0 '};
	
	if(document.getElementById("sugpark").value != "Any"){writeSQL += ' AND RoomID IN(SELECT Room.RoomID FROM Room INNER JOIN Building ON Room.BuildingID = Building.BuildingID WHERE Building.Park ="'+document.getElementById("sugpark").value+'")'};
	if(document.getElementById('type').value != "Any"){writeSQL += ' AND RoomID IN(SELECT RoomID FROM RoomFacility WHERE FacilityID = "'+(document.getElementById('type').selectedIndex-1)+'")'}
	if(document.getElementById('style').value != "Any"){writeSQL += ' AND RoomID IN(SELECT RoomID FROM RoomFacility WHERE FacilityID = "'+(document.getElementById('style').selectedIndex+2)+'") '}
	for(x=5;x<noFacilities;x++){
	if(document.getElementById('facility'+x).checked==true){
		writeSQL += ' AND RoomID IN(SELECT RoomID FROM RoomFacility WHERE FacilityID="'+x+'")'
	}}
	
	//adds to select statement to filter rooms according to chosen time table
	if(document.getElementById("timeschosen").checked){
		writeSQL += ' AND RoomID IN(SELECT RoomID FROM Room WHERE ';
		
		for(i=0;i<allocatedrecord.length;i++){
			for(j=0;j<allocatedrecord[i].time.length;j++){
				for(k=0;k<allocatedrecord[i].rooms.length;k++){
					for(l=1;l<=weeks;l++){
						if(document.getElementById("s1w"+l).checked && allocatedrecord[i].time[j].week == l){
							if(document.getElementById(allocatedrecord[i].time[j].day+allocatedrecord[i].time[j].period).value=='1'){
								writeSQL += ' RoomID <> "'+allocatedrecord[i].rooms[k]+'" AND';
							}
						}
					}
				}
			}
		}
		
		writeSQL = writeSQL.substr(0,writeSQL.length - 4);
		writeSQL += ')';
	}
	$("#update").load("bookingroomfilter.php", {sql: writeSQL})
}


//filters the rooms by number of students
	
function updatenumOfStudents(){
	if(document.getElementById("studentfilter")) if(document.getElementById("studentfilter").checked) updatesuggestions();
}


///////////////////////////////////////////////////////////////////////MAKING TIMETABLE SELECTION///////////////////////////////////////////////////////////////////////////////////////////////////////////

//changes colour and value of clicked on element in time table


function select1(chosen){if(document.getElementById(chosen).value=="1"){document.getElementById(chosen).style.backgroundColor="WHITE";document.getElementById(chosen).value="0"}
				else{document.getElementById(chosen).style.backgroundColor="#488AC7";document.getElementById(chosen).value="1"}}


//makes a time table and weeks check boxes with radio for all and let me choose

function maketimes(){
	var strtt = '<table id="times"><tr><th>Period:</th>';
	for(i=1;i<=periods;i++) strtt += '<th>'+i+'</th>';
	strtt += '</tr><tr><th>Times:</th>'
	for(i=0;i<times.length;i++) strtt += '<th>'+times[i]+'</th>';

	for(j=0;j<dayarray.length;j++){
		strtt += '</tr>';
		strtt += '<tr><th>'+dayarray[j]+'</th>';
		for(i=1;i<=periods;i++) strtt += '<td value="0" id="'+dayarray[j]+i+'" onclick="select1(this.id);filtertimetable();"></td>';
	}

	strtt += '</tr></table><br><i>To select a time please click the appropiate box, if it is blue this means it is selected</i>';

	strtt += '<br><br><br><strong>Weeks in Semester:</strong><input value="0" name="sem1" type="radio" onChange="activeSem1(this.value);"';
	
	if(editbool)	strtt +='/>All <input value="1" name="sem1" type="radio" onChange="activeSem1(this.value)" checked />Let me choose<br></br>';
	
	else strtt +='checked />All <input value="1" name="sem1" type="radio" onChange="activeSem1(this.value)" />Let me choose<br></br>';
	
	
	for(i=1;i<=weeks;i++) strtt += '<input name="s1w'+i+'" id="s1w'+i+'" type="checkbox" onClick="filtertimetable();" checked disabled>'+i;

	document.getElementById("times").innerHTML = strtt;
}


//changes week checkboxes to all enabled/disabled and checks them if all is selected on radio

function activeSem1(inval){
	for(i=1;i<=weeks;i++) document.getElementById("s1w"+i).disabled = !(document.getElementById("s1w"+i).disabled);
	if(inval == '0'){
		for(i=1;i<=weeks;i++) document.getElementById("s1w"+i).checked = true;
	}
}
//if filter by time table is checked get new results for suggested rooms
function filtertimetable(){
	if(document.getElementById("timeschosen")) if(document.getElementById("timeschosen").checked)  updatesuggestions();
}


//////////////////////////////////////////////VALIDATION////////////////////////////////////////////////////////////////////


//checksmodule has been chosen or new one entered is valid, checks number of students entered is valid, checks if timetable has an entry, checks rooms chosen if on prefered room
//if all accepted submits booking request

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
	
	if(selchosen=='room'){
		for(i=1; ok && i<=roomamnt;i++){
			if(!document.getElementById("roomlist"+1) || !(document.getElementById("roomlist"+i).selectedIndex >= 0)){
				if(roomamnt == 1) alert("You have not chosen your prefered room.");
				else alert("You have not chosen all your prefered rooms.");
				ok = false;
			}
		}
	}
	
	if(ok) submitRequest();
}


////////////////////////////////////////////////////SUBMITTING REQUEST///////////////////////////////////////////////////////


//loads last request id

function submitRequest(){
$("#update2").load("getrequestid.php")
}


//appends last request id

function passlastReqID(lastReqID){
	lastReqID ++;
	var str = '';
	var strArray = [];
	var strArrayCount = 0;
	//adds sql for making new module to database
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
	//gets round of request
	for(i=0;i<currentround.length;i++){
		if(document.getElementById("roundselect").value == currentround[i].name){
			round_ID = currentround[i].id;
		}
	}
	//add sql for new request in database
	var noStu = document.getElementById('numOfStudents').value;
	strSQL = "INSERT INTO Request (RequestID,UserID,ModuleID,NoStudents,RoundID) VALUES ('"+lastReqID+"','"+user+"','"+modID+"','"+noStu+"','"+round_ID+"')";
	strArray[strArrayCount] = strSQL;
	strArrayCount ++;
	//add sql for new requesttime in database
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
	//add sql for new requestfacility in database
	if(selchosen=='facility'){
		strSQL = "INSERT INTO RequestFacility (RequestID,FacilityID) VALUES (";
		if(document.getElementById("type").value == "facility0"){
			strSQL += "'"+lastReqID+"','"+0+"'),(";
		}
		if(document.getElementById("type").value == "facility1"){
			strSQL += "'"+lastReqID+"','"+1+"'),(";
		}
		if(document.getElementById("type").value == "facility2"){
			strSQL += "'"+lastReqID+"','"+2+"'),(";
		}
		
		if(document.getElementById("style").value == "facility3"){
			strSQL += "'"+lastReqID+"','"+3+"'),(";
		}
		if(document.getElementById("style").value == "facility4"){
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
	}

	if(selchosen=='facility'){
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
	}
	//adds sql for new requestroom in database
	if(selchosen=='room'){
		strSQL = "INSERT INTO RequestRoom (RequestID,RoomID) VALUES (";
		for(i=1;i<=roomamnt;i++){
			var roomCODE = document.getElementById("roomlist"+i).value;
			strSQL += "'"+lastReqID+"','"+roomCODE+"'),(";
		}
		strSQL = strSQL.substr(0,strSQL.length - 2);
		strArray[strArrayCount] = strSQL;
		strArrayCount ++;
	}
	//adds delete sql if editing
	if(editbool){
		for(i=0;i<deletearray.length;i++){
			strArray[strArrayCount] = deletearray[i];
			strArrayCount ++;
		}
	}
	//writes sql to sql query
	$(document).ready(function(){$("#update").load("writesql.php", {stringArray: (strArray)})});
}

var allhtml = ''
var questionhtml = '<br><br><strong>Your booking request has been successfully submitted. It will now appear under MY SUMMARY.</strong><br><br><br><a href="http://co-project.lboro.ac.uk/team13/deliverable2/user/summary/main.php"> To got the MY SUMMARY page click here</a><br><br><a onclick="newbooking(0)"> To enter a request for the same module click here</a><br><br><a onclick="newbooking(1)"> To enter a brand new request click here</a><br>'


//adds appopriate data to hidden form and submits form, asked for where to go next after submitting booking request and goes to appropriate locations

function finishsubmit(){
	if(newoldbool){var modID = document.getElementById("newmodCode1").value + document.getElementById("newmodCode2").value;
					var modname = document.getElementById("newmodName").value;
	}
	else {var modID = document.getElementById("modulecode").value;var modname = document.getElementById("modulename").value;
	}
	document.getElementById('roundH').value = document.getElementById('roundselect').value;
	document.getElementById('departmentH').value = document.getElementById('moduledept').value;
	document.getElementById('modcodeH').value = modID;
	document.getElementById('modnameH').value = modname;
	document.getElementById('nostuH').value = document.getElementById('numOfStudents').value;
	allhtml = document.getElementById('all').innerHTML;
	window.scrollTo(0, 0);
	document.getElementById('all').innerHTML= questionhtml;
}


//refreshes the page if a user wants to make a new booking
//otherwise it sumbits the hidden form and auto fills the module

function newbooking(x){
	if(x==0){document.getElementById("hidden").submit();}
	if(x==1){window.location.reload();}
}


//enables the popup help

function open_win(){
	myWindow=window.open('../helppages/bookinghelp.html','','width=500,height=600');
	myWindow.focus();
}


/////////////////////////////////////////////////////////FILL EDITING///////////////////////////////////////////////////////////////////////////////

var deletearray = [];


//gets info on request being edited from database

function fillediting(){
	if(editbool){
		$("#update").load("makeedit.php", {passreqid: (editID)})
	}
}


//changes form to have information of request being edited already filled in, makes sql statement for deleting old request

function passedit(editround_id,editrooms,edittime,editfacilities){
	for(i=1;i<=weeks;i++){
		document.getElementById('s1w'+i).disabled = false;
		document.getElementById('s1w'+i).checked = false;
	}
		
	for(i=0;i<edittime.length;i++){
		document.getElementById(edittime[i].day+edittime[i].period).style.backgroundColor="#488AC7";
		document.getElementById(edittime[i].day+edittime[i].period).value="1";
		
		for(j=1;j<=weeks;j++){
			if(edittime[i].week == j) document.getElementById('s1w'+edittime[i].week).checked = true;
		}
	}
	
	for(i=0;i<editfacilities.length;i++){
		if(editfacilities[i] <= 2){
			document.getElementById("type").selectedIndex = editfacilities[i];
			document.getElementById("type").selectedIndex ++;
		}
		if(editfacilities[i] > 2 && editfacilities[i] <= 4){
			editfacilities[i] -= 2;
			document.getElementById("style").selectedIndex = editfacilities[i];
		}
		if(editfacilities[i] > 4) document.getElementById("facility"+editfacilities[i]).checked = true;
	}
	
	document.getElementById('amntrooms').selectedIndex = roomamnt - 1;
	
	for(i=1;i<=roomamnt;i++){
		for(j=0;j<roomrecord.length;j++){
			if(roomrecord[j].roomid == editrooms[i-1]) document.getElementById('roomsuggest'+i).selectedIndex = j+1;
		}
	}
	
	deletearray = [];
	deletearraycounter = 0;
	deletearray[deletearraycounter] = "DELETE FROM Request WHERE RequestID='"+editID+"'";
	deletearraycounter ++;
	for(i=0;i<editfacilities.length;i++){
		deletearray[deletearraycounter] = "DELETE FROM RequestFacility WHERE RequestID='"+editID+"'";
		deletearraycounter ++;
	}
	for(i=0;i<edittime.length;i++){
		deletearray[deletearraycounter] = "DELETE FROM RequestTime WHERE RequestID='"+editID+"'";
		deletearraycounter ++;
	}
	for(i=0;i<editrooms.length;i++){
		deletearray[deletearraycounter] = "DELETE FROM RequestRoom WHERE RequestID='"+editID+"'";
		deletearraycounter ++;
	}
}

</script>

</head>

<body onload="maketitle();makerounds();getallocated();addDepts();updateDept();updateChoicenewold();modulesearch();updatePart();updateNameCode(document.getElementById('modulepart').value);maketimes();loadselector();">

<?php include '../shared/header2.php'; ?>
<div id="menu">
		<BR>
		<ul>
			<li><a href="../start.php">Home</a></li>
			<li class="current_page_item"><a href="main.php">Make A Booking</a></li>
        	<li><a href="../roominfo/main.php">Room Information / Availibility</a></li>		
        	<li><a href="../roundinfo.php">Round Information</a></li>
			<li><a href="../summary/main.php">My Summary</a></li>
			<li><a href="../help.php">Contact / Help</a></li>
			<li><a href="../../login.php">Logout</a></li>
 		</ul>
</div>


<div id="bookingspage">
	<div id="content">

		<div id="all">

			<div id='topbooking'>
				<strong><center><em><div id='titlediv'></div></em></center></strong>
				<div style='text-align:right;margin-right:20px'><a onclick="open_win()">If you need help with this page click here </a></div>
				<br>
				<div id="rounddiv"></div>
			</div>
			
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
				<strong>Number of Students:</strong> <input type='text' id='numOfStudents' name='numOfStudents' size='5' maxlength='4' OnKeyUp='updatenumOfStudents();' />
			</div>
				
			<div id='alltimes'>
				<br><center><strong><u>TIME INFORMATION</u></strong></center><br>
				<div id='times'></div>
			</div>

			<div id="allroom">
				<br><center><strong><u>ROOM INFORMATION</u></strong></center><br>
				<div id="rmchoicetitle" style="margin-bottom:20px; margin-left:10px"></div>
				<div id="rmfacilities">
					<div id='roomsentry'></div>
				</div>
			</div>

			<div id="button">
				<input type="button" id="thesubmitbutton" value="" onClick="validateRequest();"/>
			</div>
			
		</div>
		
		<form name='hidden' id='hidden' method="post" action="main.php">
			<input type='hidden' name='modcodeH' id='modcodeH' value='' />
			<input type='hidden' name='modnameH' id='modnameH' value='' />
			<input type='hidden' name='nostuH'  id='nostuH' value='' />
			<input type='hidden' name='departmentH'  id='departmentH' value='' />
			<input type='hidden' name='roundH'  id='roundH' value='' />
		</form>
			   
	</div>
</div>

<div id="footer">
<p>Loughborough University Computer science Group 13</p>
</div>

<div id='update'></div>
<div id='update2'></div>

</body>
</html>
