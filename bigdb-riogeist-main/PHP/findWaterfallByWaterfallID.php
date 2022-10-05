<?php
  // Author: 			Jasper Riogeist
  // File: 				findWaterfallByWaterfallID.php
  // Date:				Nov 29, 2021
  // Class:				CS 445	
  // Project: 		BigDB
  // Description: contains function which returns a waterfalls 
	//              information whose ID is the parameter WaterfallID.

  
	function findWaterfallByWaterfallID($dbh, $WaterfallID)
	{
		$rows = array();

		$sth = $dbh -> prepare(
			"Select Waterfalls.Name As WaterfallName, 
				Waterfalls.Height As WaterfallHeight, Classes.Rating As WaterfallClass, 
				Sections.Name As WaterfallSection, 
				Waterfalls.Description As WaterfallDescription
			From Waterfalls, Classes, Sections
			Where Waterfalls.SectionID = Sections.SectionID 
				And Waterfalls.ClassID = Classes.ClassID 
				And Waterfalls.SectionID = Sections.SectionID 
				And Waterfalls.WaterfallID =:waterfallID");

		$sth->bindValue(":waterfallID", "$WaterfallID");

		try
		{
			// run the query
			$sth -> execute();
		}

		catch(PDOException $e)
		{
			print("The query failed.\n");
			print("Code: ".$e->getCode(). "\n");
			print("Message: ". $e->getMessage() . "\n");
		}

		while ($row = $sth -> fetch())
		{
			$rows[] = $row;
		}
		
		return $rows;
	}
?>