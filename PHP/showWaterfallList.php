<?php
	// Author: 			Jasper Riogeist
  // File: 				showWaterfallList.php
  // Date:				Nov 29, 2021
  // Class:				CS 445	
  // Project: 		BigDB
  // Description: get data from POST variable and display waterfall data.

	session_start();
	require_once('basicErrorHandling.php'); 
	require_once 'connDB.php';

	$dbh = db_connect();
	$rows = []; // default value of empty
 	
	if( isset ($_POST['WaterfallID']) )
 	{
		 require_once('findWaterfallByWaterfallID.php');
		$WaterfallID = $_POST['WaterfallID'];
		$rows = findWaterfallByWaterfallID($dbh, $WaterfallID);

 	}
	else
	{
		header('Location: main.php');
	}

	// display data in table
	print("<H1>Waterfall</H1>");

	print("<a href=\"main.php\">Search Again</a>");

	print("<table border=1 cellpadding=4>");

	print("<tr>");
	print("<td>Name</td>");
	print("<td>Height (ft)</td>");
	print("<td>Class</td>");
	print("<td>Section</td>");
	print("<td>Description</td>");
	print("</tr>");

	foreach ($rows as $row)
	{
		print("<tr>");
		print("<td>".$row['WaterfallName']."</td>");
		print("<td>".$row['WaterfallHeight']."</td>");
		print("<td>".$row['WaterfallClass']."</td>");
		print("<td>".$row['WaterfallSection']."</td>");
		print("<td>".$row['WaterfallDescription']."</td>");
		print("</tr>");
	}
	print("</table>");

	db_close($dbh);
?>   
