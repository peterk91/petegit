<html>
<?php include 'php/usercheck.php'; ?>
<head>
<title>Loughborough University Room Booking System</title>
<link href="../style.css" rel="stylesheet" type="text/css"/>
<script src='http://ajax.microsoft.com/ajax/jquery/jquery-1.5.min.js' type='text/javascript'></script>
<script type='text/javascript'>

pendingrecord = [];
allocatedrecord = [];
deniedrecord = [];
var facility = [];
var noWeeks = 15;

///////RECORD LAYOUT IS LIKE    record.date   .moduleid .nostudents  .rooms[array of roomnos]
////// .facilities[array of facs]     .time[array of records {.week,.day,.period}]  .reqid

<?php include 'php/pendingSQL.php';?>

<?php include 'php/allocatedSQL.php';?>

<?php include 'php/deniedSQL.php';?>

<?php include 'php/facilitySQL.php';?>

function orderby(v,y){

if (v=='Date'){x="Date DESC"};
if (v=='ModuleID'){x="ModuleID"}
if (v=='NoStu'){x="NoStudents"}

if (y=='table1'){rec= 'pendingrecord'; z='SELECT * FROM Request WHERE UserID = "AndyW" AND RequestID NOT IN(SELECT RequestID FROM Denied) AND RequestID NOT IN(SELECT RequestID FROM Allocation) ORDER BY '+x}

if (y=='table2'){;rec='allocatedrecord';z='SELECT * FROM Request WHERE UserID = "AndyW" AND RequestID IN(SELECT RequestID FROM Allocation) ORDER BY '+x}

if (y=='table3'){;rec='deniedrecord';z='SELECT * FROM Request WHERE UserID = "AndyW" AND RequestID IN(SELECT RequestID FROM Denied) ORDER BY '+x}

$(document).ready(function(){$("#update").load("php/orderbySQL.php", {sql: z, table: y})});

}

function makenewtable(newrecord,table){

if (table=='table1'){pendingrecord = newrecord}
if (table=='table2'){allocatedrecord= newrecord}
if (table=='table3'){deniedrecord= newrecord}

maketable(table)

}

