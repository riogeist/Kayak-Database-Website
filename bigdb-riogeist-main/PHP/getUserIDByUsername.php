<?php
  // Author: 			Jasper Riogeist
  // File: 				getUserIDByUsername.php
  // Date:				Nov 29, 2021
  // Class:				CS 445	
  // Project: 		BigDB
  // Description: contains function which returns the userID of
	//              the user whose username is the inputted parameter.

  
	function getUserIDByUsername($dbh, $user)
	{
		$rows = array();

		$sth = $dbh -> prepare(
			"Select UserID
      From Users 
      Where Username =:user");

		$sth->bindValue(":user", $user);

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

    $array = $sth -> fetch();
    $row = reset($array);
		
    return $row;
	}
?>