<html>

<head>

<link rel="stylesheet" type="text/css" href="style.css" />

<title>Sunset Destinations</title>

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

<center>
<table>
<tr>
<td>

<?php

$passengers = $_COOKIE['noPassengers'];

if($_COOKIE['OutFlight'])
	{
	echo' <br>
	<u>Your Current Outbound Flight:</u>
	<br><br>';

	include("../../coa123-mysql-connect.php");
	$myconn2=mysql_connect("co-project.lboro.ac.uk",$username,$password);
	mysql_select_db("coa123db",$myconn2);

	$strSQL="SELECT * FROM flight where Id ='".$_COOKIE['OutFlight']."'";
			
	$result2=mysql_query($strSQL, $myconn2);

	while($row=mysql_fetch_array($result2))
		{
		$a1 = $row["DepartureDate"];
		$b1 = $row["DepartureTime"].' on '.substr($a1,8,2).'/'.substr($a1,5,2).'/08';
		$c1 = $row["ArrivalDate"];
		$d1 = $row["ArrivalTime"].' on '.substr($a1,8,2).'/'.substr($a1,5,2).'/08';         
		$outprice = $row["Fare"];
		$totalOut = $outprice * $passengers;
		
		echo '
		Departure Airport: '.$row["DepartureAirport"].'<br>
		Arrival Airport: '.$row["DestinationAirport"].'<br>
		Departure Time: '.$b1.'<br>
		Arrival Time: '.$d1.'<br>
		Airline: '.$row["Airline"].'<br>
		Cost (PerPerson): &pound;'.$row["Fare"].'<br>
		Number of passengers: '.$passengers.'<br>
		Total for outbound flights: &pound;'.$totalOut;
		}
	}

echo '</td><td width = "12%"></td><td>';

if($_COOKIE['hotelChosen'])
	{
	echo '<br><u>Hotel:</u> <br><br>';

	$single = $_COOKIE['singleRooms'];
	$double = $_COOKIE['doubleRooms'];
	$stay = $_COOKIE['stay'];
	$date = $_COOKIE['dateHotel'];


	include("../../coa123-mysql-connect.php");
	$myconn2=mysql_connect("co-project.lboro.ac.uk",$username,$password);
	mysql_select_db("coa123db",$myconn2);

	$strSQL="SELECT * FROM hotel where Id ='".$_COOKIE['hotelChosen']."'";
        
	$result2=mysql_query($strSQL, $myconn2);

	while($row=mysql_fetch_array($result2))
		{
		$price = 0;
		if($single != 'None'){
		$singleP = $row["SingleRoom"];
		$price = $price + ($single*$singleP);
		}else{$single=0;};
		
		if($double != 'None'){
		$doubleP = $row["DoubleRoom"];
		$price = $price + ($double*$doubleP);
		}else{$double=0;};
		
		$totalP = $price*$stay;

		echo $row["Resort"].' at '.$row["WebAddress"].'<br>
		Number of Rooms: '.($single+$double).'<br>
		Cost of Rooms per night: &pound;'.$price.'<br>
		Check-in date: '.$date.'<br>
		Check-out date: '.$_COOKIE["dateHotel2"].'<br>
		Price per night: &pound;'.$price.'<br>
		Length of stay: '.$stay.'<br>
		Total Cost for Hotel: &pound;'.$totalP;
		}
	}

echo '</td><td width = "12%"></td><td>';

if($_COOKIE['InFlight'])
	{
	echo '<br>
	<u>Your Current Inbound Flight:</u>
	<br><br>';

	include("../../coa123-mysql-connect.php");
	$myconn2=mysql_connect("co-project.lboro.ac.uk",$username,$password);
	mysql_select_db("coa123db",$myconn2);

	$strSQL="SELECT * FROM flight where Id ='".$_COOKIE['InFlight']."'";
        
	$result2=mysql_query($strSQL, $myconn2);

	while($row=mysql_fetch_array($result2))
		{
		$a2 = $row["DepartureDate"];
		$b2 = $row["DepartureTime"].' on '.substr($a2,8,2).'/'.substr($a2,5,2).'/08';
		$c2 = $row["ArrivalDate"];
		$d2 = $row["ArrivalTime"].' on '.substr($a2,8,2).'/'.substr($a2,5,2).'/08';         
		$inprice = $row["Fare"];
		$totalIn = $inprice * $passengers;
		
		echo '
		Departure Airport: '.$row["DepartureAirport"].'<br>
		Arrival Airport: '.$row["DestinationAirport"].'<br>
		Departure Time: '.$b2.'<br>
		Arrival Time: '.$d2.'<br>
		Airline: '.$row["Airline"].'<br>
		Cost (PerPerson): &pound;'.$row["Fare"].'<br>
		Number of passengers: '.$passengers.'<br>
		Total for inbound flights: &pound;'.$totalIn;
		}
	}

$one = 0;
$two = 0;
$three = 0;

echo 
'</td></tr></table></center><br><br>';
if($_COOKIE['OutFlight'] || $_COOKIE['hotelChosen'] || $_COOKIE['InFlight']){echo '<u>Summary:</u><br><br>';};
if($_COOKIE['OutFlight']){echo'Outbound flight = &pound;'.$totalOut.'<br>';$one = $totalOut;};
if($_COOKIE['hotelChosen']){echo 'Hotel Price = &pound;'.$totalP.'<br>';$three = $totalP;};
if($_COOKIE['InFlight']){echo 'Inbound flight = &pound;'.$totalIn.'<br>';$two = $totalIn;};

if($_COOKIE['OutFlight'] || $_COOKIE['hotelChosen'] || $_COOKIE['InFlight']){echo '<br> Total = &pound;'.($one+$two+$three);};



if($_COOKIE['OutFlight']||$_COOKIE['InFlight']||$_COOKIE['hotelChosen']){}else{
echo '<br><br><i>You currently have nothing in your itinerary</i>';
}


?>


</div>


<br>
<div class="bottom">
Copyright Sunset Destinations 2010.  Webmaster: Peter Krepa
</div>




</body>

</html>