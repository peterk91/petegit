<!--
This page checks tells the user their login details are incorrect
Written by Peter Krepa
--!>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>Loughborough University Room Booking System</title>
<link href="../style/loginstyle.css" rel="stylesheet" type="text/css"/>
</head>


<body>

<?php 	session_start();
unset($_SESSION['mySessionVar']); 
?>

<div id="page">

	
	<h1>Welcome! Please Login:</h1>

<img src="images/lulogo.gif" />
	
	<br><br>	<br><br>	<br><br>	
	<p id = "error"><i> Sorry the username and password you entered do not match/do not exist. </i></p>
		<form name="form1" method="post" action="logincheck.php">
  <p>
    <label for="username">Username: </label>
    <input type="text" name="myusername" id="myusername">
	
  </p>
  <br>
  <p>
    <label for="password">Password</label>
    : 
    <input type="password" name="mypassword" id="mypassword">
  </p>
<br>
<input type="submit" name="Submit" value="Login" />
</form>

		
		</div>
</div>



<div id="footer">
<p>Loughborough University Computer science Group 13</p>
</div>


</body>
</html>
