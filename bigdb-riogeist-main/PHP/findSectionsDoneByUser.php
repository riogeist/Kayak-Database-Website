<?php
  // Author: 			Jasper Riogeist
  // File: 				findSectionsDoneByUser.php
  // Date:				Nov 29, 2021
  // Class:				CS 445	
  // Project: 		BigDB
  // Description: contains function that returns data on sections done
	//              by the user whose ID is the parameter UserID.

  
	function findSectionsDoneByUser($dbh, $UserID)
	{
		$rows = array();

		$sth = $dbh -> prepare(
			"Select Sections.Name As Name, Classes.Rating As SectionClass, 
    		Rivers.Name As RiverName, UserDoneSections.Journal As Journal, 
				UserDoneSections.TimeCoordinates As 'Date'
    	From UserDoneSections, Sections, Classes, Rivers
    	Where UserDoneSections.SectionID = Sections.SectionID
      	And UserDoneSections.UserID =:userID
      	And Sections.ClassID = Classes.ClassID
      	And Sections.RiverID = Rivers.RiverID
    	Order By UserDoneSections.TimeCoordinates");

		$sth->bindValue(":userID", $UserID);

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