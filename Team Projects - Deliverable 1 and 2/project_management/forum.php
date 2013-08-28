
<html xmlns="http://www.w3.org/1999/xhtml">

<head profile="http://gmpg.org/xfn/11">
	<title>Project Management Website - Team 13</title>	
	<link rel="shortcut icon" href="image/favicon.ico" />
	<link rel="stylesheet" href="../style/pmwstyle.css" type="text/css" media="screen" />
	<meta http-equiv="content-type" content="text/html; charset=utf-8" />
	<meta http-equiv="content-language" content="en-gb" />
	<meta http-equiv="imagetoolbar" content="false" />
<link href="pmwstyle.css" rel="stylesheet" type="text/css">
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
	
			
		</div>
	</center>
	</div>

<center><p> Latest Announcement: The forum has been Updated. All Comments should now be made in the right place. <br>If you notice any problems, please report them to me as soon as possible. Thanks, Alex.</center>
<br><br><br>
<div id="general">
			<?php 
				$myconn2=mysql_connect("co-project.lboro.ac.uk",team13,b7c8pbvc);
				mysql_select_db("team13",$myconn2);
				$strSQL="SELECT Date, UserID,Directory FROM Forum WHERE (Date= (select MAX(Date) FROM Forum AS s WHERE s.Directory = 'General'))";
				$result2=mysql_query($strSQL, $myconn2);
				while($row=mysql_fetch_array($result2)){
					echo '<center><b><p><a href= forumgen.php>General Discussion</a></b>';
					echo " <i>(".$row["Date"].")</i> - ".$row["UserID"]." ";
					echo "</p><br></br>";
				}
			?>
<?php 
				$myconn2=mysql_connect("co-project.lboro.ac.uk",team13,b7c8pbvc);
				mysql_select_db("team13",$myconn2);
				$strSQL="SELECT Date, UserID,Directory FROM Forum WHERE (Date= (select MAX(Date) FROM Forum AS s WHERE s.Directory = 'Objectives'))";
				$result2=mysql_query($strSQL, $myconn2);
				while($row=mysql_fetch_array($result2)){
					echo '<center><b><p><a href= forumobj.php>Objectives</a></b>';
					echo " <i>(".$row["Date"].")</i> - ".$row["UserID"]." ";
					echo "</p><br></br>";
				}
			?>
<?php 
				$myconn2=mysql_connect("co-project.lboro.ac.uk",team13,b7c8pbvc);
				mysql_select_db("team13",$myconn2);
				$strSQL="SELECT Date, UserID,Directory FROM Forum WHERE (Date= (select MAX(Date) FROM Forum AS s WHERE s.Directory = 'Requirements'))";
				$result2=mysql_query($strSQL, $myconn2);
				while($row=mysql_fetch_array($result2)){
					echo '<center><b><p><a href= forumreq.php>Requirements</a></b>';
					echo " <i>(".$row["Date"].")</i> - ".$row["UserID"]." ";
					echo "</p><br></br>";
				}
			?>

<?php 
				$myconn2=mysql_connect("co-project.lboro.ac.uk",team13,b7c8pbvc);
				mysql_select_db("team13",$myconn2);
				$strSQL="SELECT Date, UserID,Directory FROM Forum WHERE (Date= (select MAX(Date) FROM Forum AS s WHERE s.Directory = 'Planned'))";
				$result2=mysql_query($strSQL, $myconn2);
				while($row=mysql_fetch_array($result2)){
					echo '<center><b><p><a href= forumwp.php>Work Planned</a></b>';
					echo " <i>(".$row["Date"].")</i> - ".$row["UserID"]." ";
					echo "</p><br></br>";
				}
			?>



<?php 
				$myconn2=mysql_connect("co-project.lboro.ac.uk",team13,b7c8pbvc);
				mysql_select_db("team13",$myconn2);
				$strSQL="SELECT Date, UserID,Directory FROM Forum WHERE (Date= (select MAX(Date) FROM Forum AS s WHERE s.Directory = 'Outputs'))";
				$result2=mysql_query($strSQL, $myconn2);
				while($row=mysql_fetch_array($result2)){
					echo '<center><b><p><a href= forumout.php>Outputs</a></b>';
					echo " <i>(".$row["Date"].")</i> - ".$row["UserID"]." ";
					echo "</p><br></br>";
				}
			?>



		
		</div>


        	<div id="footer">
	  <p>Copyright &copy; <a href="#">Team 13</a> </p>
	</div>
</body>

</html>