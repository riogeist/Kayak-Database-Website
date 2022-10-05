<?php
	// Author: 			Jasper Riogeist
  // File: 				showSectionList.php
  // Date:				Nov 29, 2021
  // Class:				CS 445	
  // Project: 		BigDB
  // Description: get data from POST variable and display section data.

	session_start();
	require_once('basicErrorHandling.php');
	require_once 'connDB.php';

	$dbh = db_connect();
	$rows = []; // default value of empty
 	
	if( isset ($_POST['Name']) )
 	{
		 require_once('findSectionByName.php');
		$Name = $_POST['Name'];
		$rows = findSectionByName($dbh, $Name);
 	}
	else
	{
		header('Location: main.php');
	}

	// display data in table
	print("<H1>Sections</H1>");

	print("<a href=\"main.php\">Search Again</a>");

	print("<table border=1 cellpadding=4>");

	print("<tr>");
	print("<td>Name</td>");
	print("<td>Class</td>");
	print("<td>Season</td>");
	print("<td>Length (mi)</td>");
	print("<td>Gradient (fpm)</td>");
	print("<td>River</td>");
	print("<td>Region</td>");
	print("<td>Description</td>");
	print("</tr>");

	foreach ($rows as $row)
	{
		print("<tr>");
		print("<td>".$row['Name']."</td>");
		print("<td>".$row['SectionClass']."</td>");
		print("<td>".$row['SectionSeason']."</td>");
		print("<td>".$row['Length']."</td>");
		print("<td>".$row['Gradient']."</td>");
		print("<td>".$row['RiverName']."</td>");
		print("<td>".$row['SectionRegion']."</td>");
		print("<td>".$row['SectionDescription']."</td>");
		print("</tr>");
	}
	
	print("</table>");

	db_close($dbh);
?>   
