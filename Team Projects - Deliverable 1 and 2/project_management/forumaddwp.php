<html>

<head>

<script src="http://ajax.googleapis.com/ajax/libs/jquery/1/jquery.js" type="text/javascript"></script>

</head>

<body>

<?php session_start();
	$comment = $_REQUEST['comment'];
	$username = $_SESSION['mySessionVar2'];
	$myconn2=mysql_connect("co-project.lboro.ac.uk",team13,b7c8pbvc);
	mysql_select_db("team13",$myconn2);
	
	$strSQL='INSERT INTO Forum(UserID,Comment,Directory) VALUES ("'.$username.'","'.$comment.'","Planned")';
   	mysql_query($strSQL, $myconn2);
	$check=0;	
	header("Location:forumwp.php");
?>




</body>
</html>