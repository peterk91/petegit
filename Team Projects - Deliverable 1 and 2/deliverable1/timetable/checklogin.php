<html>

<head>

<script src="http://ajax.googleapis.com/ajax/libs/jquery/1/jquery.js" type="text/javascript"></script>

</head>

<body>

<?
$username = $_REQUEST['myusername'];
if($username=="jsmith1"){
header("location:user/start.html");}
if($username=="admin"){
header("location:admin/start.html");}?>


</body>
</html>