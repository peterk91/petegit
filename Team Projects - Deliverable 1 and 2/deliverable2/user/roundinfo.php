<!--
This tells the user about the current rounds in which bookings can be made
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
        	<li class="current_page_item"><a href="roundinfo.php">Round Information</a></li>
			<li><a href="summary/main.php">My Summary</a></li>
			<li><a href="help.php">Contact / Help</a></li>
			<li><a href="../login.php">Logout</a></li>
 		</ul>
</div>


<div id="roundpage">
	<div id="content">
		<p align="center"><strong><em>Round Information</em></strong></p>
        
        
        <p align="left"><strong><u>Current Rounds:</u> </strong><br></br>
        <?php 
				$myconn2=mysql_connect("co-project.lboro.ac.uk",team13,b7c8pbvc);
				mysql_select_db("team13",$myconn2);
				$today = date("Y-m-d");
				$strSQL="SELECT * FROM RoundClosing INNER JOIN Semester ON RoundClosing.SemesterID = Semester.SemesterID WHERE RoundClosing.Open<='".$today."' AND RoundClosing.Close>'".$today."'";
				$result2=mysql_query($strSQL, $myconn2);
				$pointer=0;
				while($row=mysql_fetch_array($result2)){
					$pointer = 1;
					echo " <b>  ".$row["Name"]."</b> ";
					echo ''.$row["Round"].": </b>";
					echo " <em> Closes on ".$row["Close"]."</i> ";

					echo "<br></br>";
				}
				if($pointer=='0'){
					echo'<i>none</i>';
				}
			?>
            <p align="left"><strong><u>Closed Rounds: </u> </strong>
            <?php 
				$myconn2=mysql_connect("co-project.lboro.ac.uk",team13,b7c8pbvc);
				mysql_select_db("team13",$myconn2);
				$today = date("Y-m-d");
				$strSQL="SELECT * FROM RoundClosing INNER JOIN Semester ON RoundClosing.SemesterID = Semester.SemesterID WHERE RoundClosing.Close<'".$today."'";
				$result2=mysql_query($strSQL, $myconn2);
				$pointer=0;
				while($row=mysql_fetch_array($result2)){
					$pointer = '1';
					echo " <br><b>  ".$row["Name"]."</b> ";
					echo ''.$row["Round"].": </b>";
					echo " <em> Closed on ".$row["Close"]."</i> ";

				}
				if($pointer=='0'){
					echo'<i>none</i>';
				}
			?>
            <p align="left"><strong><u>Upcoming Rounds:</u> </strong>
             <?php 
				$myconn2=mysql_connect("co-project.lboro.ac.uk",team13,b7c8pbvc);
				mysql_select_db("team13",$myconn2);
				$today = date("Y-m-d");
				$strSQL="SELECT * FROM RoundClosing INNER JOIN Semester ON RoundClosing.SemesterID = Semester.SemesterID WHERE RoundClosing.Open>'".$today."'";
				$result2=mysql_query($strSQL, $myconn2);
				$result2=mysql_query($strSQL, $myconn2);
				$pointer=0;
				while($row=mysql_fetch_array($result2)){
					$pointer = '1';
					echo "<br> <b>  ".$row["Name"]."</b> ";
					echo ''.$row["Round"].": </b>";
					echo " <em> Opens on ".$row["Open"]."</i> ";

				}
				if($pointer=='0'){
					echo'<i>none</i>';
				}
			?>
            


	</div>
</div>



<div id="footer">
<p>Loughborough University Computer science Group 13</p>
</div>


</body>
</html>
