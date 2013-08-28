//this script inserts the requesr into the request release table.
//Written by Peter Krepa

<script>
<?php
	$myconn2=mysql_connect("co-project.lboro.ac.uk",team13,b7c8pbvc);
	mysql_select_db("team13",$myconn2);
	$strSQL = "INSERT INTO RequestRelease (RequestID) VALUES ('".$_REQUEST['a']."')";
	mysql_query($strSQL, $myconn2);

?>
parent.refresh()
</script>



