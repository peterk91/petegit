
<html xmlns="http://www.w3.org/1999/xhtml">

<head profile="http://gmpg.org/xfn/11">
	<title>Project Management Website - Team 13</title>	
	<link rel="shortcut icon" href="image/favicon.ico" />
	<link rel="stylesheet" href="../style/pmwstyle.css" type="text/css" media="screen" />
	<meta http-equiv="content-type" content="text/html; charset=utf-8" />
	<meta http-equiv="content-language" content="en-gb" />
	<meta http-equiv="imagetoolbar" content="false" />
</head>


	<script type="text/javascript">
	</script>
	

<?php 	session_start();



if(isset($_SESSION['mySessionVar2'])){}else{
    header("Location:login.php");
} 


?>
<body>
	<div id="header">
		<h1>Project Management</h1>
		<h2>Team 13</h2>
	</div>
	<div id="navigation">
		<ul>
			<li<a href="pmhome.php">Home</a></li>
			<li><a href="team.php">The Team</a></li>
        	<li><a href="requirements.php">Requirements</a></li>
        	<li><a href="output.php">Output</a></li>
			<li><a href="planned.php">Work Planned</a></li>
			<li class="active"><a href="forum.php">Forum</a></li>
			<li><a href="login.php">Logout</a></li>
		</ul>
	</div>
	<div id="content">
	<center>
	<br></br>
		<form method="post" action="forumaddobj.php">
			<input type="text" style = " width: 300px; height: 50px" name="comment" value="Please enter your comment here and click submit.">
			<br><br>
			<input type="submit" style = " color:#050; font: bold small 'trebuchet ms',helvetica,sans-serif; "name="submit" value="Submit" />
		</form>
		<br><br><br>
		<div id="forum">
			<?php 
				$myconn2=mysql_connect("co-project.lboro.ac.uk",team13,b7c8pbvc);
				mysql_select_db("team13",$myconn2);
				$strSQL="SELECT * FROM Forum WHERE directory = 'Objectives' ORDER BY Date DESC";
				$result2=mysql_query($strSQL, $myconn2);
				while($row=mysql_fetch_array($result2)){
					echo '<b>'.$row["UserID"].": </b>";
					echo $row["Comment"];
					echo " <i>(".$row["Date"].")</i> ";
					echo "<br></br>";
				}
			?>
		</div>
	</center>
	</div>
	
	<div id="footer">
		<p>Copyright &copy; <a href="#">Team 13</a> </p>
	</div>
</body>

</html>