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
        	<li class="current_page_item"><a href="roundinfo.php">Round Information</a></li>
			<li><a href="summary.php">My Summary</a></li>
			<li><a href="help.php">Contact / Help</a></li>
			<li><a href="../login.php">Logout</a></li>
 		</ul>
</div>


<div id="roundpage">
	<div id="content">
		<p align="center"><strong><em>Round Information</em></strong></p>
        
        
        
        <?php 
				$myconn2=mysql_connect("co-project.lboro.ac.uk",team13,b7c8pbvc);
				mysql_select_db("team13",$myconn2);
				$today = date("Y-m-d");
				$strSQL="SELECT * FROM RoundClosing WHERE Open<'".$today."' AND Close>'".$today."'";
				$result2=mysql_query($strSQL, $myconn2);
				$pointer=0;
				while($row=mysql_fetch_array($result2)){
					$pointer = '1';
					echo '<p align="left"><strong>Current Round: </strong>'.$row["Round"].": </b>";
					echo " <em> Closes on ".$row["Close"]."</i> ";
					echo "<br></br>";
				}
				if($pointer=='0'){
					echo'<i>none</i>';
				}
			?>
            <p align="left"><strong>Closed Rounds: </strong>
            <?php 
				$myconn2=mysql_connect("co-project.lboro.ac.uk",team13,b7c8pbvc);
				mysql_select_db("team13",$myconn2);
				$today = date("Y-m-d");
				$strSQL="SELECT * FROM RoundClosing WHERE Close<'".$today."'";
				$result2=mysql_query($strSQL, $myconn2);
				$pointer=0;
				while($row=mysql_fetch_array($result2)){
					$pointer = '1';
					echo '<br></br>'.$row["Round"].": </b>";
					echo " <em> Closed on ".$row["Close"]."</i> ";
				}
				if($pointer=='0'){
					echo'<i>none</i>';
				}
			?>
            <br></br><p align="left"><strong>Upcoming Rounds</strong>:</p>
             <?php 
				$myconn2=mysql_connect("co-project.lboro.ac.uk",team13,b7c8pbvc);
				mysql_select_db("team13",$myconn2);
				$today = date("Y-m-d");
				$strSQL="SELECT * FROM RoundClosing WHERE Open>'".$today."'";
				$result2=mysql_query($strSQL, $myconn2);
				$pointer=0;
				while($row=mysql_fetch_array($result2)){
					$pointer = '1';
					echo '<br></br>'.$row["Round"].": </b>";
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
