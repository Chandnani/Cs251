<?php

// define variables and set to empty values
$name = $email = $gender = $comment = $website = "";
$db = new SQLite3('mysqlitedb.db');

if ($_SERVER["REQUEST_METHOD"] == "POST") {
  $name = test_input($_POST["name"]);
  $email = test_input($_POST["email"]);
  $website = test_input($_POST["website"]);
  $gender = test_input($_POST["gender"]);
  $qstr = "insert into records values ('$name', '$email', '$website', '$gender')";
  $insres = $db->query($qstr);
}

function test_input($data) {
  $data = trim($data);
  $data = stripslashes($data);
  $data = htmlspecialchars($data);
  return $data;
}
?>
