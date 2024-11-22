<?php
include_once 'db_connection.php'; // Ensure this connects to your database

// Fetch all patients from the database
function getPatientsFromDatabase() {
    global $conn;

    $query = "SELECT room, firstName, lastName, photo FROM Patients"; // Updated column names
    $result = $conn->query($query);

    if (!$result) {
        die("Database query failed: " . $conn->error);
    }

    return $result->fetch_all(MYSQLI_ASSOC);
}

// Fetch a specific patient by room
function getPatientByRoomFromDatabase($room) {
    global $conn;

    $query = "SELECT * FROM Patients WHERE room = ?";
    $stmt = $conn->prepare($query);
    $stmt->bind_param("i", $room);
    $stmt->execute();
    $result = $stmt->get_result();

    if (!$result) {
        die("Database query failed: " . $stmt->error);
    }

    return $result->fetch_assoc();
}
?>
