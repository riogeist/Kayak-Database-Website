<?php
	// Author: 			Jasper Riogeist
  // File: 				logout.php
  // Date:				December 2, 2021
  // Class:				CS 445	
  // Project: 		BigDB
  // Description: php file to end current session.
  
  session_start();
  require_once('basicErrorHandling.php');
  require_once 'connDB.php';
  
  session_destroy();
  $_SESSION = array();
  setcookie();
  header('Location: main.php');
?>