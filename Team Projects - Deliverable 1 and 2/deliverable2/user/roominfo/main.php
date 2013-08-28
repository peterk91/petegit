<!--This script contains all the functionality for making the room information selector
and display the correct information about the room - and showing its availibilty.
It also lets the user filter the rooms by faclilties.
Written by Peter Krepa. Semester functionality added by Andrew Wallis.-->

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<?php include '../shared/usercheck.php'; ?>

<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />

<title>Loughborough University Room Booking System</title>

<link href="../../style.css" rel="stylesheet" type="text/css"/>

<script src='../shared/jquery.js' type='text/javascript'></script>

<script type='text/javascript'>

//the script starts off with empty records, which are then filled up by imported php files

var parks = [];						
var buildrecord = [];
var facility = [];
var buildnameslist = [];
var buildcodeslist = [];
var roomrecord=[];
var timesrecord = [];
var noFacilites = '';
var roomname = ''
var selectedsemester ='0';
var room_ID = 0;

<?php include '../shared/parkSQL.php';?>
<?php include '../shared/buildSQL.php';?>
<?php include '../shared/facilitySQL.php';?>


//the below function makes the facility filter, it uses loops to create the information about all the options
//for facilities on the database

function makefacilites(){
	var list = '<strong><u><em>Choose Advance Filter Options: </em></u></strong>ON:<input type="radio" name="filter" onchange="changefilter(this.value)" id="filter" value="ON"/> OFF:<input type="radio" checked onchange="changefilter(this.value)" name="filter" id="filter" value="OFF"/><table id ="facilitytable">'
	list += '<tr><th>Room Type: </th><td colspan="1"><select onchange="updateall(this.value)" id="type" name="type" size="1"><option value ="Any">Any</option><option value="facility0">'+facility[0]+'</option><option value="facility1">'+facility[1]+'</option><option value="facility2">'+facility[2]+'</option></select></td><td>Capacity Required: <input disabled type="text" id="capacity1" size="5" maxlength="4" OnKeyUp="updateall();" /></td></tr>'	
	list += '<tr><th>Room Style: </th><td colspan="3"><select onchange="updateall(this.value)" id="style" name="style" size="1"><option value ="Any">Any</option><option value="facility3">'+facility[3]+'</option><option value="facility4">'+facility[4]+'</option></select></td></tr>'	
	for(x=5;x<facility.length;x++){
		if(x==5){list += '<tr><th>Room Facilities: </th>'}
		if(x<=7){list += '<td><input onclick="updateall(this.value)" type="checkbox" name="facility'+x+'" value="'+x+'" id="facility'+x+'">'+facility[x]+'</input><br></td>'}
		if(x==7){list += '</tr><tr><td> </td>'}
		if(x>7){list += '<td><input onclick="updateall(this.value)" type="checkbox"   name="facility'+x+'" value="'+x+'" id="facility'+x+'">'+facility[x]+'</input><br></td>'}
		if(x>7 && (Math.round((x-1)/3) == ((x-1)/3))){list += '</tr><tr><td> </td>'}
		}
	list += '</tr></table>'
	document.getElementById("facilities").innerHTML = list;
	noFacilities = x
	changefilter('OFF')
}


//creates a list for the park array

function makeparklist(){
	var select = '<select size = "18" name="parkselect" id="parkselect" onchange = "makebuildlist(this.value);makeblankroomlist()" style="width: 50px" >'	
	select += '<option value="All" selected>All</option>'	
	for(i=0;i<parks.length;i++){
		select += '<option value="'+parks[i]+'">'+parks[i]+'</option>'
		}	
	select += '</select>'
	document.getElementById("parks").innerHTML = select
}


//creates the list of buildings depending on what park is selected. On load it shows buildings in all parks.

function makebuildlist(chosen){
	var select1 = '<select size = "18" name="buildidselect" id="buildidselect" onchange="changebuildname(this.value);update();" style="width: 70px" >'
	var select2 = '<select size = "18" name="buildnameselect" id="buildnameselect" onchange="changebuildid(this.value);update();" style="width: 225px" >'
	var buildcodeslist1 = []
	var buildnameslist1= []
	if(chosen=='All'){
		for(i=0;i<buildrecord.length;i++){
			buildnameslist1[i] = buildrecord[i].name
			buildcodeslist1[i] = buildrecord[i].buildingid
			}	
		}
	else{
		var z = 0
		for(i=0;i<buildrecord.length;i++){
			if(buildrecord[i].park == chosen){
				buildnameslist1[z] = buildrecord[i].name
				buildcodeslist1[z] = buildrecord[i].buildingid
				z++
				}
			}
		}
	buildnameslist = buildnameslist1
	buildcodeslist = buildcodeslist1
	buildnameslist.sort()
	for(y=0;y<buildnameslist.length;y++){
		select1 += '<option value ="'+buildcodeslist[y]+'">'+buildcodeslist[y]+'</option>'
		select2 += '<option value ="'+buildnameslist[y]+'">'+buildnameslist[y]+'</option>'}
	select1 += '</select>'
	select2 += '</select>'
	document.getElementById("buildcodes").innerHTML = select1
	document.getElementById("buildnames").innerHTML = select2
}


