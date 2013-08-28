<html>

<head>

<script src="http://ajax.googleapis.com/ajax/libs/jquery/1/jquery.js" type="text/javascript"></script>

</head>

<body>

<?php 	session_start();
	$myconn2=mysql_connect("co-project.lboro.ac.uk",team13,b7c8pbvc);
	mysql_select_db("team13",$myconn2);
	$random = "INSERT INTO user_md5 VALUES ('Jack',MD5('Jack') );";
	mysql_query($random, $myconn2);
?>




</body>
</html>