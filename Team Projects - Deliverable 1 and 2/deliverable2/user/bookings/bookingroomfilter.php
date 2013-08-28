<!--this script takes the sql statement and returns the appropiate rooms in
a record written by Peter Krepa--!>
<script type='text/javascript'> 
var roomrecord1 = [];
<?php
	$myconn2=mysql_connect("co-project.lboro.ac.uk",team13,b7c8pbvc);
	mysql_select_db("team13",$myconn2);
	$roomSQL = $_REQUEST['sql'];
   	$result2=mysql_query($roomSQL, $myconn2);
	$count = 0;
	while($row=mysql_fetch_array($result2)){
		echo 'var record={} ; ';
		echo 'record.roomid="'.$row["RoomID"].'" ; ';
		$newSQL="SELECT FacilityID FROM RoomFacility WHERE RoomID='".$row["RoomID"]."' ";
		$newresult=mysql_query($newSQL, $myconn2);
		$x = 0;
		echo 'facilitytemp = [] ; ';
		while($newrow=mysql_fetch_array($newresult)){
			echo 'facilitytemp['.$x.'] = '.$newrow['FacilityID'].' ; ';
			$x++;}		
		echo 'record.facility=facilitytemp ; ';
		echo 'roomrecord1['.$count.']=record ; ';
		$count++;};

?>

parent.makeroomsuggestion(roomrecord1)
</script>
