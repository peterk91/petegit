<?php

if($_REQUEST['filter']=='ON'){
	echo "var prevfilter = '".$_REQUEST['filter']."'; ";
	echo "var prevtype = '".$_REQUEST['type']."'; ";
	echo "var prevstyle = '".$_REQUEST['style']."'; ";
	echo 'var checkedfacility=[] ; ';
	$total = $_REQUEST['hiddentotalfacilites'];
	$counter=5;
	$roomSQL2 = '';
	while($counter<$total){
		echo 'checkedfacility['.$counter.'] = "'.$_REQUEST[('facility'.$counter)].'" ; ';
		if($_REQUEST[('facility'.$counter)]=='on'){$roomSQL2 = $roomSQL2.' AND RoomFacility.FacilityID = "'.$counter.'" ';}
		$counter++;}
	$parkSQL="SELECT DISTINCT Park FROM Building";
	$buildSQL="SELECT * FROM Building";
	$roomSQL="SELECT DISTINCT Room.RoomID, Room.BuildingID, Room.Capacity, Room.ImageURL FROM Room RIGHT JOIN RoomFacility ON Room.RoomID=RoomFacility.RoomID WHERE Room.BuildingId = '".$_REQUEST['buildidselect']."' ".$roomSQL2;}

else{
	echo "var prevtype = ''; ";
	echo "var prevstyle = ''; ";
	$parkSQL="SELECT DISTINCT Park FROM Building";
	$buildSQL="SELECT * FROM Building";
	$roomSQL="SELECT * FROM Room WHERE BuildingId = '".$_REQUEST['buildidselect']."' ";
	echo "var prevfilter = 'OFF'; ";};
?>