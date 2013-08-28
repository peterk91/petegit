<head>
<script type='text/javascript'>

//this script enables the user to see all their requests and order/filter them, in a list style view
//Written by Peter Krepa with Delete Request written by Andrew Wallis

//starts off with empty records which are filled by the imported php files

pendingrecord = [];
allocatedrecord = [];
deniedrecord = [];
var facility = [];
var noWeeks = 15;

<?php $round = $_REQUEST['roundid']; ?>

<?php $sem = $_REQUEST['semid']; ?>

<?php include 'pendingSQL.php';?>

<?php include 'allocatedSQL.php';?>

<?php include 'deniedSQL.php';?>

<?php include '../shared/facilitySQL.php';?>

<?php echo 'var user = "'.$_SESSION['systemlogged1'].'" ; '; ?>


//the below function takes two variables, and depending on their value orders the
//lists of requests correspondingly, it does this by passing the appropiate SQL
//statement to another PHP file

function orderby(v,y){
	if (v=='Date'){x="Date DESC"};
	if (v=='ModuleID'){x="ModuleID"}
	if (v=='NoStu'){x="NoStudents"}
	if (y=='table1'){rec= 'pendingrecord'; z='SELECT * FROM Request WHERE UserID = "'+user+'" AND RequestID NOT IN(SELECT RequestID FROM Denied) AND (RoundID = 1 OR RoundID=2  OR RoundID=3  OR RoundID=4)  AND RequestID NOT IN(SELECT RequestID FROM Allocation) ORDER BY '+x}
	if (y=='table2'){;rec='allocatedrecord';z='SELECT * FROM Request WHERE UserID = "'+user+'" AND RequestID IN(SELECT RequestID FROM Allocation) AND (RoundID = 1 OR RoundID=2  OR RoundID=3  OR RoundID=4)  ORDER BY '+x}
	if (y=='table3'){;rec='deniedrecord';z='SELECT * FROM Request WHERE UserID = "'+user+'" AND RequestID IN(SELECT RequestID FROM Denied) AND (RoundID = 1 OR RoundID=2  OR RoundID=3  OR RoundID=4)   ORDER BY '+x}
	$("#update").load("orderbySQL.php", {sql: z, table: y});
}


//the below function is called by the php file which orders the requests
//it creates the new tables based on the result

function makenewtable(newrecord,table){
	if (table=='table1'){pendingrecord = newrecord}
	if (table=='table2'){allocatedrecord= newrecord}
	if (table=='table3'){deniedrecord= newrecord}
	maketable(table)
}


//the below function creates the appropiate table - pending, allocated or denied requests,
//depending on the value it is given