function maketable(x){

if (x=='table1'){

var date1= "'Date'"
var mod1= "'ModuleID'"
var nos1= "'NoStu'"
var table = "'table1'"

tabhtml ='<input type="button" value="Order By Date" onclick="orderby('+date1+','+table+')" /> 	&nbsp; 	&nbsp;'
tabhtml +='<input type="button" value="Order By ModuleID" onclick="orderby('+mod1+','+table+')" /> 	&nbsp; 	&nbsp;'
tabhtml +='<input type="button" value="Order By Number of Students" onclick="orderby('+nos1+','+table+')" /><br><br>'

tabhtml += "<table id='pending'><tr><th>Date Submitted</th><th>Module ID</td><th>Number of Students</th><th>Rooms Requested</th><th>Facilities Requested</th><th>Weeks Requested</th><th></th></tr>"

for(x=0;x<pendingrecord.length;x++)
	{
	tabhtml +='<tr><td>'+pendingrecord[x].date+'</td><td>'+pendingrecord[x].moduleid+'</td><td>'+pendingrecord[x].nostudents+'</td><td>'
	if(pendingrecord[x].rooms.length==0){tabhtml += 'Any'}else{for(y=0;y<pendingrecord[x].rooms.length;y++){tabhtml += pendingrecord[x].rooms[y]}}
	tabhtml += '</td><td>'
	if(pendingrecord[x].facilities.length==0){tabhtml += 'None'}else{for(y=0;y<pendingrecord[x].facilities.length;y++){tabhtml += facility[pendingrecord[x].facilities[y]]+", "}}
	tabhtml += '</td><td>'

	var weeks = [];
	for(z=0;z<(pendingrecord[x].time.length);z++){
		var found = false;
		for(d=0;d<weeks.length;d++){
			if(pendingrecord[x].time[z].week == weeks[d]) found = true;
		}
		if(!found) weeks[weeks.length] = pendingrecord[x].time[z].week;
	}
	weeks.sort(function(a,b){return a - b})
	for(g=0;g<weeks.length;g++){tabhtml += weeks[g]+", "}
tabhtml += '</td><th> View More Info </th></tr>'
	
	}

tabhtml +='</table>'
document.getElementById('table1').innerHTML = tabhtml

}



if (x=='table2'){

var date1= "'Date'"
var mod1= "'ModuleID'"
var nos1= "'NoStu'"
var table = "'table2'"

tabhtml ='<input type="button" value="Order By Date" onclick="orderby('+date1+','+table+')" /> 	&nbsp; 	&nbsp;'
tabhtml +='<input type="button" value="Order By ModuleID" onclick="orderby('+mod1+','+table+')" /> 	&nbsp; 	&nbsp;'
tabhtml +='<input type="button" value="Order By Number of Students" onclick="orderby('+nos1+','+table+')" /><br><br>'

tabhtml += "<table id='allocated'><tr><th>Date Submitted</th><th>Module ID</td><th>Number of Students</th><th>Rooms Requested</th><th>Facilities Requested</th><th>Weeks Requested</th><th></th></tr>"

for(x=0;x<allocatedrecord.length;x++)
	{
	tabhtml +='<tr><td>'+allocatedrecord[x].date+'</td><td>'+allocatedrecord[x].moduleid+'</td><td>'+allocatedrecord[x].nostudents+'</td><td>'
	if(allocatedrecord[x].rooms.length==0){tabhtml += 'Any'}else{for(y=0;y<allocatedrecord[x].rooms.length;y++){tabhtml += allocatedrecord[x].rooms[y]}}
	tabhtml += '</td><td>'
	if(allocatedrecord[x].facilities.length==0){tabhtml += 'None'}else{for(y=0;y<allocatedrecord[x].facilities.length;y++){tabhtml += facility[allocatedrecord[x].facilities[y]]+", "}}
	tabhtml += '</td><td>'

	var weeks = [];
	for(z=0;z<(allocatedrecord[x].time.length);z++){
		var found = false;
		for(d=0;d<weeks.length;d++){
			if(allocatedrecord[x].time[z].week == weeks[d]) found = true;
		}
		if(!found) weeks[weeks.length] = allocatedrecord[x].time[z].week;
	}
	weeks.sort(function(a,b){return a - b})
	for(g=0;g<weeks.length;g++){tabhtml += weeks[g]+", "}
tabhtml += '</td><th> View More Info </th></tr>'
	
	}

tabhtml +='</table>'
document.getElementById('table2').innerHTML = tabhtml

}


if (x=='table3'){

var date1= "'Date'"
var mod1= "'ModuleID'"
var nos1= "'NoStu'"
var table = "'table3'"

tabhtml ='<input type="button" value="Order By Date" onclick="orderby('+date1+','+table+')" /> 	&nbsp; 	&nbsp;'
tabhtml +='<input type="button" value="Order By ModuleID" onclick="orderby('+mod1+','+table+')" /> 	&nbsp; 	&nbsp;'
tabhtml +='<input type="button" value="Order By Number of Students" onclick="orderby('+nos1+','+table+')" /><br><br>'


tabhtml += "<table id='denied'><tr><th>Date Submitted</th><th>Module ID</td><th>Number of Students</th><th>Rooms Requested</th><th>Facilities Requested</th><th>Weeks Requested</th><th></th></tr>"

for(x=0;x<deniedrecord.length;x++)
	{
	tabhtml +='<tr><td>'+deniedrecord[x].date+'</td><td>'+deniedrecord[x].moduleid+'</td><td>'+deniedrecord[x].nostudents+'</td><td>'
	if(deniedrecord[x].rooms.length==0){tabhtml += 'Any'}else{for(y=0;y<deniedrecord[x].rooms.length;y++){tabhtml += deniedrecord[x].rooms[y]}}
	tabhtml += '</td><td>'
	if(deniedrecord[x].facilities.length==0){tabhtml += 'None'}else{for(y=0;y<deniedrecord[x].facilities.length;y++){tabhtml += facility[deniedrecord[x].facilities[y]]+", "}}
	tabhtml += '</td><td>'

	var weeks = [];
	for(z=0;z<(deniedrecord[x].time.length);z++){
		var found = false;
		for(d=0;d<weeks.length;d++){
			if(deniedrecord[x].time[z].week == weeks[d]) found = true;
		}
		if(!found) weeks[weeks.length] = deniedrecord[x].time[z].week;
	}
	weeks.sort(function(a,b){return a - b})
	for(g=0;g<weeks.length;g++){tabhtml += weeks[g]+", "}
tabhtml += '</td><th> View More Info </th></tr>'
	
	}

tabhtml +='</table>'
document.getElementById('table3').innerHTML = tabhtml

}

}


viewhtml = ''

function changeview(x){

if(x=='timetable'){
$("#allsummary").load("tableview.php");
}

if(x=='list'){
$("#allsummary").load("listview.php");
}


}

$(document).ready(function(){$("#allsummary").load("listview.php")});

</script>





</head>

<body>
<?php include 'php/header.php'; ?>
<div id="menu">
		<BR>
		<ul>
			<li><a href="start.php">Home</a></li>
			<li><a href="bookings.php">Make A Booking</a></li>
        	<li><a href="roominfo.php">Room Information / Availibility</a></li>		
        	<li><a href="roundinfo.php">Round Information</a></li>
			<li class="current_page_item"><a href="summary.php">My Summary</a></li>
			<li><a href="help.php">Contact / Help</a></li>
			<li><a href="../login.php">Logout</a></li>
 		</ul>
</div>







<div id="summarypage">
	<div id="content">
		<p align="center"><strong><em>My Summary</em></strong></p>

<p><strong><em>Change View:</em></strong> List View<input onchange="changeview(this.value)" type="radio" value="list" name="type" id="type" checked/> Timetable View<input type="radio" value="timetable" onchange="changeview(this.value)"  name="type" id="type"/></p>


<div id="allsummary"></div>




	</div>
</div>







<div id="footer">
<p>Loughborough University Computer science Group 13</p>
</div>

<div id='update'></div>

</body>
</html>
