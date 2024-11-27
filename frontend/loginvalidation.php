<?php

ini_set('display_errors', 1);
error_reporting(E_ALL); 

// Database connection details
$servername = "localhost"; // your database server
$username = "root"; // your database username
$password = ""; // your database password
$dbname = "biom9450"; // the database name

// Create a connection to the database
$conn = new mysqli($servername, $username, $password, $dbname);

// Check if connection is successful
if ($conn->connect_error) {
    die("Connection failed: " . $conn->connect_error);
}

// Check if the form is submitted
if ($_SERVER["REQUEST_METHOD"] == "POST") {
    // Get the submitted username and password
    $submitted_userName = $_POST["userName"];
    $submitted_password = $_POST["password"];

    // Prepare and execute SQL query to check if the username and password are correct
    $sql = "SELECT * FROM practitioners where userName=? AND password=?";
    $stmt = $conn->prepare($sql);
    $stmt->bind_param("ss", $submitted_userName, $submitted_password);
    $stmt->execute();
    $result = $stmt->get_result();

    // Check if a matching user is found
    if ($result->num_rows > 0) {
        // User is authenticated, redirect to dashboard.html

        header("Location: dashboard.html");
        exit();


    } else {
        // If the credentials are invalid, redirect back to the login page with an error message
        header("Location: login.php?error=invalid_credentials"); // Error query parameter
        exit;
    }

    // Close the prepared statement and connection
    $stmt->close();
    $conn->close();
}
?>