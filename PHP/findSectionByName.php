<?php
  // Author: 			Jasper Riogeist
  // File: 				findSectionByName.php
  // Date:				Nov 29, 2021
  // Class:				CS 445	
  // Project: 		BigDB
  // Description: contains function that returns section data for section
	//              with name similar to Name parameter.

	function findSectionByName($dbh, $Name)
	{
		$rows = array();

		$sth = $dbh -> prepare(
			"Select Sections.Name As Name, Classes.Rating As SectionClass, 
				Seasons.Name As SectionSeason, Length, Gradient, 
				Rivers.Name As RiverName, Regions.Name As SectionRegion, 
				Sections.Description As SectionDescription
			From Sections, Classes, Seasons, Rivers, Regions
			Where Sections.ClassID = Classes.ClassID 
				And Sections.SeasonID = Seasons.SeasonID 
				And Sections.RegionID = Regions.RegionID
				And Sections.RiverID = Rivers.RiverID
				And Sections.Name Like :name");

		$sth->bindValue(":name", "%$Name%");

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