<!--written by Andrew Wallis, gets record of allocated records according to semester entered, returns using parent function--!>
<script type='text/javascript'>
var allocatedrecord = [];	
	<?php
		$userid = $_SESSION['systemlogged1'];
		$myconn2=mysql_connect("co-project.lboro.ac.uk",team13,b7c8pbvc);
		mysql_select_db("team13",$myconn2);
		$stateSQL = 'SELECT * FROM Request WHERE RequestID IN(SELECT RequestID FROM Allocation) AND RoundID IN(SELECT RoundID FROM RoundClosing WHERE SemesterID =  '.$_REQUEST['searchsemester'].')';
		$result2=mysql_query($stateSQL, $myconn2);
		$count=0;
		while($row=mysql_fetch_array($result2)){
			echo 'var record={} ; ';
			echo 'record.reqid="'.$row["RequestID"].'" ; ';
			echo 'var rooms = [] ; ';
			$count2 = 0;
			$stateSQL2 = 'SELECT RoomID FROM RequestRoom WHERE RequestID = "'.$row["RequestID"].'"';
			$result3=mysql_query($stateSQL2, $myconn2);
			while($row2=mysql_fetch_array($result3)){
				echo 'rooms['.$count2.']="'.$row2["RoomID"].'" ; ';$count2++;
			}
			echo 'record.rooms=rooms ; ';

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
			while($row=mysql_fetch_array($resultn)){
				echo 'record.name="'.$row["Name"].'" ; ';
			}

			echo 'allocatedrecord['.$count.']=record ; ';
			$count++;
		};
	?>
parent.passallocated(allocatedrecord);
</script>