<!--written by Andrew Wallis, gets information about a particular request and returns via parent function--!>
<script type='text/javascript'>
<?php
		if($_REQUEST['passreqid']){
				$myconn2=mysql_connect("co-project.lboro.ac.uk",team13,b7c8pbvc);
				mysql_select_db("team13",$myconn2);
				$stateSQL = 'SELECT * FROM Request WHERE RequestID ="'.$_REQUEST['passreqid'].'"';
				$result2=mysql_query($stateSQL, $myconn2);
				while($row=mysql_fetch_array($result2)){
					echo 'var editround_id="'.$row["RoundID"].'";';
					echo 'var editrooms = [];';
					$count2 = 0;
					$stateSQL2 = 'SELECT RoomID FROM RequestRoom WHERE RequestID = "'.$_REQUEST['passreqid'].'"';
					$result3=mysql_query($stateSQL2, $myconn2);
					while($row2=mysql_fetch_array($result3)){
						echo 'editrooms['.$count2.']="'.$row2["RoomID"].'";';
						$count2++;
					}

					echo 'var editfacilities = [];';
					$count2 = 0;
					$stateSQL3 = 'SELECT FacilityID FROM RequestFacility WHERE RequestID = "'.$_REQUEST['passreqid'].'"';
					$result4=mysql_query($stateSQL3, $myconn2);
					while($row3=mysql_fetch_array($result4)){
						echo 'editfacilities['.$count2.']="'.$row3["FacilityID"].'";';
						$count2++;
					}


					echo 'var edittime = [];';
					$count2 = 0;
					$stateSQL4 = 'SELECT * FROM RequestTime WHERE RequestID = "'.$_REQUEST['passreqid'].'"';
					$result5=mysql_query($stateSQL4, $myconn2);
					while($row4=mysql_fetch_array($result5)){
						echo 'var time1={} ; ';
						echo 'time1.week="'.$row4["Week"].'";';
						echo 'time1.day="'.$row4["Day"].'";';
						echo 'time1.period="'.$row4["Period"].'";';
						echo 'edittime['.$count2.']= time1;';
						$count2++;
					}
				}
		}
	?>
	parent.passedit(editround_id,editrooms,edittime,editfacilities);
</script>