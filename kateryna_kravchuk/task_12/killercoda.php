<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<body>
<?php

$hostname = "localhost";
$username = "ruser";
$password = "password";
$db = "newdb";

$dbconnect=mysqli_connect($hostname,$username,$password,$db);

if ($dbconnect->connect_error) {
  die("Database connection failed: " . $dbconnect->connect_error);
}

?>
  <figure>
    <img src="https://upload.wikimedia.org/wikipedia/commons/e/e3/SoftServe.svg" />
    <figcaption>
      <a href="https://upload.wikimedia.org/wikipedia/commons/e/e3/SoftServe.svg">SoftServe</a>, 
      <a href="https://creativecommons.org/licenses/by/2.0">CC BY 2.0</a>, via Wikimedia Commons
    </figcaption>
  </figure>
  </a>
<table border="1" align="center">
<tr>
  <td>Reviewer Name</td>
  <td>Phone</td>
  <td>Level</td>
</tr>

<?php

$query = mysqli_query($dbconnect, "SELECT * FROM softserve")
   or die (mysqli_error($dbconnect));

while ($row = mysqli_fetch_array($query)) {
  echo
   " <tr>
    <td>{$row['name']}</td>
    <td>{$row['phone']}</td>
    <td>{$row['level']}</td>
   </tr>\n";

}

?>
</table>
</body>
</html>