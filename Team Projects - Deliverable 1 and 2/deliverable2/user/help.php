<!--
This page gives the user extra help
Written by Alex Chidlaw
--!>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<?php include 'shared/usercheck2.php'; ?>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>Loughborough University Room Booking System</title>
<link href="../style.css" rel="stylesheet" type="text/css"/>
</head>

<body>
<?php include 'shared/header.php'; ?>
<div id="menu">
		<BR>
		<ul>
			<li><a href="start.php">Home</a></li>
			<li><a href="bookings/main.php">Make A Booking</a></li>
        		<li><a href="roominfo/main.php">Room Information / Availibility</a></li>		
        		<li><a href="roundinfo.php">Round Information</a></li>
			<li<a href="summary/main.php">My Summary</a></li>
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

					<p><b>Frequently Asked Questions</b><br></br>
					<p><b>1. Making a Booking</b>
					<br></br><b>1.1 I can't find the module in the list?</b>You may need to create a new module, to do this, select the Department for which the module is to become associated with using the drop down list.Using the radio buttons you can select 'New Module'. You can now enter the module Part, Code and Name in the required box's. The Module will now appear in the list of existing modules. You can select this as normal
					<br></br><b>1.2 I know which room i want, can i select it without having to search through the facilities?</b> Choose the Prefered room button and select your room from the list. You can filter rooms by their area on campus, their building code or building name, you may then select the room and click make booking request.
					<br></br><b>1.3 I don't know which room i want, how do i find the best room for me?</b> You can choose the type and style of room you want, simply select the facilities you require and all the matching rooms will appear along the left hand side. Try not to choose too many options because this wil limit the available rooms and therefore limit your chances of securing this booking.
					<br></br><b>1.4 I can't find a room with a large enough capacity?</b> Try selecting filter by number of students, this will enable you to only select rooms with a large enough capacity. If you still cannot find a room, try using less filter options or there may not be a room large enough.
					<br></br><b>1.5 All the rooms are booked, how do i find a free room?</b> Try selecting filter by Times chosen, this will enable you to only select rooms that have not already been booked.
					<br></br><b>1.6 Why can i not select the first weeks in the semester?</b> If you are in the adhoc round these weeks may already have passed, to book for next semester, select the next semester option from the top of the page.
					<br></br><b>1.6 What happens if i click on the timetable, am i booking the room?</b> No, you are simply filtering the rooms to show only available rooms for this time, you must click the button at the bottom of the page to confirm a room and submit your request and the administrator must approve your request before it is booked.
					<br></br><b>1.6 How do i confirm my booking?</b> You must click the button at the bottom of the page to confirm a room and submit your request.
					</br></p>
</br>
					<p><b>2. Room information/ Availability</b>
					<br></br><b>2.1 I have found the room i want, how do i book it?</b> To book the room, click the button at the bottom of the page. You will be re-directed to the 'make a booking' page. The room information will already be entered, you need to chose your times and click submit at the bottom of the page.
					<br></br><b>2.2 What does the advanced filter options do?</b> Advanced filter options enable you to view the rooms by searching for facilities available. It is suggested that you do this if you wish to book a room with some neccessary requirements and some room requirements that are preferable. you can then see all the rooms with the necessary requirements and select the room with the most preferabe requirements.
					<br></br><b>2.3 Why can i not click on the timetable to book a room?</b> This timetable is not for booking rooms, it will display times for which the room is free. To book the room, click the book this room button and you will be re-directed to the bookings page.
					<br></br><b>2.4 What do the red blocks mean?</b> Red blocks mean that this room has been booked out for the appropriate time slot, it is suggested that you chose another time when booking the room.
					<br></br><b>2.5 The whole timetable is red can i still try to book the room?</b> It is not recomended, you should consider booking a different room. You can still try to book this room, however it is likely that the administrator will reject your request.
</p>

					<p><br></br><b>3.Round Information</b>
					<br></br><b>3.1 Why does it say none under one of the rounds</b> If the administrator has not announced any new rounds or if the timetable is in transition between semesters, there may be no rounds currently available to book for.

					<p><br></br><b>4. My Summary</b>
					<br></br><b>4.1 How do i view accepted/ denied requests?</b> All requests can be viewed by clicking the arrow next to the type of requests.
					<br></br><b>4.2 Why are some of my requests orange, some green and some red?</b> Each colour reprisents the status of the request. Orange is a pending request, Green is an accepted request and red has been denied.
					<br></br><b>4.3 How do i delete an accepted request?</b> You can't, you must have permission to delete an already accepted request, if you wish to remove it, you must click the request release button, the administrator will then try to remove the request, however, this is not a guarantee.
					<br></br><b>4.4 My request has been denied can i re-book a similar one straight away</b> Yes, it is a good idea to re-book as soon as possible, once a request has been denied, you can click show alternatives to view the best possible alternative rooms.

					<br></br><i><p align="center">If you are experiencing any issues with the system, or the have questions that are still unanswered, please contact at: timetable@lboro.ac.uk</p>
</i>

	</div>
</div>



<div id="footer">
<p>Loughborough University Computer science Group 13</p>
</div>


</body>
</html>
