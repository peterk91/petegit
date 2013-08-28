<script type='text/javascript' src='../shared/jquery.js'></script>
<script type='text/javascript'>

//this script contains the coding for when a request is viewed
//Written by Andrew Wallis and styled by Peter Krepa

//the information about the request comes from the php below

<?php	session_start();
	$myconn2=mysql_connect("co-project.lboro.ac.uk",team13,b7c8pbvc);
	mysql_select_db("team13",$myconn2);
	$stateSQL = 'SELECT * FROM Request WHERE UserID = "'.$_SESSION['systemlogged1'].'" AND RequestID ="'.$_REQUEST['a'].'"';
	$result2=mysql_query($stateSQL, $myconn2);
	while($row=mysql_fetch_array($result2)){
		echo 'var round_id="'.$row["RoundID"].'" ; ';
		echo 'var reqid="'.$row["RequestID"].'" ; ';
		echo 'var date="'.$row["Date"].'" ; ';
		echo 'var moduleid="'.$row["ModuleID"].'" ; ';
		echo 'var nostudents="'.$row["NoStudents"].'" ; ';
		echo 'var rooms = [] ; ';
		$count2 = 0;
		$stateSQL2 = 'SELECT RoomID FROM RequestRoom WHERE RequestID = "'.$_REQUEST['a'].'"';
		$result3=mysql_query($stateSQL2, $myconn2);
		while($row2=mysql_fetch_array($result3)){echo 'rooms['.$count2.']="'.$row2["RoomID"].'" ; ';$count2++;}
		
		echo 'var facilities = [] ; ';
		$count2 = 0;
		$stateSQL3 = 'SELECT FacilityID FROM RequestFacility WHERE RequestID = "'.$_REQUEST['a'].'"';
		$result4=mysql_query($stateSQL3, $myconn2);
		while($row3=mysql_fetch_array($result4)){echo 'facilities['.$count2.']="'.$row3["FacilityID"].'" ; ';$count2++;}
		
		echo 'var time = [] ; ';
		$count2 = 0;
		$stateSQL4 = 'SELECT * FROM RequestTime WHERE RequestID = "'.$_REQUEST['a'].'"';
		$result5=mysql_query($stateSQL4, $myconn2);
		while($row4=mysql_fetch_array($result5)){
		echo ' var time1={} ; ';
		echo 'time1.week="'.$row4["Week"].'" ; ';
		echo 'time1.day="'.$row4["Day"].'" ; ';
		echo 'time1.period="'.$row4["Period"].'" ; ';
		echo 'time['.$count2.']= time1 ; ';
		$count2++;
		}

		$myconn2=mysql_connect("co-project.lboro.ac.uk",team13,b7c8pbvc);
		mysql_select_db("team13",$myconn2);
		$strSQL="SELECT * FROM Department INNER JOIN Module ON Module.DepartmentID=Department.DepartmentID WHERE Module.ModuleID ='".$row["ModuleID"]."'";
   		$result2=mysql_query($strSQL, $myconn2);
		$count = 0;
		while($row=mysql_fetch_array($result2)){
			echo 'var deptname = "'.$row["DepartmentName"].'"; ';
			echo 'var modname="'.$row["Name"].'"; ';
			echo 'var part="'.$row["Part"].'"; ';
		}

		};
		echo 'var theid='.$_REQUEST['a'].';';
		echo 'var pad='.$_REQUEST['b'].';';
?>

var facility = [];
var noWeeks = 15;
var viewid = 0;
var weeks = 15;
var dayarray = ["Mon","Tue","Wed","Thu","Fri"];
var periods = 9;
var times = ["9am-<br>10am","10am-<br>11am","11am-<br>12pm","12pm-<br>1pm","1pm-<br>2pm","2pm-<br>3pm","3pm-<br>4pm","4pm-<br>5pm","5pm-<br>6pm"];

<?php include '../shared/facilitySQL.php';?>

//when the edit request button is click the appropiate infomation is put into
//hidden fields and the form is submitted

function editrequest(){
	document.getElementById('roomAmount').value = rooms.length;
	document.getElementById('roundH').value = round_id;
	document.getElementById('departmentH').value = deptname;
	document.getElementById('modcodeH').value = moduleid;
	document.getElementById('modnameH').value = modname;
	document.getElementById('nostuH').value = nostudents;
	document.getElementById('passreqid').value = theid;
	document.getElementById('edit').submit();
}


//the infomation about the status of the request is determined below
//and adds and edit request button if the request is pending

function makereqinfo(){
	var strinfo ='<strong>Request Status: </strong>';
	if(pad == 0){
		strinfo += 'Pending <input type="button" value="Edit this Request" onClick="editrequest();"/>';
	}
	else if(pad == 1){
		strinfo += 'Allocated';
	}
	else{
		strinfo += 'Denied';
	}
	
	strinfo += '<br><br></br><strong>Department: </strong>'+deptname+'<br></br><strong>Module Code: </strong>'+moduleid+'<strong> Module Name: </strong>'+modname+'<strong> Part: </strong>'+part+'<br></br><strong>Number of Students: </strong>'+nostudents;
	document.getElementById("reqinfodiv").innerHTML = strinfo;
}


