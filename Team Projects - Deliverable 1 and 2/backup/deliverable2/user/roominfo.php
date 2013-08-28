<html>
<?php include 'php/usercheck.php'; ?>
<head>
<title>Loughborough University Room Booking System</title>
<link href="../style.css" rel="stylesheet" type="text/css"/>
<script src='http://ajax.microsoft.com/ajax/jquery/jquery-1.5.min.js' type='text/javascript'></script>
<script type='text/javascript'>

var parks = [];
var buildrecord = [];
var facility = [];
var buildnameslist = [];
var buildcodeslist = [];
var roomrecord=[];
var timesrecord = [];
var noFacilites = '';
var roomname = ''

function makeparkrecords(){
<?php include 'php/parkSQL.php';?>}

function makebuildingrecords(){
<?php include 'php/buildSQL.php';?>}

function makefacilityarray(){
<?php include 'php/facilitySQL.php';?>}


function makeparklist(){
	var select = '<select size = "18" name="parkselect" id="parkselect" onchange = "makebuildlist(this.value);makeblankroomlist()" style="width: 50px" >'	
	select += '<option value="All" selected>All</option>'	
	for(i=0;i<parks.length;i++)
		{
		select += '<option value="'+parks[i]+'">'+parks[i]+'</option>'
		}	
	select += '</select>'
	document.getElementById("parks").innerHTML = select
	}


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

function changebuildid(chsnbuild){
	for(x=0;x<buildrecord.length;x++){
		if(buildrecord[x].name == chsnbuild){buildno = x; var newbuildcode = buildrecord[x].buildingid}}
	for(x=0;x<buildcodeslist.length;x++){
		if(buildcodeslist[x]==newbuildcode){document.getElementById('buildidselect').selectedIndex = x}}
		document.getElementById("information").innerHTML = '';}

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

function makeblankroomlist(){
	var list = '<select size = "18" style="width: 85px" >'	
	list += '</select>'
	document.getElementById("rooms").innerHTML = list;	
	}
	
function makeroomlist(x){
	roomrecord = x
	var select = '<select size = "18" id="roomselect" onchange="(makeroominfo(this.value))" style="width: 85px" >'
	for (i=0;i<roomrecord.length;i++){
			select += '<option value="'+roomrecord[i].roomid+'">'+roomrecord[i].roomid+'</option>'			
			}
	select += '</select>'
	document.getElementById("rooms").innerHTML = select;
}

function updateall(){
	total = document.getElementById('type').selectedIndex+document.getElementById('style').selectedIndex+3
	var writeSQL = 'SELECT * FROM Room WHERE RoomID IN(SELECT RoomID FROM RoomFacility WHERE '
	writeSQL += ' FacilityID = "'+document.getElementById('type').selectedIndex+'" '
	writeSQL += ' OR FacilityID = "'+(document.getElementById('style').selectedIndex+3)+'" '
	for(x=5;x<noFacilities;x++){
	if(document.getElementById('facility'+x).checked==true){
		writeSQL += ' OR FacilityID = "'+x+'" '
		total = parseInt(total)+x
	}}
	writeSQL += ' GROUP BY RoomID HAVING SUM(FacilityID)='+total+')'
	$(document).ready(function(){$("#update").load("roomFilter.php", {sql: writeSQL})});
}


function makeroominfo(chosen)
	{
	for(i=0;i<roomrecord.length;i++)
		{
		if(roomrecord[i].roomid==chosen){var roomno = i}}
	for(x=0;x<buildrecord.length;x++){
		if(roomrecord[roomno].buildingid == buildrecord[x].buildingid){var buildingno = x}}
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
	for(x=2;x<fac.length;x++)
		{
		if(x>2 && Math.round((x)/2) == ((x)/2)){info += '<tr><th></th>'}
		info += '<td>'+facility[(fac[x])]+'</td>'
		if(Math.round((x-1)/2) == ((x-1)/2)){info += '</tr>'}
		}
	info += "</table></div>"
	info += "<div id='infobottom'>"
	info += "<input type='button' onclick='bookroom()' value='Book this room' /><div id=avali></div></div></div>"
	document.getElementById("information").innerHTML = info;
	$(document).ready(function(){$("#update").load("php/timetableinfo.php", {roomid: roomrecord[roomno].roomid})});
	}



