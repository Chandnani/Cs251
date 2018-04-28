<?php
echo "<h2>Records:</h2>";

$results = $db->query('SELECT * FROM records');
while ($row = $results->fetchArray()) {
	    echo "<br> $row[0] $row[1] $row[2] $row[3]";
}
?>
