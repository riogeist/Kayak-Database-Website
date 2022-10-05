<?php
  // Author: 			Jasper Riogeist
  // File: 				findWaterfallsDoneByUserID.php
  // Date:				Nov 29, 2021
  // Class:				CS 445	
  // Project: 		BigDB
  // Description: contains function that returns the data on waterfalls
	//              the user has done whose ID is the parameter UserID.
  
	function findWaterfallsDoneByUserID($dbh, $UserID)
	{
		$rows = array();

		$sth = $dbh -> prepare(
			"Select Waterfalls.Name As Name, Waterfalls.Height As Height, 
    		Classes.Rating As WaterfallClass, UserDoneWaterfalls.Journal As Journal, 
    		UserDoneWaterfalls.TimeCoordinates as 'Date'
    	From UserDoneWaterfalls, Waterfalls, Classes
    	Where UserDoneWaterfalls.WaterfallID = Waterfalls.WaterfallID 
      	And Waterfalls.ClassID = Classes.ClassID
				And UserDoneWaterfalls.UserID =:userID
    	Order By UserDoneWaterfalls.TimeCoordinates;");
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