<!--written by Andrew Wallis, gets id of most recent request and returns using parent function--!>
<script type='text/javascript'>
var lastID = 0;
	<?php
			$myconn2=mysql_connect("co-project.lboro.ac.uk",team13,b7c8pbvc);
			mysql_select_db("team13",$myconn2);
			$strSQL="SELECT RequestID FROM Request WHERE (RequestID= (select MAX(RequestID) ))";
			$result2=mysql_query($strSQL, $myconn2);
			while($row=mysql_fetch_array($result2)){
				echo 'lastID="'.$row["RequestID"].'" ; ';
			}
	?>
	parent.passlastReqID(lastID);
</script>