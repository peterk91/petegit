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
        	<li class="active"><a href="requirements.php">Requirements</a></li>
        	<li><a href="output.php">Output</a></li>
			<li><a href="planned.php">Work Planned</a></li>
			<li><a href="forum.php">Forum</a></li>
			<li><a href="login.php">Logout</a></li>
		</ul>
	</div>
	
	<div id="content">

<h1>1. From Deliverable 1 Meeting </h1>
<br><br>
<ul>
	
	<li>1.1 Make sure selection of modules can be done by codes and titles, with codes being the first option.</li>

	<li>1.2 Preferred room type must be higher than in the prototype.</li>

	<li>1.3 Produce customised output.</li>

	<li>1.4 Increase numbers of weeks as not all weeks are included in the booking form.</li>

	<li>1.5 Different ways of booking - by module / date and time.</li>

</ul>

<h1>2. Functional Requirements </h1>
<br>
<p id = 'title2'>2.1. System Wide Requirements </p>
<br></br><p>2.1.1 Minimise user input to prevent incorrect data from being entered.
<br></br>2.1.2 Have a secure system that will not allow unauthorized acess.
<br></br>2.1.3 Passwords must be encrypted to prevent them from being easily stolen.
<br></br>2.1.4 The login system must not be bypassed by entering a page URL, all pages must check for a user to be logged in.
<br></br>2.1.5 Validate data wherever possible to prevent incorrect data from being entered.
<br></br>2.1.6 Keep live updates available for the user on the Home page.
<br></br>2.1.7 Provide live details on current, previous and upcoming rounds.
<br></br>2.1.8 Provide a help and faq page for general enquiries.
<br></br> &nbsp &nbsp &nbsp &nbsp 2.1.8.1 Provide individual help pages for complex areas of the system.
<br></br> &nbsp &nbsp &nbsp &nbsp 2.1.8.2 Use help pages to ensure the system is useable with very little training.
<br></br>2.1.9 Document all work and include diagrams.
</p>


<p id = 'title2'>2.2. Booking requirements </p>
</br><p>2.2.1 Ability to enter a new module if it does not already exist.
<br></br> 2.2.2 Users should be able to select which of the open rounds they wish to make a booking for.
<br></br> 2.2.3 Users should be able to choose a module by selecting its part.
<br></br>2.2.4 Validation to prevent modules from being selected with unmatching name/code. Requirement to satisfy 2.1.5.
<br></br>2.2.5 Choose a Room based on its facilities, capacity or available times.
<br></br>2.2.6 Chose a room by selecting its park, building or building ID.
<br></br>2.2.7 Book a room for only a part of a semester.
<br></br>&nbsp &nbsp &nbsp &nbsp &nbsp 2.2.7.1 Book rooms for exact weeks.
<br></br> 2.2.8 Provide an individual help page for the booking this section, requirement to satisfy 2.1.8.1/2.
<br></br> 2.2.9 Prevent a room booking where the number of students is larger than the room capacity. Requirement to satisfy 2.1.5.
<br></br> 2.2.10 Provide a visual way to book a time slot, Requirement to satisfy 2.5.1
</p>



<p id = 'title2'>2.3 Room Availability/Information Requirements </p>

</br><p> 2.3.1 Search for a room by Park, Building and building ID.
<br></br>&nbsp &nbsp &nbsp &nbsp 2.3.1.1 Use an advanced filter to search for a room based on its facilities, capacity, room type or room style.
<br></br> 2.3.2 Provide a display showing each room and its facilities.
<br></br> &nbsp &nbsp &nbsp &nbsp 2.3.2.1 Provide an image of each room.
<br></br> &nbsp &nbsp &nbsp &nbsp 2.3.2.2 Provide a timetable to show room availability.
<br></br> 2.3.3 Provide an individual help page for the booking this section, requirement to satisfy 2.1.8.1/2.
<br></br> 2.3.4 Match rooms with their building name, code and park when they are selected. Requirement to satisfy 2.1.5.
<br></br> 2.3.5 Provide a visual way of viewing the availability times. Requirement to satisfy 2.5.1


<p id = 'title2'>2.4 My Summary Requirements </p>

</br><p>2.4.1 Ability to sort requests
<br></br>&nbsp;&nbsp;&nbsp;&nbsp; 2.4.1.1 By Status.
<br></br>&nbsp;&nbsp;&nbsp;&nbsp; 2.4.1.2 Day/Time.
<br></br>&nbsp;&nbsp;&nbsp;&nbsp; 2.4.1.3 Module Code.
<br></br>2.4.2. Users should be able to edit pending requests.
<br></br>&nbsp;&nbsp;&nbsp;&nbsp 2.4.2.1 Users should be able to delete pending requests.
<br></br>&nbsp;&nbsp;&nbsp;&nbsp 2.4.2.2 Users should be able to re-submit a similar requst after a request has been denied.
<br></br>&nbsp;&nbsp;&nbsp;&nbsp 2.4.2.3 Users should be able to request to change an allocated request, but will need administrator permission.
<br></br> 2.4.3 Have an alternative timetable display to show when rooms have been booked for, requirement to satisfy 2.5.1
</p>

<p id = 'title2'>2.5 Usability Requirements </p>

<br></br>2.5.1 Different views supported accross the system.
<br></br>&nbsp;&nbsp;&nbsp;&nbsp 2.5.1.1 Data list views available.
<br></br>&nbsp;&nbsp;&nbsp;&nbsp 2.5.1.2 Interactive views of data available.
<br></br>&nbsp;&nbsp;&nbsp;&nbsp 2.5.1.3 Timetable views available.
<br></br> 2.5.2 Clearly labelled data entry points.
<br></br>&nbsp;&nbsp;&nbsp;&nbsp 2.5.2.1 No data enry point should be without a label.



<h1>3. Non-Functional Requirements </h1>
<br></br><p>3.1 The Database information must be updated immediateley to prevent users from entering different information at the same time and one users data being lost.
<br></br> 3.2 The Database must not use more memory storage than is available on the server.
<br></br>3.3 All data should be backed up.
<br></br>3.4 System Availability must be over 0.8.
<br></br>3.5 The system must comply with all relevant legislations.
<br></br> &nbsp&nbsp&nbsp&nbsp 3.5.1 The system must comply with the Data Protection act.
<br></br> &nbsp&nbsp&nbsp&nbsp 3.5.2 The system must comply with the Disability Discrimination act.



   </div>
	
	<div id="footer">
		<p>Copyright &copy;Team 13</a> </p>
	</div>
</body>

</html>