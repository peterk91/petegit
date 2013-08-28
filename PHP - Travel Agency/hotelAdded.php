<html>

<head>

<link rel="stylesheet" type="text/css" href="style.css" />

<title>Sunset Destinations</title>

<?php
$id = $_REQUEST['hotel'];
setcookie("hotelChosen", $id);

$stay = $_REQUEST['total'];
setcookie("stay", $stay );
setcookie("singleRooms", $_REQUEST['single']);
setcookie("doubleRooms", $_REQUEST['double']);

$temp = $_REQUEST['month'];
$temp2= $_REQUEST['day'];

$x = mktime(0,0,0,$temp,$temp2,2008);
$hotelStay = date("d/m/Y", $x);
setcookie("dateHotel", $hotelStay);

$x2 = mktime(0,0,0,$temp,$temp2+$stay,2008);
$hotelStay2 = date("d/m/Y", $x2);
setcookie("dateHotel2", $hotelStay2);
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

<i>Your hotel selection has been added to your basket</i>

</div>


<br>
<div class="bottom">
Copyright Sunset Destinations 2010.  Webmaster: Peter Krepa
</div>




</body>

</html>