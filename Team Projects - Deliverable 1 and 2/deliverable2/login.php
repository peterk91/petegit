<!--
This page lets the user log in
Written by Peter Krepa and Alex Chidlaw
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
unset($_SESSION['systemlogged1']); 
?>

<div id="page">

	
	<h1>Welcome! Please Login:</h1>

<img src="images/lulogo.gif" alt="logo"/>
	
	<br/><br/>	<br/><br/>	<br/><br/>	
		<form name="form1" method="post" action="logincheck.php">
  <p>

 <label for="myusername">Username:</label>
    <input type="text" name="myusername" id="myusername"/>
	
  </p>
  <br/>
  <p>
 <label for="mypassword">
    Password: </label>
    <input type="password" name="mypassword" id="mypassword"/>
  </p>
<br/>
<input type="submit" name="Submit" value="Login" />
</form>

		

</div>



<div id="footer">
<p>Loughborough University Computer science Group 13</p>
</div>


</body>
</html>
