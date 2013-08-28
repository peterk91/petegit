var part = [];
var mod = [];

<?php
	$myconn2=mysql_connect("co-project.lboro.ac.uk",team13,b7c8pbvc);
	mysql_select_db("team13",$myconn2);
	
	$strSQL="SELECT DISTINCT Part FROM Module INNER JOIN Request ON Module.ModuleID=Request.ModuleID WHERE Request.UserID = 'AndyW' ORDER BY Part";
	$result2=mysql_query($strSQL, $myconn2);
	$count = 0;
	while($row=mysql_fetch_array($result2)){
		echo 'part['.$count.']="'.$row["Part"].'";';
		$count++;
	}
	?>