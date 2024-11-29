<?php
// Include the database connection

$servername = "localhost"; // your database server
$username = "root"; // your database username
$password = "root"; // your database password
$dbname = "major_project_database"; // the database name

// Create a connection to the database
$conn = new mysqli($servername, $username, $password, $dbname);

// Check if connection is successful
if ($conn->connect_error) {
    die("Connection failed: " . $conn->connect_error);
}

// Check if the form is submitted
if ($_SERVER["REQUEST_METHOD"] == "POST") {
    // Get the username and ID from the form
    $userName = $_POST['userName'];
    $id = $_POST['id'];

    // Prepare SQL query to find the user by both username and id
    $query = "SELECT * FROM practitioners WHERE userName = ? AND id = ?";
    $stmt = $conn->prepare($query);

    // Bind parameters
    $stmt->bind_param("si", $userName, $id); // 'si' means string and integer

    // Execute the query
    $stmt->execute();
    $result = $stmt->get_result();

    // Check if user exists
    if ($result->num_rows > 0) {
        // If user is found, simulate sending reset link (but we won't actually send an email)
        // Generate reset link
        // In a real scenario, you'd generate a secure token here, store it in the DB, and email the user
        header("Location: emailsent.php");
        exit();
    } else {
        // If user is not found, redirect back to the form with an error message
        header("Location: forgetpassword.php?error=invalid_details");
        exit();
    }
    // Close the prepared statement and connection
    $stmt->close();
    $conn->close();
}
?>