

<html></html>

<head>
	<title>Project Management Website - Team 13</title>	
	<link rel="stylesheet" href="../style/pmwstyle.css" type="text/css" media="screen" />
</head>

<?php 	session_start();



if(isset($_SESSION['mySessionVar2'])){}else{
    header("Location: login.php");
}

?>


<body>
	<div id="header">
		<h1>Project Management</h1>
		<h2>Team 13</h2>
	</div>
	<div id="navigation">
		<ul>
			<li><a href="pmhome.php">Home</a></li>
			<li class="active"><a href="team.php">The Team</a></li>
        		<li><a href="requirements.php">Requirements</a></li>
        		<li><a href="output.php">Output</a></li>
			<li><a href="planned.php">Work Planned</a></li>
			<li><a href="forum.php">Forum</a></li>
			<li><a href="login.php">Logout</a></li>
		</ul>
	</div>
	
	<div id="content">
                    <div id="left">
                      <p><strong><u>Peter Krepa:</u></strong><br><br><img src='../images/pmw/P.jpg' width='100px' height='100px'/> <br><br>
					  <strong>Role: </strong> Group Leader<br>
					  <strong>Responsibilities: </strong>Organise Meetings, write PHP/Javascript for system, Project Management website developer, Primary programmer<br>
					  <strong>Contact: </strong>p.krepa-09@student.lboro.ac.uk</p><br>
					  
					  <p><strong><u>Andy Verghese:</u></strong><br><br><img src='../images/pmw/AV.jpg' width='100px' height='100px'/> <br><br>
					  <strong>Role:  </strong>Data Technician<br>
					  <strong>Responsibilities: </strong>Create, enter and maintain data within the database, Testing and development of website and reports<br>
					  <strong>Contact: </strong>a.verghese-08@student.lboro.ac.uk</p><br>
					  
					  <p><strong><u>Alex Chidlaw</u></strong><br><br><img src='../images/pmw/AC.jpg' width='100px' height='100px'/> <br><br>
					  <strong>Role:  </strong>Project Management Technician<br>
					  <strong>Responsibilities: </strong>Data Security and Manipulation, Secondary programmer, Maintenance of PMW, Testing and Improving Project Management facilities and forum.<br>
					  <strong>Contact: </strong>a.childlaw-09@student.lboro.ac.uk</p><br>
					  </div>
					  
					  
					  <div id="right">


					  <p><strong><u>Andrew Mark Wallis:</u></strong><br><br><img src='../images/pmw/AM.jpg' width='100px' height='100px'/> <br><br>
					  <strong>Role: </strong>System Programmer<br>
					  <strong>Responsibilities: </strong>Create database, write PHP/Javascript for system,initial development of forum for PMW, Primary programmer<br>
					  <strong>Contact: </strong>a.m.wallis-09@student.lboro.ac.uk</p><br><br>
				
					  <p><strong><u>Sean Barry:</u></strong><br><br><img src='../images/pmw/S.jpg' width='100px' height='100px'/> <br><br>
					  <strong>Role:  </strong>Data Technician<br>
					  <strong>Responsibilities: </strong>Create, enter and maintain data within the database, Testing and development of website and reports<br>
					  <strong>Contact: </strong>s.barry2-09@student.lboro.ac.uk</p><br>
					  
					  <p><strong><u>Jack Bell:</u></strong><br><br><img src='../images/pmw/J.jpg' width='100px' height='100px'/><br><br>
					  <strong>Role:</strong> Team Member <br>
					   <strong>Contact: </strong>j.bell2-09@student.lboro.ac.uk</p><br>
					</div>

	
	</div>
	
	<br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br>
	<div id="footer">
		<p>Copyright &copy; Team 13</p>
	</div>
</body>

</html>