<!--this script enables the list view and timetable views to be called
Written by Peter Krepa --!>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<?php include '../shared/usercheck.php'; ?>

<head>

<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />

<title>Loughborough University Room Booking System</title>

<link href="../../style.css" rel="stylesheet" type="text/css"/>

<script src='../shared/jquery.js' type='text/javascript'></script>

<script type='text/javascript'>

viewchosen = 'list';
viewhtml = '';
var rounds = [];
var semesters = [];
choicehtml='';

//the below function is calle when the view is changed
//it calls the appropiate view along with an SQL statement
//ensuring the information only corresponds to the semester
//and round selected

function changeview(){
	semid = ' AND RoundID IN(SELECT RoundID FROM RoundClosing WHERE SemesterID = '+document.getElementById('semester').value+') '
	semid2 = ' AND Request.RoundID IN(SELECT RoundID FROM RoundClosing WHERE SemesterID = '+document.getElementById('semester').value+') '
	if(document.getElementById('round').value=='All'){roundid=''}else{roundid='AND RoundID = '+document.getElementById('round').value+' '}
	if(document.getElementById('round').value=='All'){roundid2=''}else{roundid2='AND Request.RoundID = '+document.getElementById('round').value+' '}
	if(viewchosen=='timetable'){
		$("#allsummary").load("tableview.php",{roundid: roundid, semid: semid, semid2: semid2, roundid2: roundid2});
	}
	if(viewchosen=='list'){
		$("#allsummary").load("listview.php",{roundid: roundid, semid: semid});
	}
}

//the below php gets in information about the semesters and rounds

<?php 
	$myconn2=mysql_connect("co-project.lboro.ac.uk",team13,b7c8pbvc);
	mysql_select_db("team13",$myconn2);
	$today = date("Y-m-d");
	$strSQL="SELECT * FROM RoundClosing ";
	$result2=mysql_query($strSQL, $myconn2);
	$count=0;
	while($row=mysql_fetch_array($result2)){
		echo 'var record={} ; ';
		echo 'record.roundid="'.$row["RoundID"].'" ; ';
		echo 'record.name="'.$row["Round"].'" ; ';
		echo 'record.semid="'.$row["SemesterID"].'" ; ';
		echo 'rounds['.$count.']= record ; ';
		$count++;
	}
	$myconn2=mysql_connect("co-project.lboro.ac.uk",team13,b7c8pbvc);
	mysql_select_db("team13",$myconn2);
	$today = date("Y-m-d");
	$strSQL="SELECT * FROM Semester ";
	$result2=mysql_query($strSQL, $myconn2);
	$count=0;
	while($row=mysql_fetch_array($result2)){
		echo 'var record={} ; ';
		echo 'record.semid="'.$row["SemesterID"].'" ; ';
		echo 'record.name="'.$row["Name"].'" ; ';
		echo 'semesters['.$count.']= record ; ';
		$count++;
	}
?>


//the function below makes a select list of all the semesters

function makesemesters(){
	var writestr = '<select id="semester"  onchange="makerounds(this.value);changeview()" size = "1">'
	for(x=0;x<semesters.length;x++){writestr += '<option value ='+semesters[x].semid+'>'+semesters[x].name+'</option>'}
	writestr += '</select>'
	document.getElementById('semesters').innerHTML = writestr
	makerounds(semesters[0].semid)
}


//the function below makes a select list of all the rounds according to the semester selected

function makerounds(sem){
	writestr = '<select onchange="changeview()"  id="round" size = "1">'
	writestr += '<option value ="All">All</option>'
	for(x=0;x<rounds.length;x++){if(rounds[x].semid==sem)writestr += '<option value ='+rounds[x].roundid+'>'+rounds[x].name+'</option>'}
	writestr += '</select>'
	document.getElementById('rounds').innerHTML = writestr
}


//the below function enables the popup help

function open_win(){
	myWindow=window.open('../helppages/summaryhelp.html','','width=500,height=350');
	myWindow.focus();
}


//the below function is called when the user wishes to see more information about the request
//to save all the page being refreshed it simply replaces an onscreen div tag

