<html>
<?php include 'php/usercheck.php'; ?>
<head>
<title>Loughborough University Room Booking System</title>
<link href="../style.css" rel="stylesheet" type="text/css"/>
</head>

<body>
<?php include 'php/header.php'; ?>
<div id="menu">
		<BR>
		<ul>
			<li><a href="start.php">Home</a></li>
			<li><a href="bookings.php">Make A Booking</a></li>
        	<li><a href="roominfo.php">Room Information / Availibility</a></li>		
        	<li><a href="roundinfo.php">Round Information</a></li>
			<li<a href="summary.php">My Summary</a></li>
			<li class="current_page_item"><a href="help.php">Contact / Help</a></li>
			<li><a href="../login.php">Logout</a></li>
 		</ul>
</div>


<div id="helppage">
	<div id="content">
		<p align="center"><strong><em>Contact / Help</em></strong></p>
					<p align="left">The booking system works in rounds.	You	have a set amount of time for every round, before your entires are automatically submitted, unless you have already pre-submitted them.	The	rounds	consist	of:</p>
					<p align="left">Priority Round - In this round you are permitted to submit 10% of your bookings. You are advised to submit and short fat modules in this round.</p>
					<p align="left">First Round - In this round you must submit the rest of your bookings.</p>
					<p align="left">Second Round - In this round you may submit any remaining denied requests.</p>
					<p align="left">&nbsp;</p>
					<br></br>
					<p><b>Frequently Asked Questions</b><br></br>
					<p><b>1. Making a Booking</b>
					<br></br><b>1.1 How do i Add a new Module?</b> Select the Department for which the module is to become associated with using the drop down list.Using the radio buttons you can select 'New Module'. You can now enter the module Part, Code and Name in the required box's. The Module will now appear in the list of existing modules. You can select this as normal, see 1.2.
					<br></br><b>1.2 How do I select the module?</b> Choose your module Part, This will filter the list and limit the amount of modules you can select. If you select no preference, you will have a much larger list to look through. You can now view all the modules in this part, select your module from the list. If the module does not exist, you can create a new module, see 1.1. You can select either the Module code or the Module name, the related code or name will then be selected automatically. Then enter the amount of students participating in the module and book your room. see 1.3.
					<br></br><b>1.3 I know which room i want, can i select it without having to search through the facilities?</b> Chose the Prefered room button and select your room from the list. You can filter rooms by their area on campus, their building code or building name, you may then select the room and click make booking request.
					<br></br><b>1.4 How do i Book a room based on its facilities?</b> You can chose the type and style of room you want, simply select the facilities you require and all the matching rooms will appear along the left hand side. Try not to chose too many options because this wil limit the available rooms and therefore limit your chances of securing this booking.
					</p>
					<p align="center">If you are experiencing any issues with the system please contact at: timetable@lboro.ac.uk</p>


	</div>
</div>



<div id="footer">
<p>Loughborough University Computer science Group 13</p>
</div>


</body>
</html>
