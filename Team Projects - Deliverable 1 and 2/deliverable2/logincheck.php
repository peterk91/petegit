<!--
This page checks the login credentials are correct
Written by Peter Krepa and Alex Chidlaw
--!>

<html>

<head>

<script src="http://ajax.googleapis.com/ajax/libs/jquery/1/jquery.js" type="text/javascript"></script>

</head>

<body>

<?php 	session_start();
	$myusername = $_REQUEST['myusername'];
	$mypassword = $_REQUEST['mypassword'];
	$myconn2=mysql_connect("co-project.lboro.ac.uk",team13,b7c8pbvc);
	mysql_select_db("team13",$myconn2);

	$strSQL="SELECT * FROM user_md5";
   	$result2=mysql_query($strSQL, $myconn2);
	$check=0;
	while($row=mysql_fetch_array($result2)){
	if($row["UserID"] == $myusername && $row["password"] == MD5($mypassword)){$check=1; $_SESSION['systemlogged1']=$row["UserID"]; }
	}
	
	if($check==1){header("location:user/start.php");}
	if($check==0){header("location:error.php");}	
?>



</body>
</html>