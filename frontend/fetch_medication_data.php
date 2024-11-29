<?php
include_once 'db_connection.php'; // Ensure this connects to your database

// Fetch all combined data for a specific date and round
function getMedicationData($date, $round) {
    global $conn;

    // Prepare SQL query to join MedicationOrder and MedicationRound
    $query = "
        SELECT 
            mo.id AS orderId,
            mo.patient AS patientId,
            mo.medication AS medicationId,
            mo.dateOrdered,
            mo.dosage,
            mr.practitioner,
            mr.roundTime,
            mr.status,
            mr.notes,
            mr.roundDate
        FROM 
            MedicationOrder AS mo
        INNER JOIN 
            MedicationRound AS mr 
        ON 
            mo.id = mr.orderId
        WHERE 
            mo.dateOrdered LIKE ? 
        AND 
            mr.roundTime = ?
    ";

    $stmt = $conn->prepare($query);

    // Bind parameters and execute
    $date_param = "$date%";
    $stmt->bind_param("ss", $date_param, $round);
    $stmt->execute();

    $result = $stmt->get_result();
    if (!$result) {
        die("Database query failed: " . $stmt->error);
    }

    return $result->fetch_all(MYSQLI_ASSOC);
}
?>
