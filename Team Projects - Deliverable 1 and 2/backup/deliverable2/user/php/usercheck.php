<?php	
session_start();
if(isset($_SESSION['systemlogged1'])){}
else{header("Location: ../login.php");}
?>