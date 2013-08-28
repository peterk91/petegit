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

<form action="hotelAdded.php" method="post">
         
<?
$location = $_REQUEST['location'];

include("../../coa123-mysql-connect.php");
$myconn2=mysql_connect("co-project.lboro.ac.uk",$username,$password);
mysql_select_db("coa123db",$myconn2);

$strSQL="SELECT * FROM hotel ";
if($location != 'Any'){$strSQL = $strSQL.'where Resort="'.$location.'"';}

$result2=mysql_query($strSQL, $myconn2);
$i=0;

while($row=mysql_fetch_array($result2))
		{
			if($i==0){echo "<p>Below is a selection of hotels according to your criteria, please choose the hotel you would like to book and click 'Add to Itineary': </p>";};
		$sP = $row["SingleRoom"];
		$sN = $_REQUEST['single'];
		$dP = $row["DoubleRoom"];
		$dN = $_REQUEST['double'];
		$length = $_REQUEST['total'];
		
            echo'
			Location: '.$row["Resort"].'<br> 
			Star: '.$row["Star"].' Score: '.$row["Score"].' Reviewer: '.$row["Reviewer"].'<br> 
			Website: <a href="'.$row["WebAddress"].'">'.$row["WebAddress"].'</a><br>
			Single Room per night: &pound;'.$sP.' &nbsp;&nbsp;&nbsp;
			Double Room per night: &pound;'.$dP.'<br>
			Price per night for your stay: &pound;'.(($sP*$sN)+($dP*$dN)).'<br>
			Total Price for your stay: &pound;'.((($sP*$sN)+($dP*$dN))*$length).'<br>';
			if($i==0){echo 'Selection: <input type="radio" name="hotel" value="'.$row["Id"].'"checked> <br><br>';$i = $i+1;}
			else{echo 'Selection: <input type="radio" name="hotel" value="'.$row["Id"].'"> <br><br>';};
        }
if($i==0){echo '<center>There are no results according to the criteria you have chosen</center>';}
else{echo '<input type="submit" name="Submit" value="Book Hotel" />';};
?>



<input type='hidden' name='total' value='<?php echo $_REQUEST['total'];?>' />
<input type='hidden' name='single' value='<?php echo $_REQUEST['single'];?>' />
<input type='hidden' name='double' value='<?php echo $_REQUEST['double'];?>' />
<input type='hidden' name='month' value='<?php echo $_REQUEST['month'];?>' />
<input type='hidden' name='day' value='<?php echo $_REQUEST['day'];?>' />

</form>

</div>

<br>

<div class="bottom">
Copyright Sunset Destinations 2010.  Webmaster: Peter Krepa
</div>
</body>
</html>