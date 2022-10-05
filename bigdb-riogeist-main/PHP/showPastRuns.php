<?php
  // Author: 			Jasper Riogeist
  // File: 				showPastRuns.php
  // Date:				Nov 29, 2021
  // Class:				CS 445	
  // Project: 		BigDB
  // Description: shows sections and waterfalls which logged in user has done.

  session_start();
  require_once('basicErrorHandling.php');

  // requires user to be authenticated
  if(!isset($_SESSION['VALID']) || $_SESSION['VALID'] != 1)
  {
    header('Location: login.php');
  }

  require_once 'connDB.php';

  $dbh = db_connect();
  $rows_1 = []; // default value of empty
  $rows_2 = []; // default value of empty

  if(isset ($_SESSION['USER'])) 
  {
    require_once('findSectionsDoneByUser.php');
    require_once('findWaterfallsDoneByUserID.php');
    require_once('getUserIDByUsername.php');
    $user = $_SESSION['USER'];
    $userID = getUserIDByUsername($dbh, $user);
    $rows_1 = findSectionsDoneByUser($dbh, $userID); 
    $rows_2 = findWaterfallsDoneByUserID($dbh, $userID);
  }
  else
  {
    header('Location: login.php');
  }

  // Display user done sections data in table
  print("<H1>Kayaking History</H1>");

  print("<a href=\"main.php\">Search Again</a>");

  print("<table border=1 cellpadding=4>");

  print("<H2>Sections</H2>");
  print("<tr>");
  print("<td>Name</td>");
  print("<td>Class</td>");
  print("<td>River</td>");
  print("<td>Journal</td>");
  print("<td>Date</td>");
  print("</tr>");

  foreach ($rows_1 as $row)
  {
    print("<tr>");
    print("<td>".$row['Name']."</td>");
    print("<td>".$row['SectionClass']."</td>");
    print("<td>".$row['RiverName']."</td>");
    print("<td>".$row['Journal']."</td>");
    print("<td>".$row['Date']."</td>");
    print("</tr>");
  }
  print("</table>");

  // Display user done sections data in table
  print("<table border=1 cellpadding=4>");

  print("<H2>Waterfalls</H2>");
  print("<tr>");
  print("<td>Name</td>");
  print("<td>Height (ft)</td>");
  print("<td>Class</td>");
  print("<td>Journal</td>");
  print("<td>Date</td>");
  print("</tr>");

  foreach ($rows_2 as $row)
  {
    print("<tr>");
    print("<td>".$row['Name']."</td>");
    print("<td>".$row['Height']."</td>");
    print("<td>".$row['WaterfallClass']."</td>");
    print("<td>".$row['Journal']."</td>");
    print("<td>".$row['Date']."</td>");
    print("</tr>");
  }
  print("</table>");

  db_close($dbh);
?>   