//this function selects the appropiate buildingid when the buildingname is changed

function changebuildid(chsnbuild){
	for(x=0;x<buildrecord.length;x++){
		if(buildrecord[x].name == chsnbuild){buildno = x; var newbuildcode = buildrecord[x].buildingid}
		}
	for(x=0;x<buildcodeslist.length;x++){
		if(buildcodeslist[x]==newbuildcode){document.getElementById('buildidselect').selectedIndex = x}
		}
		document.getElementById("information").innerHTML = '';
}


//this funtions selects the appropiate buildingname when the buildingid is changed

function changebuildname(chsnbuild){
	var buildname = ''
	for(x=0;x<buildrecord.length;x++){
		if(buildrecord[x].buildingid == chsnbuild)
			{buildno = x; buildname = buildrecord[x].name}}
	for(y=0;y<buildnameslist.length;y++){
		if(buildnameslist[y] == buildname)
			{document.getElementById("buildnameselect").selectedIndex = y}}
	document.getElementById("information").innerHTML = '';
}


//creates a blank list of roooms when the park is changed and onload

function makeblankroomlist(){
	var list = '<select size = "18" style="width: 85px" >'	
	list += '</select>'
	document.getElementById("rooms").innerHTML = list;	
}
	

//this funtions selects the appropiate buildingid when the buildingname is changed
	
function makeroomlist(x){
	roomrecord = x
	var select = '<select size = "18" id="roomselect" onchange="(makeroominfo(this.value))" style="width: 85px" >'
	for (i=0;i<roomrecord.length;i++){
			select += '<option value="'+roomrecord[i].roomid+'">'+roomrecord[i].roomid+'</option>'			
			}
	select += '</select>'
	document.getElementById("rooms").innerHTML = select;
}


//the next function makes all the information about the room that has been selected. It does this by writing
//the HTML and then putting it into a div tag

function makeroominfo(chosen){
	for(i=0;i<roomrecord.length;i++){
		if(roomrecord[i].roomid==chosen){var roomno = i}
		}
	for(x=0;x<buildrecord.length;x++){
		if(roomrecord[roomno].buildingid == buildrecord[x].buildingid){var buildingno = x}
		}
	var info = "<div id='roominfo'><div id='infotitle'>Room Profile</div><div id='infoleft'><br><br><h1>Room:</h1><h2>"
	info += roomrecord[roomno].roomid
	roomname = roomrecord[roomno].roomid
	info += "</h2><br><br><h1>Building:</h1><h2>"
	var name = buildrecord[buildingno].name
	if(name.length>16){names = name.split(' '); info+='<h2>'+names[0]; if(names[1]!=''){info+=' '+names[1]+'</h2><br><h4>'};  for(p=2;p<names.length;p++){info+=' '+names[p]}}
	else{info += name}
	info += " ("+roomrecord[roomno].buildingid+")"
	info += "</h4><br><br><h1>Park:</h1><h2>"
	info += buildrecord[buildingno].park
	info += "</h2><br><br><h1>Capacity:</h1><h2>"
	info += roomrecord[roomno].capacity
	info += "</h2>"
	var fac = roomrecord[roomno].facility
	info += "</h2><br><br><h1>Type:</h1><h2>"
	info += facility[(fac[0])]
	info += "</h2><br><br><h1>Style:</h1><h2>"
	info += facility[(fac[1])]
	info += "</h2></div><div id='infomid'><img width = '256px' height = '182px' src='http://www.lboro.ac.uk/service/fm/services/ts/roompics/"
	info += roomrecord[roomno].imgurl
	info += "'</div><div id='inforight'><div id=avali></div></div>"
	info += "<div id='infomiddle'><br><table><tr><th>Facilities:</th>"
	for(x=2;x<fac.length;x++){
		if(x>2 && Math.round((x)/2) == ((x)/2)){info += '<tr><th></th>'}
		info += '<td>'+facility[(fac[x])]+'</td>'
		if(Math.round((x-1)/2) == ((x-1)/2)){info += '</tr>'}
		}
	info += "</table></div>"
	info += "<div id='infobottom'>"
	info += "<input type='button' onclick='bookroom()' value='Book this room' /><div id=avali></div></div></div>"
	document.getElementById("information").innerHTML = info;
	room_ID = roomno;
	maketable();
	selectedsemester = document.getElementById("semesterselect").value;
	$(document).ready(function(){$("#update").load("timetableinfo.php", {roomid: roomrecord[roomno].roomid, searchsemester: selectedsemester})});
}


