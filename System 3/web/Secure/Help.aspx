<%@ Page Title="" Language="C#" MasterPageFile="~/Site.master" AutoEventWireup="true" CodeFile="Help.aspx.cs" Inherits="Secure_Help" %>
<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" Runat="Server">
    <style type="text/css">
        .style1
        {
            font-size: large;
        }
        .style2
        {
            text-align: center;
        }
    </style>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" Runat="Server">

<div class="style2">
    <strong><em><span class="style1">Help / Contact</span></em></strong>
</div>

<br />
<p>The booking system works in rounds. You have a set amount of time for every round, 
before your entires are automatically submitted, unless you have already pre-submitted them. 
The rounds consist of:</p>

<p>Priority Round - In this round you are permitted to submit 10% of your bookings. 
You are advised to submit and short fat modules in this round.</p>

<p>First Round - In this round you must submit the rest of your bookings.</p>

<p>Second Round - In this round you may submit any remaining denied requests.</p>
<br />

<p><b>Frequently Asked Questions</b></p>
<ol>
    <li><a href="#Booking">Make a Request</a></li>
    <li><a href="#Module">Module Management</a></li>
    <li><a href="#RoomInfo">Room Information</a></li>
    <li><a href="#Summary">My Requests</a></li>
</ol>
<br />
<p>
    <b><a id="Booking">1. Make a Request</a></b>
    <br />
	<br /><b>1.1 I can't find the module in the list?</b> You may need to create a new module, to do this, select the Module Management tab at the top of the page.
	<br /><b>1.2 I know which room i want, can i select it without having to search through the facilities?</b> Yes, to do this just select your room from the list under Room Selection. You can filter rooms by their area on campus, their building code or building name. You may then select the room and click Submit Booking.
	<br /><b>1.3 I don't know which room i want, how do i find the best room for me?</b> You can choose the type and style of room you want, simply select the facilities you require and click on Update Room Selection in the bottom right square. All the matching rooms will then appear in the box below. Try not to choose too many options because this will limit the available rooms and therefore limit your chances of securing this booking.
	<br /><b>1.4 I can't find a room with a large enough capacity?</b> Try selecting filter by number of students, this will enable you to only select rooms with a large enough capacity. If you still cannot find a room, try using less filter options or there may not be a room large enough.
	<br /><b>1.5 Why can i not select the first weeks in the semester?</b> If you are in the adhoc round these weeks may already have passed, to book for next semester, select the next semester option from the top of the page.
	<br /><b>1.6 What happens if i click on the timetable, am i booking the room?</b> No, you are simply filtering the rooms to show only available rooms for this time, you must click the button at the bottom of the page to confirm a room and submit your request and the administrator must approve your request before it is booked.
	<br /><b>1.7 How do i confirm my booking?</b> You must click the Submit Booking button at the bottom of the page to confirm a room and submit your request.
    <br /><br /><a href="Help.aspx">Back to Top</a>
</p>
<br />
<p>
    <b><a id="Module">2. Module Management</a></b>
    <br />
	<br /><b>2.1 Why can i only select 1 module code?</b> You can only select the module code for the department you are logged in as. 
    <br /><br /><a href="Help.aspx">Back to Top</a>
</p>
<br />
<p>
    <b><a id="RoomInfo">3. Room Information</a></b>
    <br />
	<br /><b>3.1 I have found the room i want, how do i book it?</b> To book the room, click the 'Request This Room' button in the Room Profile section of the page. You will be re-directed to the 'Make a Request' page. The room information will already be entered, you need to chose your times and click submit at the bottom of the page.
	<br /><b>3.2 What does the advanced filter options do?</b> Advanced filter options enable you to view the rooms by searching for facilities available. It is suggested that you do this if you wish to book a room with some neccessary requirements and some room requirements that are preferable. you can then see all the rooms with the necessary requirements and select the room with the most preferabe requirements.
	<br /><b>3.3 Why can i not click on the timetable to book a room?</b> This timetable is not for booking rooms, it will display times for which the room is free. To book the room, click the book this room button and you will be re-directed to the bookings page.
	<br /><b>3.4 What do the red blocks mean?</b> Red blocks mean that this room has been booked out for the appropriate time slot, it is suggested that you chose another time when booking the room.
	<br /><b>3.5 The whole timetable is red can i still try to book the room?</b> It is not recomended, you should consider booking a different room. You can still try to book this room, however it is likely that the administrator will reject your request.
    <br /><br /><a href="Help.aspx">Back to Top</a>
</p>
<br />
<p>
    <b><a id="Summary">4. My Requests</a></b>
    <br />
	<br /><b>4.1 How do i view accepted/denied requests?</b> All requests can be viewed by clicking the My Requests tab at the top of the page.
	<br /><b>4.2 How do i delete an accepted request?</b> You can't, you must have permission to delete an already accepted request, if you wish to remove it, you must click the request release button, the administrator will then try to remove the request, however, this is not a guarantee.
	<br /><b>4.3 My request has been denied can i re-book a similar one straight away?</b> Yes, it is a good idea to re-book as soon as possible, once a request has been denied, you can click show alternatives to view the best possible alternative rooms.
    <br /><br /><a href="Help.aspx">Back to Top</a>
</p>
<br />
<p align="center"><i>If you are experiencing any issues with the system, 
    or the have questions that are still unanswered, please contact at: timetable@lboro.ac.uk</i>
</p>
<br />

</asp:Content>