function maketable(x){
timesrecord = x
var weeks = 15;
var dayarray = ["Mon","Tue","Wed","Thu","Fri"];
var periods = 9;
var times = ["9am-<br>10am","10am-<br>11am","11am-<br>12pm","12pm-<br>1pm","1pm-<br>2pm","2pm-<br>3pm","3pm-<br>4pm","4pm-<br>5pm","5pm-<br>6pm"];


	var strtt = '<table id="avali">'

	strtt += '<tr><td style="border: 0px" colspan = "2"> Week: <select onchange="fillweek(this.value)" size = "1">'
	for(i=1;i<=weeks;i++){strtt += '<option>'+i+'</option>'}
	strtt += '</select></td></tr>'
	strtt += '<tr><th>Period:</th>';
	for(i=1;i<=periods;i++) strtt += '<th>'+i+'</th>';
	strtt += '</tr><tr><th>Times:</th>'
	for(i=0;i<times.length;i++) strtt += '<th>'+times[i]+'</th>';

	
	for(j=0;j<dayarray.length;j++){
		strtt += '</tr>';
		strtt += '<tr><th>'+dayarray[j]+'</th>';
		for(i=1;i<=periods;i++) strtt += '<td value="no" id="'+dayarray[j]+i+'" onclick="select(this.id)"></td>';
	}

	strtt += '</tr></table>';


	document.getElementById("avali").innerHTML = strtt;
	fillweek('1')
}

function fillweek(x){

var dayarray = ["Mon","Tue","Wed","Thu","Fri"];
var periods = 9;

	for(j=0;j<dayarray.length;j++){
		for(i=1;i<=periods;i++){document.getElementById(dayarray[j]+i).style.background = 'WHITE'}}

	for(c=0;c<timesrecord.length;c++){
	if(timesrecord[c].week==x){
	document.getElementById(timesrecord[c].day+timesrecord[c].period).style.background = 'RED'}}


}



function update(){
	$(document).ready(function(){$("#update").load("roomlist.php", {var1: (document.getElementById("buildidselect").value), var2:(document.getElementById("buildnameselect").value) })});
	}

function makefacilites(){
	var list = '<strong><u><em>Choose Advance Filter Options: </em></u></strong>ON:<input type="radio" name="filter" onchange="changefilter(this.value)" id="filter" value="ON"/> OFF:<input type="radio" checked onchange="changefilter(this.value)" name="filter" id="filter" value="OFF"/><table id ="facilitytable">'
	list += '<tr><th>Room Type: </th><td colspan="3"><select onchange="updateall(this.value)" id="type" name="type" size="1"><option value="facility0">'+facility[0]+'</option><option value="facility1">'+facility[1]+'</option><option value="facility2">'+facility[2]+'</option></select></td></tr>'	
	list += '<tr><th>Room Style: </th><td colspan="3"><select onchange="updateall(this.value)" id="style" name="style" size="1"><option value="facility3">'+facility[3]+'</option><option value="facility4">'+facility[4]+'</option></select></td></tr>'	
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
		for(x=5;x<facility.length;x++){
		document.getElementById("facility"+x).disabled=false;
		}document.getElementById("information").innerHTML = '';updateall()}
	if(option=='OFF'){
		document.getElementById("parkselect").disabled=false;
		document.getElementById("buildidselect").disabled=false;
		document.getElementById("buildnameselect").disabled=false;
		document.getElementById("parkselect").selectedIndex=0;
		document.getElementById("type").disabled=true;
		document.getElementById("type").selectedIndex=0;
		document.getElementById("style").disabled=true;
		document.getElementById("style").selectedIndex=0;
		for(x=5;x<facility.length;x++){
		document.getElementById("facility"+x).disabled=true;
		document.getElementById("facility"+x).checked=false;
		}
		document.getElementById("information").innerHTML = '';makeblankroomlist();}}


function bookroom(){
document.getElementById('buildcodeH').value = document.getElementById('buildidselect').value
document.getElementById('buildnameH').value = document.getElementById('buildnameselect').value
document.getElementById('roomH').value = roomname
book.submit()

}

</script>


</head>

<body onload='makeparkrecords();makebuildingrecords();makefacilityarray();makeparklist();makebuildlist("All");makefacilites();makeblankroomlist();'>

<?php include 'php/header.php'; ?>

<div id="menu">
		<br>
		<ul>
			<li><a href="start.php">Home</a></li>
			<li><a href="bookings.php">Make A Booking</a></li>
        	<li class="current_page_item"><a href="roominfo.php">Room Information / Availibility</a></li>		
        	<li><a href="roundinfo.php">Round Information</a></li>
			<li><a href="summary.php">My Summary</a></li>
			<li><a href="help.php">Contact / Help</a></li>
			<li><a href="../login.php">Logout</a></li>
 		</ul>
</div>


<div id="roominfopage">
	<div id="content">
		<p align="center"><strong><em>Room Information</em></strong></p>
		
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

<form method="post" id="book" name="book" action="bookings.php">
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
