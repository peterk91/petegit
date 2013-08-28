//this script put all the information about buildings in a selected park
//and puts them into a record. Written By Peter Krepa

<?php
	$buildSQL="SELECT * FROM Building ORDER BY BuildingID";
	$myconn2=mysql_connect("co-project.lboro.ac.uk",team13,b7c8pbvc);
	mysql_select_db("team13",$myconn2);
   	$result2=mysql_query($buildSQL, $myconn2);
	$count = 0;
	while($row=mysql_fetch_array($result2)){
		echo 'var record={} ; ';
		echo 'record.name="'.$row["Name"].'" ; ';
		echo 'record.buildingid="'.$row["BuildingID"].'" ; ';
		echo 'record.park="'.$row["Park"].'" ; ';
		echo 'buildrecord['.$count.']=record ; ';
		$count++;}
?>