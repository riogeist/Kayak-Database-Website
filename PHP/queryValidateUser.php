<?php
	// Author: 			Jasper Riogeist
  // File: 				queryValidateUser.php
  // Date:				December 1, 2021
  // Class:				CS 445	
  // Project: 		BigDB
  // Description: contains two functions. The first function gets the
	//              salt of the user, the second function validates the user.

require_once('basicErrorHandling.php');

function queryGetSalt($dbh, $user)
{
  $rows = array();

		$sth = $dbh -> prepare(
			"Select Salt
	    From Users
	    Where Users.Username =:user");

		$sth->bindValue(":user", "$user");

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

function queryValidateUser($dbh, $user, $passwd)
{
  $retVal = FALSE;
  $salt = queryGetSalt($dbh, $user);
  $hashedPW = crypt($passwd.$salt, '$2y$07$8d88bb4a9916b302c1c68c$');

  $sth = $dbh->prepare(
    "Select * 
    From Users 
    Where Username = :user 
      And Passwd = :pass");

  $sth->bindValue(":user",$user);
  $sth->bindValue(":pass",$hashedPW);
  $sth->execute();

  if( 1 == $sth -> rowCount() )
  {
    $retVal = TRUE;
  }

  return $retVal;
}
?>