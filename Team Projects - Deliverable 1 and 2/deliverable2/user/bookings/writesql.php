<!--written by Andrew Wallis, makes sql queries to database from an array of strings of sql in turn--!>
<script type='text/javascript'>
	<?php
		$strArray = $_REQUEST["stringArray"];
		$myconn2=mysql_connect("co-project.lboro.ac.uk",team13,b7c8pbvc);
		mysql_select_db("team13",$myconn2);
		foreach($strArray as $strSQL){
			mysql_query($strSQL, $myconn2);
		}		
	?>
parent.finishsubmit();
</script>
