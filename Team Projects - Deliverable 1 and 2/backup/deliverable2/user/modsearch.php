<script type='text/javascript'>
var part = [];
var mod = [];

	<?php
		$myconn2=mysql_connect("co-project.lboro.ac.uk",team13,b7c8pbvc);
		mysql_select_db("team13",$myconn2);
		
   		$strSQL="SELECT * FROM Module INNER JOIN Department ON Module.DepartmentID=Department.DepartmentID WHERE Department.DepartmentName = '".$_REQUEST['searchdept']."' ORDER BY Name";
		$result2=mysql_query($strSQL, $myconn2);
		$count = 0;
		while($row=mysql_fetch_array($result2)){
			echo 'var record={} ; ';
			echo 'record.name="'.$row["Name"].'" ; ';
			echo 'record.id="'.$row["ModuleID"].'" ; ';
			echo 'record.dept="'.$row["DepartmentID"].'" ; ';
			echo 'record.part="'.$row["Part"].'" ; ';
			echo 'mod['.$count.']=record ; ';
			$count++;
		}
		
		$strSQL="SELECT DISTINCT Part FROM Department INNER JOIN Module ON Module.DepartmentID=Department.DepartmentID WHERE Department.DepartmentName = '".$_REQUEST['searchdept']."' ORDER BY Part";
   		$result2=mysql_query($strSQL, $myconn2);
		$count = 0;
		while($row=mysql_fetch_array($result2)){
			echo 'part['.$count.']="'.$row["Part"].'";';
			$count++;
		}
	?>

parent.passback(mod,part);

</script>
