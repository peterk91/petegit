<!--this script makes a record of all the bookings for a particular room which 
has been selected which is then used to create a table
Written by Peter Krepa and then added to by Andrew Wallis to make it work for various semsters--!>

<script type='text/javascript'> 

var timesrecord = [];

<?php
	$roomid = $_REQUEST['roomid'];
	$myconn2=mysql_connect("co-project.lboro.ac.uk",team13,b7c8pbvc);
	mysql_select_db("team13",$myconn2);
	$stateSQL = 'SELECT * FROM RequestTime INNER JOIN Allocation ON RequestTime.RequestID=Allocation.RequestID WHERE RequestTime.RequestID IN(SELECT RequestID FROM RequestRoom WHERE RoomID = "'.$roomid.'") AND RequestTime.RequestID IN(SELECT RequestID FROM Request WHERE RoundID IN(SELECT RoundID FROM RoundClosing WHERE SemesterID = '.$_REQUEST['searchsemester'].'))';
   	$result2=mysql_query($stateSQL, $myconn2);
	$count=0;
	while($row=mysql_fetch_array($result2)){
		echo 'var record={} ; ';
		echo 'record.week="'.$row["Week"].'" ; ';
		echo 'record.day="'.$row["Day"].'" ; ';
		echo 'record.period="'.$row["Period"].'" ; ';
		echo 'timesrecord['.$count.']=record ; ';
		$count++;};

?>

parent.filltable(timesrecord);

</script>