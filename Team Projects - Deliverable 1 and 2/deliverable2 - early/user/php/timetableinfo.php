<script type='text/javascript'> 

var timesrecord = [];
<?php
	$roomid = $_REQUEST['roomid'];
	$myconn2=mysql_connect("co-project.lboro.ac.uk",team13,b7c8pbvc);
	mysql_select_db("team13",$myconn2);
	$stateSQL = 'SELECT * FROM RequestTime INNER JOIN Allocation ON RequestTime.RequestID=Allocation.RequestID WHERE RequestTime.RequestID IN(SELECT RequestID FROM RequestRoom WHERE RoomID = "'.$roomid.'")';
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

parent.maketable(timesrecord)

</script>