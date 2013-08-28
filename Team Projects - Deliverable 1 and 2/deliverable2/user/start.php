<!--
This page welcomes the user to the system and shows updates from admin
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
			<li class="current_page_item"><a href="start.php">Home</a></li>
			<li><a href="bookings/main.php">Make A Booking</a></li>
        	<li><a href="roominfo/main.php">Room Information / Availibility</a></li>		
        	<li><a href="roundinfo.php">Round Information</a></li>
			<li><a href="summary/main.php">My Summary</a></li>
			<li><a href="help.php">Contact / Help</a></li>
			<li><a href="../login.php">Logout</a></li>
 		</ul>
</div>


<div id="startpage">
	<div id="content">
		<p align="center"><strong><em>Welcome to the Loughborough University Timetabling system. Please select a Link from the top bar.</em></strong></p>
		
<div id="leftsidestart">
<p align="justify"><strong>Booking System</strong> - This is where you can submit all your bookings for whichever round is currently open.</p>
		<p align="justify"><strong>Room Information</strong> - Here you can look up information about any room on campus.</p>
		<p align="justify"><strong>Round Information</strong> - Here is where you can find information on which round is currently open.</p>
		<p align="justify"><strong>Summary</strong> - Here is where you can find a list of all your submitted bookings and the status of them.</p>
		<p align="justify"><strong>Contact / Help</strong> - Here is where you can find extra information on how the system works and also contact details for if you need any further assistance.</p>
</div>


<div id="updates">
<?php 
				$myconn2=mysql_connect("co-project.lboro.ac.uk",team13,b7c8pbvc);
				mysql_select_db("team13",$myconn2);
				$strSQL="SELECT * FROM Updates WHERE Date= (select MAX(Date) FROM Updates)";
				$result2=mysql_query($strSQL, $myconn2);
				while($row=mysql_fetch_array($result2)){
					echo '<center><b><p>Latest Update:</p> </b>';
					echo " ".$row["Comment"]."<i>(".$row["Date"].")</i> - ".$row["Name"]." ";
					echo "</p><br></br>";
				}
			?>
            <center><b><p>Recent Updates:</p> </b>
            <?php 
				$myconn2=mysql_connect("co-project.lboro.ac.uk",team13,b7c8pbvc);
				mysql_select_db("team13",$myconn2);
				$strSQL="SELECT * FROM Updates WHERE Date != (select MAX(Date) FROM Updates)";
				$result2=mysql_query($strSQL, $myconn2);
				while($row=mysql_fetch_array($result2)){
					echo " ".$row["Comment"]."<i>(".$row["Date"].")</i> - ".$row["Name"]." ";
					echo "</p><br></br>";
				}
			?>
</div>

<p>
    <a href="http://jigsaw.w3.org/css-validator/check/referer">
        <img style="border:0;width:88px;height:31px"
            src="http://jigsaw.w3.org/css-validator/images/vcss"
            alt="Valid CSS!" />
    </a>
</p>





</div>
</div>




<div id="footer">
<p>Loughborough University Computer science Group 13</p>
</div>

</body>
</html>
