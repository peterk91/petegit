<html>

<head>

<link rel="stylesheet" type="text/css" href="style.css" />

<title>Sunset Destinations</title>

<script src="http://ajax.googleapis.com/ajax/libs/jquery/1/jquery.js" type="text/javascript"></script>

<script type="text/javascript">

$(document).ready(function(){$("#basket").load('itincorner.php');})

function validate()
	{
	
	ok1 = !(document.getElementById("single").value == 0 && document.getElementById("double").value == 0)
	if(!ok1)alert("You have not chosen any rooms, please do this before continuing.");

	temp1 = document.getElementById("hiddenOut").value
	temp2 = document.getElementById("hiddenIn").value
	
	if(temp1 != '' || temp2 != '')
		{
		stay = parseInt(document.getElementById("stay").value)
		var day = document.getElementById("day").value;
		var month = document.getElementById("month").value;
		}
	
	if(temp1 != '')
		{
		hotelDate1 = new Date();
		hotelDate1.setFullYear(2008, (month-1), day);

		var dateOut = temp1;
		var dayOut = dateOut.substr(8,2);
		var monthOut = dateOut.substr(5,2);
		var outDate = new Date();
		outDate.setFullYear(2008, (monthOut-1), dayOut)
		
		ok2 = hotelDate1 >= outDate
		}
	
	if(temp2 != '')
		{
		hotelDate2 = new Date();
		hotelDate2.setFullYear(2008, (month-1), day);
		hotelDate2.setDate(hotelDate2.getDate()+stay)

		var dateIn = temp2
		var dayIn = dateIn.substr(8,2);
		var monthIn = dateIn.substr(5,2);
		var inDate = new Date();
		inDate.setFullYear(2008, (monthIn-1), dayIn);
		
		ok3 = inDate >= hotelDate2
		}
		
	if(temp1 != '' || temp2 != '')
		{	
		if(!ok2 || !ok3)alert("Your chosen date is outside the time when your fly in and out of the country");
		}
		
	final = ok1 && ok2 && ok3
	
	return(final);
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

<h2>Booking your hotel:</h2>

<br>

<form action="hotelSelection.php" method="post" onsubmit="return(validate())">

Date of Arrival:

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

<br><br>

Number of Nights Required:

<select size="1" id="stay" name="total">
	<?php $array=array(1,2,3,4,5,6,7,8,9,10,11,12,13,14);
	foreach($array as $number){ echo "<option>$number</option>";}
	?>
</select>

<br><br>

Amount of Single Rooms Required:

<select size="1" name="single" id="single">
	<?php $array=array(0,1,2,3,4,5,6,7,8,9);
	foreach($array as $room){ echo "<option>$room</option>";}
	?>
</select>

&nbsp;&nbsp;&nbsp;&nbsp;

Amount of Double Rooms Required:

<select size="1" name="double" id="double">
	<?php $array=array(0,1,2,3,4,5,6,7,8,9);
	foreach($array as $room){ echo "<option>$room</option>";}
	?>
</select>

<br><br>

Preferred Resort Location:

<select size="1" name="location">
	<?php $array=array("Any","Antalya", "Bodrum", "Istanbul", "Izmir");
	foreach($array as $location){ echo "<option>$location</option>";}
	?>
</select>

<input type='hidden' id='hiddenOut' value='<?php echo $_COOKIE['dateOut'];?>' />
<input type='hidden' id='hiddenIn' value='<?php echo $_COOKIE['dateIn'];?>' />

<br><br>

</select>

<input type="submit" name="Submit" value="Submit"/>

</form>

</div>

<br>
<div class="bottom">
Copyright Sunset Destinations 2010.  Webmaster: Peter Krepa
</div>




</body>

</html>