<?php

// Secure session settings
session_set_cookie_params([
    'secure' => true, // Ensure cookies are sent over HTTPS
    'httponly' => true, // Prevent JavaScript access to cookies
    'samesite' => 'Strict', // Protect against CSRF attacks
]);

// Start the session
session_start();

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

    // Prepare and execute SQL query to check if the username exists
    $sql = "SELECT * FROM practitioners WHERE userName=?";
    $stmt = $conn->prepare($sql);
    $stmt->bind_param("s", $submitted_userName);
    $stmt->execute();
    $result = $stmt->get_result();
    
    // Check if the user exists and fetch the user's details
    if ($result->num_rows > 0) {
        $user = $result->fetch_assoc();
        
        // Use password_verify to check if the entered password matches the hashed password
        if (password_verify($submitted_password, $user['password'])) {
            // Password is correct, log the user in by storing session variables
            $_SESSION['user_id'] = $user['id']; // Assuming 'id' is the user's unique ID in the database
            $_SESSION['user_name'] = $user['userName']; // Optional: Store username for display

            // Redirect to the dashboard page
            header("Location: dashboard.php");
            exit();
        } else {
            // If the credentials are invalid, redirect back to the login page with an error message
            header("Location: login.php?error=invalid_credentials"); // Error query parameter
            exit();
        }
    } else {
        // If no user found
        header("Location: login.php?error=invalid_credentials"); // Error query parameter
        exit();
    }

    // Close the prepared statement and connection
    $stmt->close();
    $conn->close();
}
?>