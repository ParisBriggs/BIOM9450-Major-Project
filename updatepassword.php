 // Already ran this once and hashed passwords, do NOT RUN AGAIN


<?php
// Database connection
$servername = "localhost";
$username = "root";
$password = ""; // Your database password
$dbname = "major_project_database";

$conn = new mysqli($servername, $username, $password, $dbname);
if ($conn->connect_error) {
    die("Connection failed: " . $conn->connect_error);
}

// Fetch all users
$sql = "SELECT id, userName, password FROM practitioners";
$result = $conn->query($sql);

if ($result->num_rows > 0) {
    while ($row = $result->fetch_assoc()) {
        $userId = $row['id'];
        $userName = $row['userName'];
        $plainPassword = $row['password'];

        // Hash the password using bcrypt
        $hashedPassword = password_hash($plainPassword, PASSWORD_DEFAULT);

        // Update the user's password in the database
        $updateSql = "UPDATE practitioners SET password = ? WHERE id = ?";
        $stmt = $conn->prepare($updateSql);
        $stmt->bind_param("si", $hashedPassword, $userId);
        $stmt->execute();
    }
} else {
    echo "No users found.";
}

$conn->close();
?>