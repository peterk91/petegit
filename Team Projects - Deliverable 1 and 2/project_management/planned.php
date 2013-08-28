<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">

<head profile="http://gmpg.org/xfn/11">
	<title>Project Management Website - Team 13</title>	
	<link rel="shortcut icon" href="image/favicon.ico" />
	<link rel="stylesheet" href="../style/pmwstyle.css" type="text/css" media="screen" />
	<meta http-equiv="content-type" content="text/html; charset=utf-8" />
	<meta http-equiv="content-language" content="en-gb" />
	<meta http-equiv="imagetoolbar" content="false" />
</head>

<?php 	session_start();



if(isset($_SESSION['mySessionVar2'])){}else{
    header("Location: login.php");
}

?>

<body>
	<div id="header">
		<h1>Project Management</h1>
		<h2>Team 13</h2>
	</div>
	<div id="navigation">
		<ul>
			<li><a href="pmhome.php">Home</a></li>
			<li><a href="team.php">The Team</a></li>
        	<li><a href="requirements.php">Requirements</a></li>
        	<li><a href="output.php">Output</a></li>
			<li class="active"><a href="planned.php">Work Planned</a></li>
			<li><a href="forum.php">Forum</a></li>
			<li><a href="login.php">Logout</a></li>
		</ul>
	</div>
	
	<div id="content"><br><br>

			<a href="diagram.html " target="_blank">Diagram to show time/objectives</a>

					<h1>Next Group Meeting: 07/03/2011 - Deliverable 3 Specification</h1> 

					<h1>Current Objectives:</h1>
			<br></br>		<br></br> None.
				<br></br>	<br></br><h1>	Remaining Objectives</h1>
					<br></br><br></br><br></br> None.
					<br></br><br></br><h1> Complete objectives</h1>	
					<br></br><br></br> <b>1. Begin PMW Development</b>. Start: 29/11/2010, End: 06/12/2010 - Peter, Alex. <i> Completed On Time</i>
					<br></br><br></br>&nbsp &nbsp &nbsp &nbsp <b>1.1. Update PMW Based on feedback</b>. Start: 06/12/2010, End: 19/12/2010 - Alex. <i> Completed, 1 Day Late</i>					
					<br></br><br></br> &nbsp &nbsp &nbsp &nbsp <b>1.2 Update PMW Team Page</b>. Start: 06/12/2010, End: 08/12/2010 - Peter.	<i>Completed On Time</i>
					<br></br><br></br>&nbsp &nbsp &nbsp &nbsp <b>1.3 Keep Work planned page up to date.</b> Start: 06/12/2010, End: 27/02/2011 - Alex.	<i>Completed On Time</i>				
					<br></br><br></br>&nbsp &nbsp &nbsp &nbsp <b>1.4 Create Forum</b>. Start: 06/12/2010, End: 27/02/2011 - Andy (Re Designed 14/02/2011 - Alex). <i>Completed On Time</i>	
					<br></br><br></br>&nbsp &nbsp &nbsp &nbsp <b>1.5 Maintenance and administration of PMW.</b> Start: 06/12/2010, End: 27/02/201 - Alex. <i>Completed On Time</i>
					<br></br><br></br> <b>2. Edit and Update CSS style sheets</b>. Start: 06/12/2010, End: 27/02/2011 - Peter. <i>Completed Before Deadline</i>			
					<br></br><br></br> <b>3.Begin work on main site</b>. Start: 20/12/2010, End: 20/02/2011 - Andy, Peter. <i>Completed On Time</i>			
					<br></br><br></br> &nbsp &nbsp &nbsp &nbsp <b>3.1. Create make booking page</b>. Start: 20/12/2010, End: 17/01/2011 - Andy. <i>Completed On Time</i>
					<br></br><br></br>&nbsp &nbsp &nbsp &nbsp &nbsp &nbsp &nbsp &nbsp <b>3.1.1  Have module information displayed on screen</b>. Start: 20/12/2010, End: 17/01/2011 - Andy. <i>Completed On Time</i>
					<br></br><br></br>&nbsp &nbsp &nbsp &nbsp &nbsp &nbsp &nbsp &nbsp &nbsp &nbsp &nbsp &nbsp <b>3.1.1.1 Validate</b> way of displaying module information by romoving user input and linking module name to module ID so that users cannot enter incorrect module information. Start: 14/02/2011, End: 17/02/2011 - Andy. <i>Completed On Time</i>
					<br></br><br></br>&nbsp &nbsp &nbsp &nbsp &nbsp &nbsp &nbsp &nbsp &nbsp &nbsp &nbsp &nbsp <b>3.1.1.2 Testing</b> of module information Start: 20/12/2010, End: 17/02/2011 - Andy, Alex. <i>Completed On Time</i>
					<br></br><br></br>&nbsp &nbsp &nbsp &nbsp &nbsp&nbsp&nbsp&nbsp <b>3.1.2 Create a form that will filter the users search</b> based on their required facilities. Start: 20/12/2010, End: 17/01/2011 - Andy. <i>Completed On Time</i>
					<br></br><br></br>&nbsp &nbsp &nbsp &nbsp &nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp <b>3.1.2.1 Validate</b> to ensure rooms that do not fit the required criteria cannot be selected. Start: 16/02/2011, End: 18/02/2011 - Andy.<i>Completed, 1 Day Late</i>
					<br></br><br></br>&nbsp &nbsp &nbsp &nbsp &nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp <b>3.1.2.2 Testing</b> of room information Start: 20/12/2010, End: 17/02/2011 - Andy, Alex. <i>Completed On Time</i>
					<br></br><br></br>&nbsp &nbsp &nbsp &nbsp &nbsp&nbsp&nbsp&nbsp <b>3.1.3 Use an interactive timetable</b> to allow the user to pick their chosen time slots as they would appear on a printed timetable. Start: 20/12/2010, End: 17/01/2011 - Andy. <i>Completed On Time</i>
					<br></br><br></br>&nbsp &nbsp &nbsp &nbsp &nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp <b>3.1.3.1 Validation</b> to allow rooms to be filtered by which times they are available at. Start: 18/02/2011, End: 20/02/2011 - Andy.<i>Completed On Time</i>
					<br></br><br></br>&nbsp &nbsp &nbsp &nbsp &nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp <b>3.1.3.2 Testing</b> of time information Start: 20/12/2010, End: 17/02/2011 - Andy, Alex. <i>Completed On Time</i>
					<br></br><br></br>&nbsp &nbsp &nbsp &nbsp <b>3.2. Create room information page</b>. Start: 20/12/2010, End: 10/01/2011 - Peter. <i>Completed On Time</i>
					<br></br><br></br>&nbsp &nbsp &nbsp &nbsp &nbsp &nbsp &nbsp &nbsp <b>3.2.1 Display room information</b> and use List boxes to show all of the Parks, Buildings and rooms and enable the user to select a room: 20/12/2010, End: 10/01/2011 - Peter. <i>Completed Before Deadline</i>
					<br></br><br></br>&nbsp &nbsp &nbsp &nbsp &nbsp &nbsp &nbsp &nbsp &nbsp &nbsp &nbsp &nbsp <b>3.2.1.1 Validation</b> to prevent rooms from being displayed if they do not fit the filter results Start: 14/02/2011, End: 16/02/2011 - Peter. <i>Completed, 1 Day Late </i>
					<br></br><br></br>&nbsp &nbsp &nbsp &nbsp &nbsp &nbsp &nbsp &nbsp &nbsp &nbsp &nbsp &nbsp <b>3.2.1.2 Testing</b> of room select Start: 20/12/2010, End: 17/02/2011 - Peter, Alex. <i>Completed On Time</i>
					<br></br><br></br>&nbsp &nbsp &nbsp &nbsp &nbsp&nbsp&nbsp&nbsp <b>3.2.2 Have a graphical way of displaying room information </b> Start: 20/12/2010, End: 10/01/2011 - Peter. <i>Completed On Time</i>
					<br></br><br></br>&nbsp &nbsp &nbsp &nbsp &nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp <b>3.2.2.1 Validate</b> way of graphically displaying room information Start: 16/02/2011, End: 18/02/2011 - Peter. <i>Completed Before Deadline</i>
					<br></br><br></br>&nbsp &nbsp &nbsp &nbsp &nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp <b>3.2.2.2 Testing </b>of room information Start: 20/12/2010, End: 17/02/2011 - Peter, Alex. <i>Completed On Time</i>
					<br></br><br></br>&nbsp &nbsp &nbsp &nbsp &nbsp&nbsp&nbsp&nbsp <b>3.2.3 Have a more detailed way of filtering the searches</b>. Start: 20/12/2010, End: 10/01/2011 - Peter. <i>Completed On Time</i>
					<br></br><br></br>&nbsp &nbsp &nbsp &nbsp &nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp <b>3.2.3.1 Validate</b> search filter Start: 18/02/2011, End: 20/02/2011 - Peter. <i>Completed On Time</i>
					<br></br><br></br>&nbsp &nbsp &nbsp &nbsp &nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp <b>3.2.3.2 Testing</b> of search filter Start: 20/12/2010, End: 17/02/2011 - Peter, Alex <i>Completed On Time</i>
					<br></br><br></br>&nbsp &nbsp &nbsp &nbsp <b>3.3. Create round information page</b>. Start: 19/02/2011, End: 23/02/2011 - Alex. <i>Completed On Time</i>
					<br></br><br></br>&nbsp &nbsp &nbsp &nbsp <b>3.4.Updates to Home page</b>. Start: 11/02/2011, End: 15/02/2011 - Alex. <i>Completed On Time</i>
					<br></br><br></br>&nbsp &nbsp &nbsp &nbsp <b>3.5. Create Summary page </b>with options for a list view or a timetable view, use colours to indicate the status of a request. Requests can be edited/deleted depending on its status. Start: 20/02/2011, End: 27/02/2011 - Peter, Andy. <i>Completed On Time</i>
					<br></br><br></br>&nbsp &nbsp &nbsp &nbsp &nbsp&nbsp&nbsp&nbsp <b>3.2.1  Validate </b>Summary page. Start: 20/02/2011, End: 27/02/2011 - Peter, Andy. <i>Completed On Time</i>
					<br></br><br></br>&nbsp &nbsp &nbsp &nbsp &nbsp&nbsp&nbsp&nbsp <b>3.2.2  Test </b>Summary page. Start: 20/02/2011, End: 27/02/2011 - Peter, Andy, Alex. <i>Completed On Time</i>
					<br></br><br></br>&nbsp &nbsp &nbsp &nbsp <b>3.6. Make and complete Help pages</b>. Start: 20/02/2011, End: 27/02/2011 - Alex. <i>Completed On Time</i>
					<br></br><br></br><br></br> <b>4. Create Database</b>. Start: 13/12/2010, End: 17/02/2011 - Alex, Andy, Peter, AndyV, Sean. <i>Completed On Time</i>
					<br></br><br></br>&nbsp &nbsp &nbsp &nbsp <b>4.1. Structure Database</b>. Start: 13/12/2010, End: 17/12/2010 - Alex, Andy, Peter. <i>Completed Before Deadline</i>
					<br></br><br></br>&nbsp &nbsp &nbsp &nbsp <b>4.2. Enter Data into Database</b>. Start: 17/12/2010, End: 17/01/2011 - Alex, AndyV, Sean. <i>Completed On Time</i>
					<br></br><br></br>&nbsp &nbsp &nbsp &nbsp <b>4.3. Data encryption of passwords</b>. Start: 17/01/2011, End: 18/01/2011 - Alex. <i>Completed On Time</i>
					<br></br><br></br><br></br> <b>5. Documents and Reports</b>. Start: 29/11/2010, End: 27/02/2011 - Alex, Andy, Peter, AndyV, Sean. <i>Completed On Time</i>
					<br></br><br></br>&nbsp &nbsp &nbsp &nbsp <b>5.1. Documentation on PMW</b>. Start: 06/12/2010, End: 28/02/2011 - Alex. <i>Completed On Time</i>
					<br></br><br></br>&nbsp &nbsp &nbsp &nbsp &nbsp &nbsp &nbsp &nbsp <b>5.1.1 Documenting requirements on PMW</b>. Start: 06/12/2010, End: 27/02/2011 - Alex. <i>Completed On Time</i>
					<br></br><br></br>&nbsp &nbsp &nbsp &nbsp &nbsp &nbsp &nbsp &nbsp <b>5.1.2 Documenting Outputs on PMW</b>. Start: 06/12/2010, End: 27/02/2011 - Peter. <i>Completed On Time</i>
					<br></br><br></br>&nbsp &nbsp &nbsp &nbsp &nbsp &nbsp &nbsp &nbsp <b>5.1.3 Documenting objectives on PMW</b>. Start: 06/12/2010, End: 27/02/2011 - Alex. <i>Completed On Time</i>
					<br></br><br></br>&nbsp &nbsp &nbsp &nbsp &nbsp &nbsp &nbsp &nbsp <b>5.1.4 Document updates on PMW</b>. Start: 06/12/2010, End: 27/02/2011 - Alex. <i>Completed On Time</i>
					<br></br><br></br>&nbsp &nbsp &nbsp &nbsp &nbsp &nbsp &nbsp &nbsp <b>5.1.1 Creating and publishing time graph to PMW</b>. Start: 06/12/2010, End: 28/02/2011 - Alex. <i>Completed On Time</i>
					<br></br><br></br>&nbsp &nbsp &nbsp &nbsp <b>5.2. Documentation</b>. Start: 06/12/2010, End: 27/02/2011 - Peter, AndyV, Sean. <i>Completed, 1 Day Late</i>
					<br></br><br></br>&nbsp &nbsp &nbsp &nbsp &nbsp &nbsp &nbsp &nbsp <b>5.2.1 Creating New ER Tables</b>. Start: 06/12/2010, End: 27/02/2011 - AndyV, Sean. <i>Completed On Time</i>
					<br></br><br></br>&nbsp &nbsp &nbsp &nbsp &nbsp &nbsp &nbsp &nbsp <b>5.2.2 Creating New ER Diagram</b>. Start: 06/12/2010, End: 27/02/2011 - AndyV, Sean, Updated by Peter. <i>Completed, 1 Day Late</i>
					<br></br><br></br>&nbsp &nbsp &nbsp &nbsp &nbsp &nbsp &nbsp &nbsp <b>5.2.1 Acessability Report</b>. Start: 06/12/2010, End: 27/02/2011 - AndyV. <i>Completed On Time</i>
					
					
<br></br><br></br>










		



	</div>
	
	<div id="footer">
		<p>Copyright &copy; Team 13 </p>
	</div>
</body>

</html>