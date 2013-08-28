//this script takes the previous variable sql, which has been written 
//previously using javascript according to the building selected and builds a record of the rooms needed. 
//It also is used to filter by the facilites selected.
//written by Peter Krepa

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
		echo 'record.buildingid="'.$row["BuildingID"].'" ; ';
		echo 'record.capacity="'.$row["Capacity"].'" ; ';
		echo 'record.imgurl="'.$row["ImageURL"].'" ; ';
		$newSQL="SELECT FacilityID FROM RoomFacility WHERE RoomID='".$row["RoomID"]."' ORDER BY FacilityID ";
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
parent.makeroomlist(roomrecord1) //the record is then passed back to the parent and the new roomlist is made
</script>
