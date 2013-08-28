<html>

<head>
<title>Project Management Website</title>
<link href="../style/loginstyle.css" rel="stylesheet" type="text/css"/>
</head>

<body>

<div id="page">

	
	<h1>Team 13's Project Management Login:</h1>
	
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



<div id="footer">
<p>Loughborough University Computer science Group 13</p>
</div>


</body>
</html>
