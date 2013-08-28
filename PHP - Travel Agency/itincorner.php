Itinerary Quickview:<br>

<?php
if($_COOKIE['OutFlight'])
{

include("../../coa123-mysql-connect.php");
        $myconn2=mysql_connect("co-project.lboro.ac.uk",$username,$password);
        mysql_select_db("coa123db",$myconn2);

        $strSQL="SELECT * FROM flight where Id ='".$_COOKIE['OutFlight']."'";
        
		$result2=mysql_query($strSQL, $myconn2);

        while($row=mysql_fetch_array($result2))
		{
		$a = $row["DepartureDate"];
		$b = substr($a,8,2).'/'.substr($a,5,2).'/08';
		$passengers = $_COOKIE['noPassengers'];
		$fare = $row["Fare"];
		echo $b.' - Flight - '.$row["DepartureAirport"].' to '.$row["DestinationAirport"].'- &pound;'.($fare*$passengers).'<br>';
		}
}

if($_COOKIE['hotelChosen'])
{

$single = $_COOKIE['singleRooms'];
$double = $_COOKIE['doubleRooms'];
$stay = $_COOKIE['stay'];

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
		};
		
		if($double != 'None'){
		$doubleP = $row["DoubleRoom"];
		$price = $price + ($double*$doubleP);
		};
		
		$totalP = $price*$stay;
		echo $_COOKIE["dateHotel"].' - Hotel Check-in - '.$row["Resort"].'<br>'.$_COOKIE["dateHotel2"].' - Hotel Check-out - &pound;'.$totalP.'<br>';
		};

}


if($_COOKIE['InFlight'])
{

include("../../coa123-mysql-connect.php");
        $myconn2=mysql_connect("co-project.lboro.ac.uk",$username,$password);
        mysql_select_db("coa123db",$myconn2);

        $strSQL="SELECT * FROM flight where Id ='".$_COOKIE['InFlight']."'";
        
		$result2=mysql_query($strSQL, $myconn2);

        while($row=mysql_fetch_array($result2))
		{
		$a = $row["DepartureDate"];
		$b = substr($a,8,2).'/'.substr($a,5,2).'/08';
		$passengers = $_COOKIE['noPassengers'];
		$fare = $row["Fare"];
		echo $b.' - Flight - '.$row["DepartureAirport"].' to '.$row["DestinationAirport"].'- &pound;'.($fare*$passengers).'<br>';
		}

}



if($_COOKIE['OutFlight']||$_COOKIE['InFlight']||$_COOKIE['hotelChosen']){
echo
'<br><a href="itinerary.php">Click here for your detalied itinerary</a>';
}
else
{
echo '<br><br><i>You currently have nothing in your itinerary</i>';
}

?>