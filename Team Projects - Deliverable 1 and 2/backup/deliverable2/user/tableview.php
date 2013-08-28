<html>
<?php include 'php/usercheck.php'; ?>
<head>
<title>Loughborough University Room Booking System</title>
<link href="../style.css" rel="stylesheet" type="text/css"/>
<script src='http://ajax.microsoft.com/ajax/jquery/jquery-1.5.min.js' type='text/javascript'></script>
<script type='text/javascript'>

pendingrecord = [];
allocatedrecord = [];
deniedrecord = [];

///////RECORD LAYOUT IS LIKE    record.date   .moduleid .nostudents  .rooms[array of roomnos]
////// .facilities[array of facs]     .time[array of records {.week,.day,.period}]  .reqid

<?php include 'php/pendingSQL.php';?>


<?php include 'php/allocatedSQL.php';?>


<?php include 'php/deniedSQL.php';?>

var partmodbool = false;

var modules = [];
<?php
	$myconn2=mysql_connect("co-project.lboro.ac.uk",team13,b7c8pbvc);
	mysql_select_db("team13",$myconn2);
	
	$strSQL="SELECT * FROM Module INNER JOIN Request ON Module.ModuleID=Request.ModuleID WHERE Request.UserID = 'AndyW' ORDER BY Part";
	$result2=mysql_query($strSQL, $myconn2);
	$count = 0;
	while($row=mysql_fetch_array($result2)){
			echo 'var record={} ; ';
			echo 'record.id="'.$row["ModuleID"].'" ; ';
			echo 'record.part="'.$row["Part"].'" ; ';
			echo 'modules['.$count.']=record ; ';
			$count++;
	}
?>

var weeks = 15;
var dayarray = ["Mon","Tue","Wed","Thu","Fri"];
var periods = 9;
var times = ["9am-<br>10am","10am-<br>11am","11am-<br>12pm","12pm-<br>1pm","1pm-<br>2pm","2pm-<br>3pm","3pm-<br>4pm","4pm-<br>5pm","5pm-<br>6pm"];

function makepartmodchoice(){
	var strpartmod = "<strong>Make timetable via:</strong> Module<input type='radio' value='0' name='modpartrad' id='modpartrad' onChange='changepartmod(this.value);filltable();' checked /> Part<input type='radio' value='1' name='modpartrad' id='partmodrad' onChange='changepartmod(this.value);filltable()' />";
	document.getElementById("partmodchoice").innerHTML = strpartmod;
	changepartmod('0');
}

function changepartmod(choice){
	if(choice == 0){
		document.getElementById("moduleorpart").innerHTML = '';
		makemodules();
	}
	else{
		document.getElementById("moduleorpart").innerHTML = '';
		makeparts();
	}
	partmodbool = !(partmodbool);
}

function makemodules(){
	var modCode =[];
	var selectstr = '<strong>Module Code</strong><br><select size="10" onchange="makeweeks();filltable();"  style="width:75px;" name="modulecode" id="modulecode">';
	j = 0;
	for(i=0;i<pendingrecord.length;i++){
		modCode[i] = pendingrecord[i].moduleid;
	}
	
	for(i=0;i<allocatedrecord.length;i++){
		var found = false;
		for(j=0;j<modCode.length;j++){
			if(modCode[j] == allocatedrecord[i].moduleid) found = true;
		}
		if(!found) modCode[modCode.length] = allocatedrecord[i].moduleid;
	}
	
	modCode.sort();
	selectstr += '<option selected>'+modCode[0]+'</option>';
	for(i=1;i<modCode.length;i++){
		selectstr += '<option>'+modCode[i]+'</option>';
	}
	
	selectstr += '</select>';
	document.getElementById("moduleorpart").innerHTML = selectstr;
}

function makeparts(){
	var selectstr = '<strong>Part</strong><br><select size="10" onchange="makeweeks();filltable()"  style="width:75px;" id="partselect">';
	
	var p = [];
	for(i=0;i<modules.length;i++){
		var found = false;
		for(j=0;j<p.length;j++){
			if(modules[i].part == p[j]) found = true;
		}
		if(!found) p[p.length] = modules[i].part;
	}
	
	p.sort();
	selectstr += '<option selected>'+p[0]+'</option>';
	for(i=1;i<p.length;i++){
		selectstr += '<option>'+p[i]+'</option>';
	}
	
	selectstr += '</select>';
	document.getElementById("moduleorpart").innerHTML = selectstr;
}

