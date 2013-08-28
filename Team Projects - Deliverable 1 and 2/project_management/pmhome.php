<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">

<head profile="http://gmpg.org/xfn/11">
	<title>Project Management Website - Team 13</title>	
	<link rel="shortcut icon" href="image/favicon.ico" />
	<link rel="stylesheet" href="../style/pmwstyle.css" type="text/css" media="screen" />
	<meta http-equiv="content-type" content="text/html; charset=utf-8" />
	<meta http-equiv="content-language" content="en-gb" />
	<meta http-equiv="imagetoolbar" content="false" />
</head>
<?php 	session_start();



if(isset($_SESSION['mySessionVar2'])){}else{
    header("Location: login.php");
} 


?>
<body>
	<div id="header">
		<h1>Project Management</h1>
		<h2>Team 13</h2>
	</div>
	<div id="navigation">
		<ul>
			<li class="active"><a href="pmhome.php">Home</a></li>
			<li><a href="team.php">The Team</a></li>
        	<li><a href="requirements.php">Requirements</a></li>
        	<li><a href="output.php">Output</a></li>
			<li><a href="planned.php">Work Planned</a></li>
			<li><a href="forum.php">Forum</a></li>
			<li><a href="login.php">Logout</a></li>
		</ul>
	</div>
	
	<div id="content">
		<h1>Welcome <?php session_start(); echo $_SESSION['mySessionVar2']; ?>!</h1>
	<br>
	Welcome to Team 13's Project Management Website. <br><br>
	
	By using the links about you can read all information about the current status of our project, and view all objectives achieved.<br>
	You can view work for the first deliverable and also see information on the team.<br>
	Finally we have also included a forum where the team and project managers can discuss.
	
	</div>
	
	<div id="footer">
		<p>Copyright &copy; Team 13 </p>
	</div>
</body>

</html>