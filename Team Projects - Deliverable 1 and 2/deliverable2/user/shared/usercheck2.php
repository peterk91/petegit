<!--this script ensures the user is logged in
Written By Peter Krepa--!>
<?php	
session_start();
if(isset($_SESSION['systemlogged1'])){}
else{header("Location: ../login.php");}
?>