<?php
  // Author: 			Jasper Riogeist
  // File: 				queryAllRegions.php
  // Date:				November 29, 2021
  // Class:				CS 445	
  // Project: 		BigDB
  // Description: contains a function to populate a dropbox of all
	//              region names.

  
	function queryAllRegions($dbh)
	{
		$rows = array();

		$sth = $dbh -> prepare(
			"Select Name, RegionID 
			From Regions 
			Order By Name");

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