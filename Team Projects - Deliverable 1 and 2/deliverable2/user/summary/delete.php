<!--this script deletes a request from the request table using a previously
written sql statement
written by Andrew Wallis--!>

<script type='text/javascript'>
	<?php
		$strArray = $_REQUEST["stringArray"];
		$myconn2=mysql_connect("co-project.lboro.ac.uk",team13,b7c8pbvc);
		mysql_select_db("team13",$myconn2);
		foreach($strArray as $strSQL){
			mysql_query($strSQL, $myconn2);
		}		
	?>
parent.finishdelete();
</script>