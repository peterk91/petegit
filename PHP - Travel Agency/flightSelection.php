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

<h2 align='center'>Travel Information</h2>

<form action="flightsAdded.php" method="post" onsubmit="return(validate())">

<center>
<table>
<tr>
<td VALIGN="TOP">

		<?
		$check2= 0;
		$date1 = $_REQUEST['day'];
		$date2 = $_REQUEST['month'];
		$date3 = $_REQUEST['year'];
		$depart= $_REQUEST['departure'];
		$arrive= $_REQUEST['arrival'];
		$airline= $_REQUEST['airline'];
		$passengers = $_REQUEST['passengers'];
				
		include("../../coa123-mysql-connect.php");
        $myconn2=mysql_connect("co-project.lboro.ac.uk",$username,$password);
        mysql_select_db("coa123db",$myconn2);

        $strSQL="SELECT * FROM flight where ";
		$strSQL = $strSQL."DepartureDate ='".$date3."-".$date2."-".$date1."'";

		if($depart!="Any"){$strSQL = $strSQL." AND DepartureAirport='".$depart."'";}
		else{$strSQL = $strSQL." AND (DepartureAirport='EastMindlands' OR DepartureAirport='Gatwick' OR DepartureAirport='Heathrow' OR DepartureAirport='Luton')";}		
		if($arrive!="Any"){$strSQL = $strSQL." AND DestinationAirport='".$arrive."'";}
		if($airline!="Any"){$strSQL = $strSQL." AND Airline='".$airline."'";}
        
		$result2=mysql_query($strSQL, $myconn2);
		$i=0;

        while($row=mysql_fetch_array($result2))
			{
			if($i==0){echo "<p>Below is a selection of outbound flights according to your criteria, <br> please choose the flight you would like and click 'Add to Itinerary': </p>";};
			$fare = $row["Fare"];
            echo 
			'Airline:'.$row["Airline"].'<br>
			Flight: '.$row["DepartureAirport"].' to '.$row["DestinationAirport"].'<br>
            Departing: '.$row["DepartureTime"].' on '.$row["DepartureDate"].'<br>
            Arriving: '.$row["ArrivalTime"].' on '.$row["ArrivalDate"].'<br>
            Cost =  &pound;'.$fare.'(pp) x '.$passengers.' =  &pound;'.($fare*$passengers).'<br>';
			if($i==0){echo 'Selection: <input type="radio" id="outbound" name="outbound" value="'.$row["Id"].'" checked/><br><br>'; $i = $i+1;}
			else{echo 'Selection: <input type="radio" id="outbound" name="outbound" value="'.$row["Id"].'"/><br><br>';};
			}
		if($i==0){echo '<center>There are no results according to the criteria you have chosen for your outbound flight.</center>'; $check2 = $check2 +1;};

echo '</td><td width="10%"></td><td VALIGN="TOP">';

		$date12 = $_REQUEST['day2'];
		$date22 = $_REQUEST['month2'];
		$date32 = $_REQUEST['year2'];
		$depart2= $_REQUEST['departure2'];
		$arrive2= $_REQUEST['arrival2'];
		$airline2= $_REQUEST['airline2'];
				
		include("../../coa123-mysql-connect.php");
        $myconn2=mysql_connect("co-project.lboro.ac.uk",$username,$password);
        mysql_select_db("coa123db",$myconn2);

        $strSQL="SELECT * FROM flight where ";
		$strSQL = $strSQL."DepartureDate ='".$date32."-".$date22."-".$date12."'";
		
		if($depart2!="Any"){$strSQL = $strSQL." AND DepartureAirport='".$depart2."'";}
		else{$strSQL = $strSQL." AND (DepartureAirport='Antalya' OR DepartureAirport='Bodrum' OR DepartureAirport='Istanbul' OR DepartureAirport='Izmir')";}
		if($arrive2!="Any"){$strSQL = $strSQL." AND DestinationAirport='".$arrive2."'";}
		if($airline2!="Any"){$strSQL = $strSQL." AND Airline='".$airline2."'";}
        
		$result2=mysql_query($strSQL, $myconn2);
		$i=0;
		
        while($row=mysql_fetch_array($result2))
			{
			if($i==0){echo "<p>Below is a selection of inbound flights according to your criteria, <br> please choose the flight you would like and click 'Add to Itinerary': </p>";};
			$fare = $row["Fare"];
            echo 
			'Airline:'.$row["Airline"].'<br>
			Flight: '.$row["DepartureAirport"].' to '.$row["DestinationAirport"].'<br>
            Departing: '.$row["DepartureTime"].' on '.$row["DepartureDate"].'<br>
            Arriving: '.$row["ArrivalTime"].' on '.$row["ArrivalDate"].'<br>
            Cost =  &pound;'.$fare.'(pp) x '.$passengers.' =  &pound;'.($fare*$passengers).'<br>';
			if($i==0){echo 'Selection: <input type="radio" id="inbound" name="inbound" value="'.$row["Id"].'" checked/><br><br>'; $i = $i+1;}
			else{echo 'Selection: <input type="radio" id="inbound" name="inbound" value="'.$row["Id"].'"/><br><br>';};
			}
		if($i==0){echo '<center>There are no results according to the criteria you have chosen for your inbound flight.</center>'; $check2 = $check2 +1;};
		echo '</td></tr></table></center>';
		if($check2<2){echo '<input type="submit" name="Submit" value="Add to Itinerary" />';};

		?>

<input type='hidden' name='passengers' value='<?php echo $_REQUEST['passengers'];?>' />

</form>

</div>

<br>

<div class="bottom">
Copyright Sunset Destinations 2010.  Webmaster: Peter Krepa
</div>
</body>
</html>