//the function below created the timetable for the selected request

function maketable(){
	var strtt = '<table id="specifictimetable">';
	strtt += '<tr style="height:25px;font-size:90%"><th>Period:</th>';
	for(i=1;i<=periods;i++) strtt += '<th>'+i+'</th>';
	strtt += '</tr><tr><th style="height:25px;font-size:90%">Times:</th>'
	for(i=0;i<times.length;i++) strtt += '<th  style="height:25px;font-size:75%">'+times[i]+'</th>';
	for(j=0;j<dayarray.length;j++){
		strtt += '</tr>';
		strtt += '<tr><th>'+dayarray[j]+'</th>';
		for(i=1;i<=periods;i++) strtt += '<td value="no" id="'+dayarray[j]+i+'"></td>';
	}
	strtt += '</tr></table>';
	document.getElementById("timetablediv").innerHTML = strtt;
	filltable();
}


//the below function fills the table with the relevant timing information

function filltable(){
	emptytable();
	for(i=0;i<time.length;i++){
		document.getElementById(time[i].day+time[i].period).style.background = 'BROWN';
	}
}


//the below function emptys the timetable

function emptytable(){
	for(j=0;j<dayarray.length;j++) for(i=1;i<=periods;i++)document.getElementById(dayarray[j]+i).style.background = 'WHITE';
}


//the below function creates a list of the weeks the request is for

function makeweeks(){
	var weeks = [];
	for(z=0;z<(time.length);z++){
		var found = false;
		for(d=0;d<weeks.length;d++){
			if(time[z].week == weeks[d]) found = true;
		}
		if(!found) weeks[weeks.length] = time[z].week;
	}
	weeks.sort(function(a,b){return a - b});
	if(weeks.length > 1){
		var strweeks = 'For weeks ';
		for(i=0;i<weeks.length-1;i++){
			strweeks += weeks[i]+', ';
		}
	strweeks = strweeks.substr(0,strweeks.length - 2);
	strweeks += ' and '+weeks[weeks.length-1]+'.';
	}	
	else{var strweeks = 'For week '+weeks[0]+' only.';}
	document.getElementById("weeksseldiv").innerHTML = strweeks;
}


//the below function creates a list of the rooms the request is for

function makerooms(){
	var strfac = "<strong>Requested Rooms: </strong>";
	if(rooms.length > 0){
		if(rooms.length > 1){
			for(i=0;i<rooms.length-1;i++){
				strfac += rooms[i]+', ';
			}
			strfac = strfac.substr(0,strfac.length - 2);
			strfac += ' and '+rooms[rooms.length-1]+'.';
		}	
		else{strfac = "<strong>Requested Room: </strong>"+rooms[0]+'.';}
	}
	else{strfac += 'None.';}
	document.getElementById("roomsdiv").innerHTML = strfac;
}


//the below function creates a list of the facilites the request is for

function makefacs(){
	var strfac = "<strong>Requested Facilities: </strong>";
	var viewfacs = [];
	for(i=0;i<facilities.length;i++){
		for(j=0;j<facility.length;j++){
			if(facilities[i] == j) viewfacs[viewfacs.length] = facility[j];
		}
	}
	if(viewfacs.length > 0){
		if(viewfacs.length > 1){
			for(i=0;i<viewfacs.length-1;i++){
				strfac += viewfacs[i]+', ';
			}
			strfac = strfac.substr(0,strfac.length - 2);
			strfac += ' and '+viewfacs[viewfacs.length-1]+'.';
		}	
		else{strfac = "<strong>Requested Facility: </strong>"+viewfacs[0]+'.';}
	}
	else{strfac += 'None.';}
	document.getElementById("facsdiv").innerHTML = strfac;
}

makereqinfo();
maketable();
makeweeks();
makerooms();
makefacs();
</script>

<body>

<div id="reqinfodiv"></div>
<br/>
<div id="roomsdiv"></div>
<br/>
<div id="facsdiv"></div>
<br/>
<div id="timetablediv"></div>
<br/>
<div id="weeksseldiv"></div>
<br/>
<div id="roomsdiv"></div>
<br/>
<div id="facsdiv"></div>

</body>

<div id="update"></div>

<form method="post" id="edit" name="edit" action="http://co-project.lboro.ac.uk/team13/deliverable2/user/bookings/main.php">
	<input type="hidden" value="" name="passreqid" id="passreqid">
	<input type='hidden' name='modcodeH' id='modcodeH' value='' />
	<input type='hidden' name='modnameH' id='modnameH' value='' />
	<input type='hidden' name='nostuH'  id='nostuH' value='' />
	<input type='hidden' name='roomArray'  id='roomArray' value='' />
	<input type='hidden' name='departmentH'  id='departmentH' value='' />
	<input type='hidden' name='roundH'  id='roundH' value='' />
	<input type='hidden' name='facsH'  id='facsH' value='' />
	<input type='hidden' name='timeH'  id='timeH' value='' />
	<input type='hidden' name='roomAmount'  id='roomAmount' value='' />
</form>

</body