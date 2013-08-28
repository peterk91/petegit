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

<?php include 'php/pendingSQL.php';?>

<?php include 'php/allocatedSQL.php';?>

<?php include 'php/deniedSQL.php';?>

function maketable(){

var tabhtml = "<table id='summarytable'><tr><th>Date Submitted</th><th>Module ID</td><th>Number of Students</th><th>Rooms Requested</th><th>Facilities Requested</th><th>Weeks Requested</th></tr><tr><td>&nbsp;</td></tr>"

for(x=0;x<allocatedrecord.length;x++)
	{
	tabhtml +='<tr><td>'+allocatedrecord[x].date+'</td><td>'+allocatedrecord[x].moduleid+'</td><td>'+allocatedrecord[x].nostudents+'</td><td>'
	if(allocatedrecord[x].rooms.length==0){tabhtml += 'Any'}else{for(y=0;y<allocatedrecord[x].rooms.length;y++){tabhtml += allocatedrecord[x].rooms[y]}}
	tabhtml += '</td><td>'
	if(allocatedrecord[x].facilities.length==0){tabhtml += 'None'}else{for(y=0;y<allocatedrecord[x].facilities.length;y++){tabhtml += allocatedrecord[x].facilities[y]}}

	tabhtml += '</td><td>TIMES</td><td></tr></table>'
	}





document.getElementById('sumtable').innerHTML = tabhtml

}




</script>






</head>

<body onload="maketable()">
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




<div id='sumtable'></div>


	</div>
</div>


<div id="footer">
<p>Loughborough University Computer science Group 13</p>
</div>

</body>
</html>
