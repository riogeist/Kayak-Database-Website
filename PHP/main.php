<?php
	// Author: 			Jasper Riogeist
  // File: 				main.php
  // Date:				November 29, 2021
  // Class:				CS 445	
  // Project: 		BigDB
  // Description: html and php for main page of Pacific Northwest Kayaking 
	//              website.

 	require_once('basicErrorHandling.php');
	require_once ('connDB.php');
	session_start();
	$dbh = db_connect();
?>

<html>
	<head>
		<title>Pacific Northwest Kayaking</title>
	</head>

	<body>
		<h1>Pacific Northwest Kayaking</h1>

		<table style="width: 100%;">

			<tr><td>
				<!--Displays a drop down box of the different regions-->
				<form method="post" action="showRegionList.php">
					Select a Region:
					<select NAME="RegionID">
						<?php
							require_once('queryAllRegions.php');
							$allRegions = queryAllRegions($dbh);

							foreach ($allRegions as $reg)
							{
								print("<option value=" . $reg['RegionID'].">".
								$reg['Name']. "</option>");
							}
						?>
					</select>
						<input TYPE="submit" NAME="Search" VALUE="Search" />
				</form>

				<!--Displays a text box to search for a section-->
				<form method="post" action="showSectionList.php">
					Search for a section: <input type="text" Name="Name"/>
					<input type="submit" name="Search" value="Search"/>
				</form>

				<!--Displays a drop down box of the different waterfalls-->
				<form method="post" action="showWaterfallList.php">
					Select a Waterfall:
					<select NAME="WaterfallID">
						<?php
							require_once('queryAllWaterfalls.php');
							$allWaterfalls = queryAllWaterfalls($dbh);

							foreach ($allWaterfalls as $falls)
							{
								print("<option value=" . $falls['WaterfallID'].">".
								$falls['Name']. "</option>");
							}
						?>
					</select>
						<input TYPE="submit" NAME="Search" VALUE="Search" />
				</form>

				<!--Displays "Look at Past Runs," just a button-->
				<form method="post" action="showPastRuns.php">
					Look at Past Runs:
					<input type="submit" name="Go" value="Go"/>
				</form>

			</td>
			
			<td class="alignRight">
				<!--Display Username-->
				<form>
					<?php
						if(isset ($_SESSION['USER'])) 
						{
							print("User: ".$_SESSION['USER']."");
						}
						else{
							print("Currently not logged in");
						}
					?>
				</form>

				<!--Display Login Button-->
				<form method="post" action="login.php">
					<input type="submit" name="Login" value="Login"/>
				</form>

				<!--Display Logout Button-->
				<form method="post" action="logout.php">
					<input type="submit" name="Logout" value="Logout"/>
				</form>

			</td></tr>

		</table>
		<img src="https://www.whitewaterguidebook.com/wp-content
			/uploads/2016/06/Lava-Falls-White-Salmon-e1557763258884.jpg",
		style="width:700px;height:500px;">
	</body>

</html>

<?php
	db_close($dbh);
?>