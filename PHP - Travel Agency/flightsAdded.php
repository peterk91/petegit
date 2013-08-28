<html>

<head>

<link rel="stylesheet" type="text/css" href="style.css" />

<title>Sunset Destinations</title>

<?php
setcookie("noPassengers", $_REQUEST['passengers']);
$out = $_REQUEST['outbound'];
$in = $_REQUEST['inbound'];
setcookie("OutFlight", $out);
setcookie("InFlight", $in);

include("../../coa123-mysql-connect.php");
$myconn2=mysql_connect("co-project.lboro.ac.uk",$username,$password);
mysql_select_db("coa123db",$myconn2);
$strSQL="SELECT * FROM flight where Id ='".$out."'";
$result2=mysql_query($strSQL, $myconn2);
while($row=mysql_fetch_array($result2))
		{
		$date1 = $row["DepartureDate"];
		}

$strSQL="SELECT * FROM flight where Id ='".$in."'";
$result2=mysql_query($strSQL, $myconn2);
while($row=mysql_fetch_array($result2))
		{
		$date2 = $row["DepartureDate"];
		}

setcookie("dateOut", $date1);
setcookie("dateIn", $date2);

?>

<script src="http://ajax.googleapis.com/ajax/libs/jquery/1/jquery.js" type="text/javascript"></script>

<script type="text/javascript">

$(document).ready(function(){$("#basket").load('itincorner.php');})

</script>

</head>

<body>

<table width="100%">

<tr>

<td width="67%">

<div class="top">

<img src="logo.jpg" style='border: 1px solid black'>
	
</div>

</td>

<td width="33%">

<div class="top" id="basket">

</div>

</td></tr>

</table>

<br>

<div class="navi">
<a href="start.php">Home</a>
&nbsp;&nbsp;&nbsp; 
<a href="flightBooking.php">Book your flights</a>
&nbsp;&nbsp; &nbsp; 
<a href="hotelBooking.php">Book your hotel</a>
&nbsp;&nbsp;&nbsp; 
<a href="itinerary.php">Check your itinery</a>
</div>

<br>

<div class="main">

<i>Your flight selection has been added to your basket!</i>

</div>


<br>
<div class="bottom">
Copyright Sunset Destinations 2010.  Webmaster: Peter Krepa
</div>




</body>

</html>