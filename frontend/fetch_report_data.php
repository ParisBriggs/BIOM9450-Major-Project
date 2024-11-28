<?php
include_once 'db_connection.php'; 


function getMedicationRounds() {
    global $conn;
    
    $query = "SELECT 
        CONCAT(p.firstName, ' ', p.lastName) AS patient_name,
        p.room AS room_number,
        m.name AS medication_name,
        CONCAT(pr.firstName, ' ', pr.lastName) AS practitioner_name,
        mr.roundDate AS round_date,
        mr.roundTime AS round_time,
        mr.status AS round_status,
        mr.notes AS round_notes
    FROM 
        MedicationRound mr
        JOIN MedicationOrder mo ON mr.orderId = mo.id
        JOIN Patients p ON mo.patient = p.id
        JOIN Medications m ON mo.medication = m.id
        JOIN Practitioners pr ON mr.practitioner = pr.id
    ORDER BY 
        mr.roundDate DESC,
        p.room ASC,
        mr.roundTime ASC";

    $result = $conn->query($query);

    if (!$result) {
        die("Database query failed: " . $conn->error);
    }

    $data = $result->fetch_all(MYSQLI_ASSOC);
    error_log("Medication Rounds Data: " . print_r($data, true));
    return $data;
}

function getDietRounds() {
    global $conn;
    
    $query = "SELECT 
        CONCAT(p.firstName, ' ', p.lastName) AS patient_name,
        p.room AS room_number,
        d.name AS diet_name,
        CONCAT(pr.firstName, ' ', pr.lastName) AS practitioner_name,
        dr.roundTime AS round_time,
        dr.status AS round_status
    FROM 
        DietRound dr
        JOIN DietOrder do ON dr.orderId = do.id
        JOIN Patients p ON do.patient = p.id
        JOIN DietRegimes d ON do.dietRegime = d.id
        JOIN Practitioners pr ON dr.practitioner = pr.id
    ORDER BY 
        p.room ASC,
        dr.roundTime ASC";

    $result = $conn->query($query);

    if (!$result) {
        die("Database query failed: " . $conn->error);
    }

    $data = $result->fetch_all(MYSQLI_ASSOC);
    error_log("Diet Rounds Data: " . print_r($data, true));
    return $data;
}