function makeviewrequest(a,b){
	choicehtml = document.getElementById('choice').innerHTML
	document.getElementById('semesters').innerHTML = ''
	document.getElementById('rounds').innerHTML = ''
	document.getElementById('choice').innerHTML = '<input type="button" onclick="backold()" value="Back To All Requests"/><br><br>'
	window.scrollTo(0, 0)
	$("#allsummary").load("viewrequest.php",{a: a, b: b});
}


//the following function enables a user to ask the admin to release a request

function release(a){
$("#update").load("release.php",{a: a});
}


//the following refreshes the page and is called by the php of the release function
//this is to ensure the SQL is finished before the page is refreshed

function refresh(){
window.location.reload();
}


//the following function allows the list view to be seen after more info has been pressed

function backold(){
	$("#allsummary").load("listview.php");
	makesemesters()
	document.getElementById('choice').innerHTML = '<p><strong><em>Change View:</em></strong> List View<input onchange="javascript:viewchosen=this.value;changeview()" type="radio" value="list" name="type" id="type" checked/> Timetable View<input type="radio" value="timetable" onchange="javascript:viewchosen=this.value;changeview()"  name="type" id="type"/></p>'
}


//the following function enables a user to delete a request

function deleterequest(x){
	var answer = confirm ("Are you sure you want to delete this request?");
	if (answer){
		deletearray = [];
		deletearraycounter = 0;
		deletearray[deletearraycounter] = "DELETE FROM Request WHERE RequestID='"+pendingrecord[x].reqid+"'";
		deletearraycounter ++;
		for(i=0;i<pendingrecord[x].facilities.length;i++){
			deletearray[deletearraycounter] = "DELETE FROM RequestFacility WHERE RequestID='"+pendingrecord[x].reqid+"'";
			deletearraycounter ++;
		}
		for(i=0;i<pendingrecord[x].time.length;i++){
			deletearray[deletearraycounter] = "DELETE FROM RequestTime WHERE RequestID='"+pendingrecord[x].reqid+"'";
			deletearraycounter ++;
		}	
		for(i=0;i<pendingrecord[x].rooms.length;i++){
			deletearray[deletearraycounter] = "DELETE FROM RequestRoom WHERE RequestID='"+pendingrecord[x].reqid+"'";
			deletearraycounter ++;
		}
		$(document).ready(function(){$("#update").load("delete.php", {stringArray: deletearray})});
	}
}


//the following refreshes the page and is called by the php of the delete function
//this is to ensure the SQL is finished before the page is refreshed

function finishdelete(){
	alert('The booking request has been deleted.');
	window.location.reload();
}

</script>

</head>

<body onload="makesemesters();changeview()">
<?php include '../shared/header2.php'; ?>
<div id="menu">
		<br/>
		<ul>
			<li><a href="../start.php">Home</a></li>
			<li><a href="../bookings/main.php">Make A Booking</a></li>
        	<li><a href="../roominfo/main.php">Room Information / Availibility</a></li>		
        	<li><a href="../roundinfo.php">Round Information</a></li>
			<li class="current_page_item"><a href="main.php">My Summary</a></li>
			<li><a href="../help.php">Contact / Help</a></li>
			<li><a href="../../login.php">Logout</a></li>
 		</ul>
</div>

<div id="summarypage">
	<div id="content"><br>
		<strong><center><em>Summary</em></center></strong>
		<div style='text-align:right;margin-right:20px'><a onclick="open_win()">If you need help with this page click here </a></div>
		<br>
		<div style="margin-bottom:10px" id="semesters"></div>
		<div id="rounds"></div>
		<div id='choice'>
			<p><strong><em>Change View:</em></strong> List View<input onchange="javascript:viewchosen=this.value;changeview()" type="radio" value="list" name="type" id="type" checked/> Timetable View<input type="radio" value="timetable" onchange="javascript:viewchosen=this.value;changeview()"  name="type" id="type"/></p>
		</div>
		<div id="allsummary"></div>
	</div>
</div>

<div id="footer">
<p>Loughborough University Computer science Group 13</p>
</div>

<div id='update'></div>

</body>
</html>
