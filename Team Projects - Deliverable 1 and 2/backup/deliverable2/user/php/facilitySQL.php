	<?php
	$myconn2=mysql_connect("co-project.lboro.ac.uk",team13,b7c8pbvc);
	mysql_select_db("team13",$myconn2);
	$facilitySQL="SELECT * FROM Facility";
   	$result2=mysql_query($facilitySQL, $myconn2);
	$count = 0;
	while($row=mysql_fetch_array($result2)){
		echo 'facility['.$count.'] = "'.$row["Name"].'" ; ';
		$count++;}
	?>