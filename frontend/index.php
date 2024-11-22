<?php
// Include the database connection
include 'db_connection.php';

// Query to fetch data from a table (update 'your_table' to match a table in your schema)
$sql = "SELECT * FROM Patients"; // Replace 'your_table' with a valid table name
$result = $conn->query($sql);

if ($result->num_rows > 0) {
    // Output data of each row
    while ($row = $result->fetch_assoc()) {
        echo "ID: " . $row["id"] . " - Name: " . $row["firstName"] . "<br>";
    }
} else {
    echo "0 results";
}

// Close the database connection
$conn->close();
?>

<?php
include 'db_connection.php'; // Ensure your database connection is configured

$sql = "CALL GetBasicPatients()"; // Call the stored procedure
$result = $conn->query($sql);

if ($result->num_rows > 0) {
    while ($row = $result->fetch_assoc()) {
        echo "Patient Name: " . $row["fullName"] . " - Room: " . $row["room"] . "<br>";
    }
} else {
    echo "No patients found.";
}

$conn->close();
?>
