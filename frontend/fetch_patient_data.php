
<!-- This file fetches list of patients for sidebar -->

<?php
include 'db_connection.php'; // Ensure file connects to the database

function getPatientsFromProcedure() {
    global $conn;

    // Call the stored procedure
    $sql = "CALL GetBasicPatients()";
    $result = $conn->query($sql);

    // Fetch and return the results as an associative array
    if ($result->num_rows > 0) {
        return $result->fetch_all(MYSQLI_ASSOC);
    } else {
        return [];
    }
}
?>

