<?php
	$parkSQL="SELECT DISTINCT Park FROM Building";
	$myconn2=mysql_connect("co-project.lboro.ac.uk",team13,b7c8pbvc);
	mysql_select_db("team13",$myconn2);
   	$result2=mysql_query($parkSQL, $myconn2);
	$count = 0;
	while($row=mysql_fetch_array($result2)){
		echo 'parks['.$count.'] = "'.$row["Park"].'" ; ';
		$count++;}
?>