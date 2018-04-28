<html>
<head>
</head>
<body>  

<?php

// define variables and set to empty values
$name = $email = $gender = $comment = $website = "";
$db = new SQLite3('mysqlitedb.db');

if ($_SERVER["REQUEST_METHOD"] == "POST") {
  $name = test_input($_POST["name"]);
  $email = test_input($_POST["email"]);
  $website = test_input($_POST["website"]);
  $comment = test_input($_POST["comment"]);
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

<h2>PHP SQLite</h2>
	<form method = "post" action = "action_page.php">
		Name: <input type="text" name="name" maxlength="20" pattern="[A-Za-z ]+" required><br>
		E-mail: <input type="text" name="email" pattern = "[A-za-z]+@[a-z0-9]+\.com" required><br>
		Mobile: <input type="text" name="mobile" pattern="[1-9][0-9]{9}"><br>
		Bank Account: <input type="text" name="account" pattern="[0-9]{5}"><br>
		Bank Account password: <input type="password" name="password" pattern="[0-9a-zA-Z]+" maxlength="20"><br>
		Address: <input type="text" name="address" maxlength = "100"><br>
		<input type="submit">
	</form>
<?php
echo "<h2>Records:</h2>";

$results = $db->query('SELECT * FROM records');
while ($row = $results->fetchArray()) {
	    echo "<br> $row[0] $row[1] $row[2] $row[3]";
}
?>

</body>
</html>