function makeweeks(){
	emptytable();
	var selectstr ='<strong>Week</strong><br><select id="weekselect" onchange="filltable()" size = "10">';
	
	if(partmodbool) var selectedmodule = document.getElementById("modulecode").value;
	else var selectedpart = document.getElementById("partselect").value;
	
	var weekarray = [];
	if(partmodbool){
		for(i=0;i<pendingrecord.length;i++){
			if(pendingrecord[i].moduleid == selectedmodule){
				for(j=0;j<pendingrecord[i].time.length;j++){
					var found = false;
					for(k=0;k<weekarray.length;k++){
						if(weekarray[k] == pendingrecord[i].time[j].week)found = true;
					}
					if(!found) weekarray[weekarray.length] = pendingrecord[i].time[j].week;
				}
			}
		}
	}
	else{
		for(i=0;i<pendingrecord.length;i++){
			for(l=0;l<modules.length;l++){
				if(pendingrecord[i].moduleid == modules[l].id && modules[l].part == selectedpart){
					for(j=0;j<pendingrecord[i].time.length;j++){
						var found = false;
						for(k=0;k<weekarray.length;k++){
							if(weekarray[k] == pendingrecord[i].time[j].week)found = true;
						}
						if(!found) weekarray[weekarray.length] = pendingrecord[i].time[j].week;
					}
				}
			}
		}
	}
	
	if(partmodbool){
		for(i=0;i<allocatedrecord.length;i++){
			if(allocatedrecord[i].moduleid == selectedmodule){
				for(j=0;j<allocatedrecord[i].time.length;j++){
					var found = false;
					for(k=0;k<weekarray.length;k++){
						if(weekarray[k] == allocatedrecord[i].time[j].week)found = true;
					}
					if(!found) weekarray[weekarray.length] = allocatedrecord[i].time[j].week;
				}
			}
		}
	}
	else{
		for(i=0;i<allocatedrecord.length;i++){
			for(l=0;l<modules.length;l++){
				if(allocatedrecord[i].moduleid == modules[l].id && modules[l].part == selectedpart){
					for(j=0;j<allocatedrecord[i].time.length;j++){
						var found = false;
						for(k=0;k<weekarray.length;k++){
							if(weekarray[k] == allocatedrecord[i].time[j].week)found = true;
						}
						if(!found) weekarray[weekarray.length] = allocatedrecord[i].time[j].week;
					}
				}
			}
		}
	}
	
	weekarray.sort(function(a,b){return a - b});
	selectstr += '<option selected>'+weekarray[0]+'</option>'
	for(i=1;i<weekarray.length;i++) selectstr += '<option>'+weekarray[i]+'</option>';
	selectstr += '</select>';
	
	document.getElementById("weeksdiv").innerHTML = selectstr;
}

function maketable(){
	var strtt = '<table id="timetable">';
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

}

function emptytable(){
	for(j=0;j<dayarray.length;j++) for(i=1;i<=periods;i++)document.getElementById(dayarray[j]+i).style.background = 'WHITE';
}

function filltable(){
	emptytable();
	var selectedweek = document.getElementById("weekselect").value;
	
	if(partmodbool) var selectedmodule = document.getElementById("modulecode").value;
	else var selectedpart = document.getElementById("partselect").value;
	
	for(i=0;i<pendingrecord.length;i++){
		if(partmodbool){
			if(pendingrecord[i].moduleid == selectedmodule){
				for(j=0;j<pendingrecord[i].time.length;j++){
					if(pendingrecord[i].time[j].week == selectedweek){
						document.getElementById(pendingrecord[i].time[j].day+pendingrecord[i].time[j].period).style.background = 'ORANGE';
					}
				}
			}
		}
		else{
			for(k=0;k<modules.length;k++){
				if(pendingrecord[i].moduleid == modules[k].id && modules[k].part == selectedpart){
					for(j=0;j<pendingrecord[i].time.length;j++){
						if(pendingrecord[i].time[j].week == selectedweek){
							document.getElementById(pendingrecord[i].time[j].day+pendingrecord[i].time[j].period).style.background = 'ORANGE';
						}
					}
				}
			}
		}
	}
	
	for(i=0;i<allocatedrecord.length;i++){
		if(partmodbool){
			if(allocatedrecord[i].moduleid == selectedmodule){
				for(j=0;j<allocatedrecord[i].time.length;j++){
					if(allocatedrecord[i].time[j].week == selectedweek){
						document.getElementById(allocatedrecord[i].time[j].day+allocatedrecord[i].time[j].period).style.background = 'GREEN';
					}
				}
			}
		}
		else{
			for(k=0;k<modules.length;k++){
				if(allocatedrecord[i].moduleid == modules[k].id && modules[k].part == selectedpart){
					for(j=0;j<allocatedrecord[i].time.length;j++){
						if(allocatedrecord[i].time[j].week == selectedweek){
							document.getElementById(allocatedrecord[i].time[j].day+allocatedrecord[i].time[j].period).style.background = 'GREEN';
						}
					}
				}
			}
		}
	}
}

makepartmodchoice();
maketable();
makeweeks();
filltable();

</script>

</head>

<body>



		<div id="partmodchoice"></div>
		<div id="moduleorpart"></div>
		<div id="weeksdiv"></div>
		<div id="timetablediv"></div>



</body>
</html>