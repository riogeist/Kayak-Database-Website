<?php 
  // Author: 			Jasper Riogeist
  // File: 				showWaterfallList.php
  // Date:				Nov 29, 2021
  // Class:				CS 445	
  // Project: 		BigDB
  // Description: authorizes user by checking credentials in database.

  session_start();
  require_once('basicErrorHandling.php');
  require_once ('connDB.php');

  $_SESSION['VALID'] = 0;
  $dbh = db_connect();

  if(isset($_POST['txtUser']) && isset($_POST['txtPassword']))
  {
    $user = $_POST['txtUser'];
    $passwd = $_POST['txtPassword'];

    require_once('queryValidateUser.php');
    $result = queryValidateUser($dbh, $user, $passwd);

    if(TRUE == $result)
    {
      $_SESSION['VALID'] = 1;
      $_SESSION['USER'] = $user;
      header('Location: main.php');
    }
      else
    {
      header('Location: login.php');
    }
  }
  else
  {
    header('Location: login.php');
  }
?>