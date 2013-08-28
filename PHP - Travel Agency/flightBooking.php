<html>

<head>

<link rel="stylesheet" type="text/css" href="style.css" />

<title>Sunset Destinations</title>

<script src="http://ajax.googleapis.com/ajax/libs/jquery/1/jquery.js" type="text/javascript"></script>

<script type="text/javascript">

$(document).ready(function(){$("#basket").load('itincorner.php');})

function validate()
	{
	temp1 = document.getElementById("hiddenHotel").value;
	ok1 = 1==1;
	ok2 = 1==1;
	var dayOut = document.getElementById("day").value;
	var dayIn = document.getElementById("day2").value;
	var monthOut = document.getElementById("month").value;
	var outDate = new Date();
	outDate.setFullYear(2008, (monthOut-1), dayOut);
		
	var monthIn = document.getElementById("month2").value;		
	var inDate = new Date();
	inDate.setFullYear(2008, (monthIn-1), dayIn);
	
	if(temp1 != '')
		{
		var stay = parseInt(document.getElementById("hiddenTotal").value);

		var hotelDay = temp1.substr(0,2);
		var hotelMonth = temp1.substr(3,2);
		hotelDate1 = new Date();
		hotelDate1.setFullYear(2008, (hotelMonth-1), hotelDay);
		
		hotelDate2 = new Date();
		hotelDate2.setFullYear(2008, (hotelMonth-1), hotelDay);
		hotelDate2.setDate(hotelDate2.getDate()+stay);

		ok1 = hotelDate1 >=outDate;
		ok2 = inDate >= hotelDate2;
		}
	
	ok3 = inDate >= outDate
	
	if(!ok1)alert("You are currenty booked to stay in a hotel before your outbound flight date");
	if(!ok2)alert("You are currenty booked to stay in a hotel after your inbound flight date");
	if(!ok3)alert("You have selected an inbound flight which is before your outbound flight");

	ok = ok1 && ok2 && ok3;
	
	return(ok);
	}

function changeDate()
	{
	var month = document.getElementById("month").value
	var day = document.getElementById("day").value
	var days = document.getElementById("day").options
	
	if(month==1 || month==3 || month==5 || month==7 || month==8 || month==10 || month==12)
		{
		if(days.length==29)
			{
			document.getElementById("day").options[days.length] = new Option('30', '30');
			document.getElementById("day").options[days.length] = new Option('31', '31');
			}
		if(days.length==30)
			{
			document.getElementById("day").options[days.length] = new Option('31', '31');
			}
		}
	
	if(month==4 || month==6 || month==9 || month==11)
		{
		if(days.length==29)
			{
			document.getElementById("day").options[days.length] = new Option('30', '30');
			}
		if(days.length==31)
			{
			document.getElementById("day").remove(30)
			}
		}
	
	if(month==2)
		{
		if(days.length==30)
			{
			document.getElementById("day").remove(29)
			}
		if(days.length==31)	
			{
			document.getElementById("day").remove(30)
			document.getElementById("day").remove(29)
			}
		}
	}

function changeDate2()
	{
	var month = document.getElementById("month2").value
	var day = document.getElementById("day2").value
	var days = document.getElementById("day2").options
	
	if(month==1 || month==3 || month==5 || month==7 || month==8 || month==10 || month==12)
		{
		if(days.length==29)
			{
			document.getElementById("day2").options[days.length] = new Option('30', '30');
			document.getElementById("day2").options[days.length] = new Option('31', '31');
			}
		if(days.length==30)
			{
			document.getElementById("day2").options[days.length] = new Option('31', '31');
			}
		}
	
	if(month==4 || month==6 || month==9 || month==11)
		{
		if(days.length==29)
			{
			document.getElementById("day2").options[days.length] = new Option('30', '30');
			}
		if(days.length==31)
			{
			document.getElementById("day2").remove(30)
			}
		}
	
	if(month==2)
		{
		if(days.length==30)
			{
			document.getElementById("day2").remove(29)
			}
		if(days.length==31)	
			{
			document.getElementById("day2").remove(30)
			document.getElementById("day2").remove(29)
			}
		}
	}



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

