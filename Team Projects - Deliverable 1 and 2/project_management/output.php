<html>

<head>
	<title>Project Management Website - Team 13</title>	
	<link rel="stylesheet" href="../style/pmwstyle.css" type="text/css" media="screen" />
</head>

<body>


<?php 	session_start();



if(isset($_SESSION['mySessionVar2'])){}else{
    header("Location: login.php");
}

?><body>
	<div id="header">
		<h1>Project Management</h1>
		<h2>Team 13</h2>
	</div>
	<div id="navigation">
		<ul>
			<li><a href="pmhome.php">Home</a></li>
			<li><a href="team.php">The Team</a></li>
        	<li><a href="requirements.php">Requirements</a></li>
        	<li class="active"><a href="output.php">Output</a></li>
			<li><a href="planned.php">Work Planned</a></li>
			<li><a href="forum.php">Forum</a></li>
			<li><a href="login.php">Logout</a></li>
		</ul>
	</div>
	
	<div id="content">
		<h1>Deliverable 1</h1>
		<br><br>
		<a href='../deliverable1/sheet.xlsx' target="_blank">Excel Room Booking System</a><br><br>
		<a href='../deliverable1/timetable/login.html' target="_blank">Prototype Website</a><br><br>
		<a href='../deliverable1/er.pdf' target="_blank">Entity Relationship Diagram</a><br><br>
		<a href='../deliverable1/tables.docx' target="_blank">Entity Relationship Tables</a><br><br>
		<a href='../deliverable1/report.doc' target="_blank">Design Principles Report</a><br><br>

		<h1>Deliverable 2 </h1> 
		<br><br>
		<a href='../deliverable2/login.php' target="_blank">Dynamic System</a><br><br>
		<a href='../deliverable2/documentation/FINALTABLES.doc' target="_blank">Entity Relationship Tables</a><br><br>
		<a href='../deliverable2/documentation/FINALER.jpg' target="_blank">Entity Relationship Diagram</a><br><br>
		<a href='../deliverable2/documentation/FINALACCES.docx' target="_blank">Accessibility Report</a><br><br>

	
		<h1>Deliverable 3</h1>
		<br><br>
		Yet to be set task.

	</div>
	
	<div id="footer">
		<p>Copyright &copy; <a href="#">Team 13</a> </p>
	</div>
</body>

</html>