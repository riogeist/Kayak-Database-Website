<?php
	// Author: 			Jasper Riogeist
  // File: 				showRegionList.php
  // Date:				Nov 29, 2021
  // Class:				CS 445	
  // Project: 		BigDB
  // Description: get data from POST variable and run a query.

	session_start();
	require_once('basicErrorHandling.php');
	require_once 'connDB.php';

	$dbh = db_connect();
	$rows = []; // default value of empty
 	
	if( isset ($_POST['RegionID']) )
 	{
		 require_once('findRiversByRegionID.php');
		$RegionID = $_POST['RegionID'];
		$rows = findRiversByRegionID($dbh, $RegionID);
 	}
	 else
	 {
		header('Location: main.php');
	 }

	// display data in table
	print("<H1>Rivers in Region</H1>");

	print("<a href=\"main.php\">Return to Initial Search</a>");

	print("<table border=1 cellpadding=4>");

	print("<tr>");
	print("<td>Name</td>");
	print("<td>Description</td>");
	print("</tr>");

	foreach ($rows as $row)
	{
		print("<tr>");
		print("<td>".$row['RiverName']."</td>");
		print("<td>".$row['RiverDescription']."</td>");
		print("</tr>");
	}
	print("</table>");

	db_close($dbh);
?>   
