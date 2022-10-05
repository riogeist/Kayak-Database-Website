<html>
  <!-- 
  Author: 		 Jasper Riogeist
  File: 			 login.php
  Date:				 December 1, 2021
  Class:			 CS 445	
  Project: 		 BigDB
  Description: php file for login page.
  -->

  <body>
    <form method="post" name="frmLogin" action="userAuth.php">
      Username:
      <input name="txtUser" type="text" >

      Password:
      <input name="txtPassword" type="password">

      <input type="submit" name="btnLogin" value="Login">
      
      <?php 
      print("<a href=\"main.php\">Continue without Login</a>");
      ?>

    </form>
  </body>
</html>