<?php
$servername = "localhost"; // MAMP default MySQL server
$username = "root";        // MAMP default username
$password = "root";        // MAMP default password
$dbname = "major_project_database"; // Replace with your database name

// Create a connection
$conn = new mysqli($servername, $username, $password, $dbname);

// Check connection
if ($conn->connect_error) {
    die("Connection failed: " . $conn->connect_error);
}
?>
