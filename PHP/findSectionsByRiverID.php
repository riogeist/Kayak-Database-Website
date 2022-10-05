<?php
  // Author: 			Jasper Riogeist
  // File: 				findSectionsByRiverID.php
  // Date:				Nov 29, 2021
  // Class:				CS 445	
  // Project: 		BigDB
  // Description: contains a function that returns section data for each
	//              section on a river whose id is the parameter RiverID.

	function findSectionsByRiverID($dbh, $RiverID)
	{
		$rows = array();

		$sth = $dbh -> prepare(
			"Select Sections.Name As Name 
			From Sections
			Where Sections.RiverID =:riverID
			Order By Sections.Name");

		$sth->bindValue(":riverID", $RiverID);

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