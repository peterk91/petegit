<html>
<body>
<script type='text/javascript'>
	<?php
		$strSQL = $_REQUEST["instringSQL"];
		$myconn2=mysql_connect("co-project.lboro.ac.uk",team13,b7c8pbvc);
		mysql_select_db("team13",$myconn2);
		mysql_query($strSQL, $myconn2);
	?>
	parent.submitroomfac();
</script>
</body>
</html>