function maketable(x){

	if (x=='table1'){
		var date1= "'Date'"
		var mod1= "'ModuleID'"
		var nos1= "'NoStu'"
		var table = "'table1'"
		tabhtml ='<input type="button" value="Order By Date" onclick="orderby('+date1+','+table+')" /> 	&nbsp; 	&nbsp;'
		tabhtml +='<input type="button" value="Order By ModuleID" onclick="orderby('+mod1+','+table+')" /> 	&nbsp; 	&nbsp;'
		tabhtml +='<input type="button" value="Order By Number of Students" onclick="orderby('+nos1+','+table+')" /><br><br>'
		tabhtml += "<table id='pending'><tr><th>Date Submitted</th><th>Module ID</th><th>Module Name</th><th>Number of <br> Students</th><th>Rooms Requested</th><th>Facilities Requested</th><th>Weeks Requested</th></th></tr>"
		for(x=0;x<pendingrecord.length;x++){
			tabhtml +='<tr><td>'+pendingrecord[x].date+'</td><td>'+pendingrecord[x].moduleid+'</td><td>'+pendingrecord[x].name+'</td><td>'+pendingrecord[x].nostudents+'</td><td>'
			if(pendingrecord[x].rooms.length==0){tabhtml += 'Any'}else{for(y=0;y<pendingrecord[x].rooms.length;y++){tabhtml += pendingrecord[x].rooms[y]+', '}}
			tabhtml += '</td><td>'
			if(pendingrecord[x].facilities.length==0){tabhtml += 'None'}else{for(y=0;y<pendingrecord[x].facilities.length;y++){tabhtml += facility[pendingrecord[x].facilities[y]]+", "}}
			tabhtml += '</td><td>'
			var weeks = [];
			for(z=0;z<(pendingrecord[x].time.length);z++){
				var found = false;
				for(d=0;d<weeks.length;d++){
					if(pendingrecord[x].time[z].week == weeks[d]) found = true;
				}
					if(!found) weeks[weeks.length] = pendingrecord[x].time[z].week;
			}
			weeks.sort(function(a,b){return a - b})
			for(g=0;g<weeks.length;g++){tabhtml += weeks[g]+", "}
			theid = pendingrecord[x].reqid
			tabhtml += '</td><th><input style="width:115px" type="button" value="View More Info" onClick="parent.makeviewrequest('+theid+',0)"/>';
			tabhtml += '<br><input type="button"  style="width:115px" value="Delete" onClick="deleterequest('+x+');"/></th></tr>';
		}
		tabhtml +='</table>'
		document.getElementById('table1').innerHTML = tabhtml
	}
	if (x=='table2'){
		var date1= "'Date'"
		var mod1= "'ModuleID'"
		var nos1= "'NoStu'"
		var table = "'table2'"
		tabhtml ='<input type="button" value="Order By Date" onclick="orderby('+date1+','+table+')" /> 	&nbsp; 	&nbsp;'
		tabhtml +='<input type="button" value="Order By ModuleID" onclick="orderby('+mod1+','+table+')" /> 	&nbsp; 	&nbsp;'
		tabhtml +='<input type="button" value="Order By Number of Students" onclick="orderby('+nos1+','+table+')" /><br><br>'
		tabhtml += "<table id='allocated'><tr><th>Date Submitted</th><th>Module ID</td><th>Module Name</th><th>Number of Students</th><th>Rooms Requested</th><th>Facilities Requested</th><th>Weeks Requested</th><th></th></tr>"
		for(x=0;x<allocatedrecord.length;x++){
			tabhtml +='<tr><td>'+allocatedrecord[x].date+'</td><td>'+allocatedrecord[x].moduleid+'</td><td>'+allocatedrecord[x].name+'</td><td>'+allocatedrecord[x].nostudents+'</td><td>'
			if(allocatedrecord[x].rooms.length==0){tabhtml += 'Any'}else{for(y=0;y<allocatedrecord[x].rooms.length;y++){tabhtml += allocatedrecord[x].rooms[y]+', '}}
			tabhtml += '</td><td>'
			if(allocatedrecord[x].facilities.length==0){tabhtml += 'None'}else{for(y=0;y<allocatedrecord[x].facilities.length;y++){tabhtml += facility[allocatedrecord[x].facilities[y]]+", "}}
			tabhtml += '</td><td>'
			var weeks = [];
			for(z=0;z<(allocatedrecord[x].time.length);z++){
				var found = false;
				for(d=0;d<weeks.length;d++){
					if(allocatedrecord[x].time[z].week == weeks[d]) found = true;
				}
				if(!found) weeks[weeks.length] = allocatedrecord[x].time[z].week;
			}
			weeks.sort(function(a,b){return a - b})
			for(g=0;g<weeks.length;g++){tabhtml += weeks[g]+", "}
			theid = allocatedrecord[x].reqid
			tabhtml += '</td><td><input type="button" style="width:115px" value="View More Info" onClick="parent.makeviewrequest('+theid+',1)"/>';
			if(allocatedrecord[x].release=='yes'){tabhtml += '<br><i><center>Release Requested</center></i>';}
			if(allocatedrecord[x].release=='no'){tabhtml += '<br><input type="button" onclick="parent.release('+theid+')" style="width:115px" value="Request Release" />'};
		}
		tabhtml +='</td></table>'
		document.getElementById('table2').innerHTML = tabhtml
	}
	if (x=='table3'){
		var date1= "'Date'"
		var mod1= "'ModuleID'"
		var nos1= "'NoStu'"
		var table = "'table3'"
		tabhtml ='<input type="button" value="Order By Date" onclick="orderby('+date1+','+table+')" /> 	&nbsp; 	&nbsp;'
		tabhtml +='<input type="button" value="Order By ModuleID" onclick="orderby('+mod1+','+table+')" /> 	&nbsp; 	&nbsp;'
		tabhtml +='<input type="button" value="Order By Number of Students" onclick="orderby('+nos1+','+table+')" /><br><br>'
		tabhtml += "<table id='denied'><tr><th>Date Submitted</th><th>Module ID</td><th>Module Name</th><th>Number of Students</th><th>Rooms Requested</th><th>Facilities Requested</th><th>Weeks Requested</th></tr>"
		for(x=0;x<deniedrecord.length;x++){
			tabhtml +='<tr><td>'+deniedrecord[x].date+'</td><td>'+deniedrecord[x].moduleid+'</td><td>'+deniedrecord[x].name+'</td><td>'+deniedrecord[x].nostudents+'</td><td>'
			if(deniedrecord[x].rooms.length==0){tabhtml += 'Any'}else{for(y=0;y<deniedrecord[x].rooms.length;y++){tabhtml += deniedrecord[x].rooms[y]+', '}}
			tabhtml += '</td><td>';
			if(deniedrecord[x].facilities.length==0){tabhtml += 'None'}else{for(y=0;y<deniedrecord[x].facilities.length;y++){tabhtml += facility[deniedrecord[x].facilities[y]]+", "}}
			tabhtml += '</td><td>';
			var weeks = [];
			for(z=0;z<(deniedrecord[x].time.length);z++){
				var found = false;
				for(d=0;d<weeks.length;d++){
					if(deniedrecord[x].time[z].week == weeks[d]) found = true;
				}
				if(!found) weeks[weeks.length] = deniedrecord[x].time[z].week;
			}
			weeks.sort(function(a,b){return a - b})
			for(g=0;g<weeks.length;g++){tabhtml += weeks[g]+", "}
			theid = deniedrecord[x].reqid
			tabhtml += '</td><th><input type="button" style="width:115px" value="View More Info" onClick="parent.makeviewrequest('+theid+',2)"/>';
		}
		tabhtml +='</table>'
		document.getElementById('table3').innerHTML = tabhtml
	}
}

