//This script makes an array of records of all the denied requests for the user.
//it stores all the information required for the user to manipulate the requests
//Written by Peter Krepa

<?php	session_start();
	$myconn2=mysql_connect("co-project.lboro.ac.uk",team13,b7c8pbvc);
	mysql_select_db("team13",$myconn2);
	$stateSQL = 'SELECT * FROM Request WHERE UserID = "'.$_SESSION['systemlogged1'].'" AND RequestID IN(SELECT RequestID FROM Denied) '.$sem.' '.$round.' ORDER BY Date DESC';	$result2=mysql_query($stateSQL, $myconn2);
	$count=0;
	while($row=mysql_fetch_array($result2)){
		echo 'var record={} ; ';
		echo 'record.reqid="'.$row["RequestID"].'" ; ';
		echo 'record.date="'.$row["Date"].'" ; ';
		echo 'record.moduleid="'.$row["ModuleID"].'" ; ';
		echo 'record.nostudents="'.$row["NoStudents"].'" ; ';
		echo 'var rooms = [] ; ';
		$count2 = 0;
		$stateSQL2 = 'SELECT RoomID FROM RequestRoom WHERE RequestID = "'.$row["RequestID"].'"';
		$result3=mysql_query($stateSQL2, $myconn2);
		while($row2=mysql_fetch_array($result3)){echo 'rooms['.$count2.']="'.$row2["RoomID"].'" ; ';$count2++;}
		echo 'record.rooms=rooms ; ';

		echo 'var fac = [] ; ';
		$count2 = 0;
		$stateSQL3 = 'SELECT FacilityID FROM RequestFacility WHERE RequestID = "'.$row["RequestID"].'"';
		$result4=mysql_query($stateSQL3, $myconn2);
		while($row3=mysql_fetch_array($result4)){echo 'fac['.$count2.']="'.$row3["FacilityID"].'" ; ';$count2++;}
		echo 'record.facilities=fac ; ';

		echo 'var time = [] ; ';
		$count2 = 0;
		$stateSQL4 = 'SELECT * FROM RequestTime WHERE RequestID = "'.$row["RequestID"].'"';
		$result5=mysql_query($stateSQL4, $myconn2);
		while($row4=mysql_fetch_array($result5)){
		echo ' var time1={} ; ';
		echo 'time1.week="'.$row4["Week"].'" ; ';
		echo 'time1.day="'.$row4["Day"].'" ; ';
		echo 'time1.period="'.$row4["Period"].'" ; ';
		echo 'time['.$count2.']= time1 ; ';
		$count2++;
		}
		echo 'record.time=time ; ';

		$name = 'SELECT Name FROM Module WHERE ModuleID = "'.$row["ModuleID"].'"';
		$resultn=mysql_query($name, $myconn2);
		while($row=mysql_fetch_array($resultn)){echo 'record.name="'.$row["Name"].'" ; ';}

		echo 'deniedrecord['.$count.']=record ; ';
		$count++;};

?>