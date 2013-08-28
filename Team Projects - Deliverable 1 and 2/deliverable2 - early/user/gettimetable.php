<script type='text/javascript'>
	var times = [];
	<?php
		$myconn2=mysql_connect("co-project.lboro.ac.uk",team13,b7c8pbvc);
		mysql_select_db("team13",$myconn2);
		
   		$strSQL="SELECT * FROM RequestTime INNER JOIN Request ON Request.RequestID=RequestTime.RequestID WHERE Request.UserID = '".$_REQUEST['searchuser']."' AND  RequestTime.Week = '".$_REQUEST['searchweek']."';";
		$result2=mysql_query($strSQL, $myconn2);
		$count = 0;
		while($row=mysql_fetch_array($result2)){
			echo 'var record={} ; ';
			echo 'record.id="'.$row["RequestID"].'" ; ';
			echo 'record.day="'.$row["Day"].'" ; ';
			echo 'record.period="'.$row["Period"].'" ; ';
			echo 'time['.$count.']=record ; ';
			$count++;
		}
	?>
	parent.filltable(times);
</script>