//the below function deletes a selected request, it does this
//by using the request id and loading a new php document

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
		$("#update").load("delete.php", {stringArray: deletearray})
	}
}


//this function is called when the delete php document is finshed and it
//therefore refreshes the page

function finishdelete(){
	alert('The booking request has been deleted.');
	window.location.reload();
}

maketable('table1');
maketable('table2');
maketable('table3');

</script>

</head>

<body>

<p><strong>Pending</strong> <img id='pendP' style="width:30px" src="../../images/downup.jpg"/><p>
<div id='table1'></div>
<p><strong>Allocated</strong> <img id='alloP' style="width:30px" src="../../images/down.jpg"/><p>
<div style="display:none" id='table2'></div>
<p><strong>Denied</strong> <img id='deniP' style="width:30px" src="../../images/down.jpg"/><p>
<div style="display:none" id='table3'></div>

<script>

$('#pendP').toggle(function() {	$("#table1").slideToggle("slow");
	     	var src = "../../images/down.jpg";
            	$(this).attr("src", src);
}
	, function() {
      			$("#table1").slideToggle("slow");
            		var src = "../../images/downup.jpg";
            		$(this).attr("src", src);});

$('#alloP').toggle(function() {
      			$("#table2").slideToggle("slow");
            		var src =  "../../images/downup.jpg";
            		$(this).attr("src", src);}
	, function() {
		$("#table2").slideToggle("slow");
	     	var src = "../../images/down.jpg";
            	$(this).attr("src", src);});

$('#deniP').toggle(function() {
      			$("#table3").slideToggle("slow");
            		var src =  "../../images/downup.jpg";
            		$(this).attr("src", src);}
	, function() {
		$("#table3").slideToggle("slow");
	     	var src = "../../images/down.jpg";
            	$(this).attr("src", src);});

</script>


<div id="update"></div>