<br>

<h2>Booking your flights:</h2>

<br>

<form action="flightSelection.php" method="post" onsubmit="return(validate())">

Number of passengers:

<select size="1" name="passengers">
	<?php $array=array(1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20);
	foreach($array as $passengers){ echo "<option>$passengers</option>";}
	?>
</select>

<br><br>
<center>
<table>
<tr>
<td>

Preferred Outbound departure aiport:

<select size="1" name="departure">
	<?php $array=array("Any","EastMindlands", "Gatwick", "Heathrow", "Luton");
	foreach($array as $departure){ echo "<option>$departure</option>";}
	?>
</select>

<br><br>

Preferred Outbound arrival aiport:

<select size="1" name="arrival">
	<?php $array=array("Any","Antalya", "Bodrum", "Istanbul", "Izmir");
	foreach($array as $arrival){ echo "<option>$arrival</option>";}
	?>
</select>

<br><br>

Preferred Outbound Airline:

<select size="1" name="airline">
	<?php $array=array("Any","British Airways", "EasyJet", "FirstChoice");
	foreach($array as $airline){ echo "<option>$airline</option>";}
	?>
</select>

<br><br>

Preferred Outbound Flight Date:?


<select size="1" id="day" name="day">
	<?php $array=array(1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30,31);
	foreach($array as $date){ echo "<option>$date</option>";}
	?>
</select>

<select size="1" id="month" name="month" onchange="changeDate()">
	<?php $array=array(1,2,3,4,5,6,7,8,9,10,11,12);
	foreach($array as $date){echo "<option>$date</option>";}
	?>
</select>

<select size="1" name="year">
	<?php $array=array(2008); 
	foreach($array as $date){echo "<option>$date</option>";}
	?>
</select>


</td>
<td width='20%'>
</td>
<td>


Preferred Inbound departure aiport:

<select size="1" name="departure2">
	<?php $array=array("Any","Antalya", "Bodrum", "Istanbul", "Izmir");
	foreach($array as $departure){ echo "<option>$departure</option>";}
	?>
</select>

<br><br>

Preferred Inbound arrival aiport:

<select size="1" name="arrival2">
	<?php $array=array("Any","EastMindlands", "Gatwick", "Heathrow", "Luton");
	foreach($array as $arrival){ echo "<option>$arrival</option>";}
	?>
</select>

<br><br>

Preferred Inbound Airline:

<select size="1" name="airline2">
	<?php $array=array("Any","British Airways", "EasyJet", "FirstChoice");
	foreach($array as $airline){ echo "<option>$airline</option>";}
	?>
</select>

<br><br>

Preferred Inbound Flight Date:?

<select size="1" id="day2" name="day2">
	<?php $array=array(1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30,31);
	foreach($array as $date){ echo "<option id='$date'>$date</option>";}
	?>
</select>

<select size="1" id="month2" name="month2" onchange="changeDate2()">
	<?php $array=array(1,2,3,4,5,6,7,8,9,10,11,12);
	foreach($array as $date){echo "<option>$date</option>";}
	?>
</select>

<select size="1" name="year2">
	<?php $array=array(2008); 
	foreach($array as $date){echo "<option>$date</option>";}
	?>
</select>

</td>
</tr>
</table>
</center>
<br><br>

<input type='hidden' id='hiddenHotel' value='<?php echo $_COOKIE['dateHotel'];?>' />
<input type='hidden' id='hiddenTotal' value='<?php echo $_COOKIE['stay'];?>' />

<input type="submit" name="Submit" value="Submit" />

</form>
  
</div>

<br>

<div class="bottom">
Copyright Sunset Destinations 2010.  Webmaster: Peter Krepa
</div>

</body>
</html>
