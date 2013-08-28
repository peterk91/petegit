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

///////RECORD LAYOUT IS LIKE    record.date   .moduleid .nostudents  .rooms[array of roomnos]
////// .facilities[array of facs]     .time[array of records {.week,.day,.period}]  .reqid


function makependingrecords(){
<?php include 'php/pendingSQL.php';?>}

function makeallocatedrecords(){
<?php include 'php/allocatedSQL.php';?>}

function makedeniedarray(){
<?php include 'php/deniedSQL.php';?>}

var weeks = 15;
var dayarray = ["Mon","Tue","Wed","Thu","Fri"];
var periods = 9;
var times = ["9am-<br>10am","10am-<br>11am","11am-<br>12pm","12pm-<br>1pm","1pm-<br>2pm","2pm-<br>3pm","3pm-<br>4pm","4pm-<br>5pm","5pm-<br>6pm"];

function maketable(){
	var strtt = '<table id="timetable">';
	strtt += '<tr><td style="border: 0px" colspan = "2"> Week: <select onchange="changeweek(this.value)" size = "1">';
	for(i=1;i<=weeks;i++) strtt += '<option>'+i+'</option>'
	strtt += '</select></td></tr>';
	strtt += '<tr><th>Period:</th>';
	for(i=1;i<=periods;i++) strtt += '<th>'+i+'</th>';
	strtt += '</tr><tr><th>Times:</th>'
	for(i=0;i<times.length;i++) strtt += '<th>'+times[i]+'</th>';
	
	for(j=0;j<dayarray.length;j++){
		strtt += '</tr>';
		strtt += '<tr><th>'+dayarray[j]+'</th>';
		for(i=1;i<=periods;i++) strtt += '<td value="no" id="'+dayarray[j]+i+'"></td>';
	}
	
	strtt += '</tr></table>';
	document.getElementById("timetablediv").innerHTML = strtt;
	changeweek(1);
}

function changeweek(selectedWeek){
	$(document).ready(function(){$("#update").load("gettimetable.php", {searchuser:("AndyW"),searchweek: (selectedWeek)})});
}

function filltable(timesArray){
	for(j=0;j<dayarray.length;j++) for(i=1;i<=periods;i++)document.getElementById(dayarray[j]+i).style.background = 'WHITE';
	
	for(i=0;i<timesArray.length;i++){
		if(timesrecord[i].week==selectedweek) document.getElementById(timesArray[i].day+timesArray[i].period).style.background = 'RED';
	}
}



</script>

</head>

<body onload='maketable()'>
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
		
		<div id="timetablediv">;
	</div>
</div>


<div id="footer">
<p>Loughborough University Computer science Group 13</p>
</div>

<div id='update'></div>

</body>
</html>
