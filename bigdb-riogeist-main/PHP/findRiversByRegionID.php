<?php
  // Author: 			Jasper Riogeist
  // File: 				findRiversByRegionID.php
  // Date:				Nov 29, 2021
  // Class:				CS 445	
  // Project: 		BigDB
  // Description: contains functioning returning river information for each
	//              river in region corresponding to RegionID parameter.
  
	function findRiversByRegionID($dbh, $RegionID)
	{
		$rows = array();

		$sth = $dbh -> prepare(
			"Select Rivers.Name As RiverName, Rivers.Description As RiverDescription 
			From Rivers, Sections 
			Where Sections.RiverID = Rivers.RiverID 
				And Sections.RegionID =:regionID
			Group By Rivers.Name
			Order By Rivers.Name");

		$sth->bindValue(":regionID", $RegionID);

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