//the below function creates a semester record and makes a select list

function makeSemesters(){
	var strselect = '<select id="semesterselect" onChange="javascript:selectedsemester=this.value;changesemester();">';
	var semesterrecord = [];
	<?php
		$roomid = $_REQUEST['roomid'];
		$myconn2=mysql_connect("co-project.lboro.ac.uk",team13,b7c8pbvc);
		mysql_select_db("team13",$myconn2);
		$stateSQL = 'SELECT * FROM Semester';
		$result2=mysql_query($stateSQL, $myconn2);
		$count = 0;
		while($row=mysql_fetch_array($result2)){
			echo 'var record={} ; ';
			echo 'record.id="'.$row["SemesterID"].'";';
			echo 'record.name="'.$row["Name"].'";';
			echo 'semesterrecord['.$count.']=record;';
			$count++;
		};
	?>
	
	for(i=0;i<semesterrecord.length;i++){
		strselect += '<option value="'+semesterrecord[i].id+'">'+semesterrecord[i].name+'</option>';
	}
	
	strselect += '</select>';
	
	document.getElementById("semesterdiv").innerHTML = strselect;
}


//the below function updates the timetable when the semester is changed

function changesemester(){
	$(document).ready(function(){$("#update").load("timetableinfo.php", {roomid: roomrecord[room_ID].roomid, searchsemester: selectedsemester})});
}


//the next function create the timetable for a selected room

function maketable(){
	var weeks = 15;
	var dayarray = ["Mon","Tue","Wed","Thu","Fri"];
	var periods = 9;
	var times = ["9am-<br>10am","10am-<br>11am","11am-<br>12pm","12pm-<br>1pm","1pm-<br>2pm","2pm-<br>3pm","3pm-<br>4pm","4pm-<br>5pm","5pm-<br>6pm"];
	var strtt = '<table id="avali">'
	strtt += '<tr><td colspan = "4"><div id="semesterdiv"></div></td><td style="border: 0px" colspan = "1"> Week: <select onchange="fillweek(this.value)" size = "1">';
	for(i=1;i<=weeks;i++){strtt += '<option>'+i+'</option>'}
	strtt += '</select></td></tr>'
	strtt += '<tr><th>Period:</th>';
	for(i=1;i<=periods;i++){strtt += '<th>'+i+'</th>';}
	strtt += '</tr><tr><th>Times:</th>'
	for(i=0;i<times.length;i++){strtt += '<th>'+times[i]+'</th>';}
	for(j=0;j<dayarray.length;j++){
		strtt += '</tr>';
		strtt += '<tr><th>'+dayarray[j]+'</th>';
		for(i=1;i<=periods;i++) strtt += '<td value="no" id="'+dayarray[j]+i+'" onclick="select(this.id)"></td>';
	}
	strtt += '</tr></table>';
	document.getElementById("avali").innerHTML = strtt;
	makeSemesters();
}


//this function fills the table table the with default week of 1

function filltable(x){
	timesrecord = x;
	fillweek('1');
}


//this function fills the timtable the the appropiate information

function fillweek(x){
	var dayarray = ["Mon","Tue","Wed","Thu","Fri"];
	var periods = 9;
	for(j=0;j<dayarray.length;j++){
		for(i=1;i<=periods;i++){
			document.getElementById(dayarray[j]+i).style.background = 'WHITE'
		}
	}
	for(c=0;c<timesrecord.length;c++){
		if(timesrecord[c].week==x){document.getElementById(timesrecord[c].day+timesrecord[c].period).style.background = 'RED'}
		}
}


//the following function updates the room list when a building is selected

function update(){
	sqlstatment = 'SELECT * FROM Room WHERE BuildingId = "'+document.getElementById("buildidselect").value+'" ;';
	$("#update").load("roomFilter.php", {sql: sqlstatment});
}


//the below function updates the room list when the facility filter is on

function updateall(){
	total = document.getElementById('type').selectedIndex+document.getElementById('style').selectedIndex+3
	var writeSQL = 'SELECT * FROM Room WHERE ';
	if(document.getElementById("capacity1").value != ''){writeSQL += 'Capacity >= '+document.getElementById("capacity1").value}else{writeSQL += 'Capacity >= 0 '};
	if(document.getElementById('type').value != "Any"){writeSQL += ' AND RoomID IN(SELECT RoomID FROM RoomFacility WHERE FacilityID = "'+(document.getElementById('type').selectedIndex-1)+'")'}
	if(document.getElementById('style').value != "Any"){writeSQL += ' AND RoomID IN(SELECT RoomID FROM RoomFacility WHERE FacilityID = "'+(document.getElementById('style').selectedIndex+2)+'") '}
	for(x=5;x<noFacilities;x++){
	if(document.getElementById('facility'+x).checked==true){
		writeSQL += ' AND RoomID IN(SELECT RoomID FROM RoomFacility WHERE FacilityID="'+x+'") '
	}}
	$("#update").load("roomFilter.php", {sql: writeSQL})
	document.getElementById('information').innerHTML = ''
}


//the following function is run when the filter the filter option in changed
//in enables and disables the appropiate checkboxes

function changefilter(option){
	if(option=='ON'){
		makeparklist();
		makebuildlist("All");
		document.getElementById("parkselect").disabled=true;
		document.getElementById("buildidselect").disabled=true;
		document.getElementById("buildnameselect").disabled=true;
		document.getElementById("parkselect").selectedIndex=-1;
		document.getElementById("buildidselect").selectedIndex=-1;
		document.getElementById("buildnameselect").selectedIndex=-1;
		document.getElementById("type").disabled=false;
		document.getElementById("style").disabled=false;	
		document.getElementById("capacity1").disabled=false;		
		for(x=5;x<facility.length;x++){
			document.getElementById("facility"+x).disabled=false;
		}
		document.getElementById("information").innerHTML = '';updateall()
	}
	if(option=='OFF'){
		document.getElementById("parkselect").disabled=false;
		document.getElementById("buildidselect").disabled=false;
		document.getElementById("buildnameselect").disabled=false;
		document.getElementById("parkselect").selectedIndex=0;
		document.getElementById("type").disabled=true;
		document.getElementById("type").selectedIndex=0;
		document.getElementById("style").disabled=true;
		document.getElementById("style").selectedIndex=0;
		document.getElementById("capacity1").disabled=true;
		for(x=5;x<facility.length;x++){
			document.getElementById("facility"+x).disabled=true;
			document.getElementById("facility"+x).checked=false;
		}
		document.getElementById("information").innerHTML = '';makeblankroomlist();
	}
}


//the following function gets the infomation about the room selected and 
//puts it into a form which is submitted taking the user to the booking
//page where the room selected is already filled in

function bookroom(){
	document.getElementById('buildcodeH').value = document.getElementById('buildidselect').value
	document.getElementById('buildnameH').value = document.getElementById('buildnameselect').value
	document.getElementById('roomH').value = roomname
	document.getElementById('book').submit()
}


//the below function enables the popup help

function open_win(){
	myWindow=window.open('../helppages/availabilityhelp.html','','width=500,height=350');
	myWindow.focus();
}

</script>

</head>

<body onload='makeparklist();makebuildlist("All");makefacilites();makeblankroomlist();'>

<?php include '../shared/header2.php'; ?>

<div id="menu">
	<br/>
	<ul>
		<li><a href="../start.php">Home</a></li>
		<li><a href="../bookings/main.php">Make A Booking</a></li>
        <li class="current_page_item"><a href="main.php">Room Information / Availibility</a></li>		
        <li><a href="../roundinfo.php">Round Information</a></li>
		<li><a href="../summary/main.php">My Summary</a></li>
		<li><a href="../help.php">Contact / Help</a></li>
		<li><a href="../../login.php">Logout</a></li>
 	</ul>
</div>

<div id="roominfopage">
	<div id="content">
	<br>
	<strong><center><em>Room Information</em></center></strong>
	<div style='text-align:right;margin-right:20px'><a onclick="open_win()">If you need help with this page click here </a></div>
		<br>
		<div id = 'roomselect'>
			<div style = "float: left; border: 1px solid; margin-left:8px;margin-right: 5px" id='parks'></div>
			<div style = "float: left; border: 1px solid; margin-right: 5px" id="builds">
				<div style = "float: left;" id='buildcodes'></div>
				<div style = "float: left;" id='buildnames'></div>
			</div>
		<div style = "float: left; border: 1px solid; margin-right: 10px"  id='rooms'></div>
	</div>
	<div id="facilities"></div>
	<div id = 'information'></div>
	</div>
</div>

<form method="post" id="book" name="book" action="../bookings/main.php">
	<input type="hidden" value="" name="buildcodeH" id="buildcodeH">
	<input type="hidden" value="" name="buildnameH" id="buildnameH">
	<input type="hidden" value="" name="roomH" id="roomH">
</form>

<div id="footer">
	<p>Loughborough University Computer science Group 13</p>
</div>

<div id='update'></div>

</body>
</html>