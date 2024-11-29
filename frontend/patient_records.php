<?php
session_set_cookie_params([
    'secure' => false, // For local testing over HTTP
    'httponly' => true,
    'samesite' => 'Strict',
]);
session_start();

// Check if the user is logged in
if (!isset($_SESSION['user_id'])) {
    // Redirect to login page if the user is not logged in
    header('Location: login.php');
    exit();
}

include_once 'db_connection.php'; // Ensure this connects to your database

// Fetch all patients from the database
function getPatientsFromDatabase() {
    global $conn;

    $query = "SELECT room, firstName, lastName, photo, phone, email FROM Patients"; 
    $result = $conn->query($query);

    if (!$result) {
        die("Database query failed: " . $conn->error);
    }

    return $result->fetch_all(MYSQLI_ASSOC);
}

// Fetch a specific patient by room
function getPatientByRoomFromDatabase($room) {
    global $conn;

    $query = "
        SELECT 
            p.id, 
            p.firstName, 
            p.lastName, 
            p.room, 
            p.sex, 
            p.photo, 
            p.notes, 
            p.phone, 
            p.email,
            DATE_FORMAT(p.DOB, '%d-%m-%Y') AS DOB,
            CONCAT(ec.firstName, ' ', ec.lastName) AS emergencyContactName, 
            ec.phone AS emergencyContactPhone, 
            ec.email AS emergencyContactEmail 
        FROM 
            Patients AS p
        LEFT JOIN 
            EmergencyContacts AS ec 
        ON 
            p.emergencyContact = ec.id
        WHERE 
            p.room = ?
    ";

    $stmt = $conn->prepare($query);
    $stmt->bind_param("i", $room);
    $stmt->execute();
    $result = $stmt->get_result();

    if (!$result) {
        die("Database query failed: " . $stmt->error);
    }

    return $result->fetch_assoc();
}

// Fetch all medication orders for a specific patient
function getMedicationsByPatientId($patientId) {
    global $conn;

    $query = "
        SELECT 
            mo.id AS orderId,
            m.name AS name,
            mo.dosage,
            mo.frequency AS frequency,
            m.routeAdmin AS route,
            mo.dateOrdered AS datePrescribed,
            CONCAT(p.firstName, ' ', p.lastName) AS prescribedBy
        FROM 
            MedicationOrder AS mo
        INNER JOIN 
            Medications AS m 
        ON 
            mo.medication = m.id
        INNER JOIN 
            Practitioners AS p
        ON
            mo.prescribedBy = p.id
        WHERE 
            mo.patient = ?
    ";

    $stmt = $conn->prepare($query);
    $stmt->bind_param("i", $patientId);
    $stmt->execute();
    $result = $stmt->get_result();

    if (!$result) {
        die("Database query failed: " . $stmt->error);
    }

    return $result->fetch_all(MYSQLI_ASSOC);
}

// Fetch diet information for a specific patient
function getDietByPatientId($patientId) {
    global $conn;

    $query = "
        SELECT 
            dr.name AS regimeName,
            dr.food,
            dr.exercise,
            dr.beauty
        FROM 
            DietOrder AS do
        INNER JOIN 
            DietRegimes AS dr 
        ON 
            do.dietRegime = dr.id
        WHERE 
            do.patient = ?
    ";

    $stmt = $conn->prepare($query);
    $stmt->bind_param("i", $patientId);
    $stmt->execute();
    $result = $stmt->get_result();

    if (!$result) {
        die("Database query failed: " . $stmt->error);
    }

    return $result->fetch_all(MYSQLI_ASSOC);
}

// Check if the 'room' parameter is set in the URL
if (!isset($_GET['room'])) {
    // Redirect to the default room (101)
    header("Location: patient_records.php?room=101");
    exit;
}

// Get the room number from the URL
$room = isset($_GET['room']) ? intval($_GET['room']) : null;

// Fetch all patients
$patients = getPatientsFromDatabase();

// Fetch selected patient details (if any)
$selectedPatient = $room ? getPatientByRoomFromDatabase($room) : null;

// Fetch medications for the selected patient
$medications = ($selectedPatient) ? getMedicationsByPatientId($selectedPatient['id']) : [];

// Fetch diet information for the selected patient
$diet = ($selectedPatient) ? getDietByPatientId($selectedPatient['id']) : [];

?>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Medication Rounds</title>
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@400;500;600;700&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="styles/styles_patient_records.css">
    <script src="logout_dropdown.js" defer></script>
</head>
<body>
<body>
    <!-- Logo and Centered Navigation Bar -->
    <header>
        <div class="header-left">
            <img src="images/company_logo.png" alt="Nutrimed Health Logo" class="logo">
        </div>
        <nav class="navbar">
            <a href="dashboard.php">Home</a>
            <a href="medication_rounds.php">Medication Rounds</a>
            <a href="diet_rounds.php">Diet Regime Rounds</a>
            <a href="patient_records.php" class="active">Patient Records</a>
            <a href="manage_orders.php">Manage Orders</a>
            <a href="generate_reports.php">Generate Reports</a>
        </nav>
        <div class="header-right">
            <div class="ward-profile">
                
                <div class="dropdown">
                    <button class="dropdown-button" onclick="toggleDropdown()"><br><small>Welcome</small>
                        <?php echo $_SESSION['user_name']; ?><br>
                    </button>
                    <div id="dropdown-content" class="dropdown-content">
                        <a href="logout.php">Logout</a>
                    </div>
                </div>
            </div>
        </div>         
    </header>

    <!-- Main Content Section -->
    <div class="outer-container">
        <!-- Sidebar with Resident List -->
        <aside class="sidebar">

            <div class="add-new-patient">
                <a href="patient_info.php" class="add-patient-button">Add New Patient</a>
            </div>

            <!-- Search inputs -->
            <div class="search">
                <input type="text" id="search-room" placeholder="Search Room" class="search-input" onkeypress="handleSearch(event)">
                <input type="text" id="search-resident" placeholder="Search Resident" class="search-input" onkeypress="handleSearch(event)">
            </div>

            <!-- Resident list -->
            <div id="resident-list" class="resident-list">
                <?php if (!empty($patients)): ?>
                    <?php foreach ($patients as $patient): ?>
                        <div class="resident-item <?php echo ($patient['room'] == $room) ? 'active' : ''; ?>" data-room="<?php echo $patient['room']; ?>" data-name="<?php echo strtolower($patient['firstName'] . ' ' . $patient['lastName']); ?>">
                            <a href="patient_records.php?room=<?php echo $patient['room']; ?>">
                                <img src="<?php echo $patient['photo']; ?>" alt="Resident Photo" class="resident-photo">
                                <span class="room-number"><?php echo $patient['room']; ?></span>
                                <span class="resident-name"><?php echo $patient['firstName'] . ' ' . $patient['lastName']; ?></span>
                            </a>
                        </div>
                    <?php endforeach; ?>
                <?php else: ?>
                    <div>No patients found in the database.</div>
                <?php endif; ?>
            </div>
        </aside>
    
        <!-- JavaScript for searching -->
        <script>  
            function handleSearch(event) {
                // Check if Enter key was pressed
                if (event.key === 'Enter') {
                    event.preventDefault(); // Prevent form submission or other default behavior

                    const roomInput = document.getElementById('search-room').value.toLowerCase();
                    const residentInput = document.getElementById('search-resident').value.toLowerCase();
                    const residentItems = document.querySelectorAll('.resident-item');

                    residentItems.forEach(item => {
                        const room = item.getAttribute('data-room').toLowerCase();
                        const name = item.getAttribute('data-name').toLowerCase();

                        // Only show items that match both inputs, or either input if only one is provided
                        if (
                            (roomInput && residentInput && room.includes(roomInput) && name.includes(residentInput)) ||
                            (roomInput && !residentInput && room.includes(roomInput)) ||
                            (!roomInput && residentInput && name.includes(residentInput))
                        ) {
                            item.style.display = 'flex'; // Show matching items
                        } else {
                            item.style.display = 'none'; // Hide non-matching items
                        }
                    });

                    // If both inputs are empty, show all items
                    if (!roomInput && !residentInput) {
                        residentItems.forEach(item => item.style.display = 'flex');
                    }
                }
            }
        </script>
 
        <!-- Main Profile Section -->
        <main class="profile-section">
            <?php if ($selectedPatient): ?>

                <div class="profile-header">
                    <img src="<?php echo $selectedPatient['photo']; ?>" alt="Profile Photo" class="profile-photo">
                    <h2><?php echo $selectedPatient['firstName'] . ' ' . $selectedPatient['lastName']; ?></h2>
                </div>

                <!-- Patient Information with Boxes -->
                <div class="profile-info-grid">
                    <div class="info-box">
                        <label>Patient ID</label>
                        <span><?php echo $selectedPatient['id']; ?></span>
                    </div>
                    <div class="info-box">
                        <label>Date of Birth</label>
                        <span><?php echo isset($selectedPatient['DOB']) ? $selectedPatient['DOB'] : 'N/A'; ?></span>
                    </div>
                    <div class="info-box">
                        <label>Room Number</label>
                        <span><?php echo $selectedPatient['room']; ?></span>
                    </div>
                    <div class="info-box">
                        <label>Sex</label>
                        <span><?php echo $selectedPatient['sex']; ?></span>
                    </div>
                    <div class="info-box">
                        <label>Emergency Contact</label>
                        <span>
                            <?php echo isset($selectedPatient['emergencyContactName']) 
                                ? $selectedPatient['emergencyContactName'] 
                                : 'N/A'; ?>
                        </span>
                    </div>
                    <div class="info-box">
                        <label>Emergency Contact Phone Number</label>
                        <span>
                            <?php echo isset($selectedPatient['emergencyContactPhone']) 
                                ? $selectedPatient['emergencyContactPhone'] 
                                : 'N/A'; ?>
                        </span>
                    </div>
                    <div class="info-box">
                        <label>Phone Number</label>
                        <span><?php echo isset($selectedPatient['phone']) ? $selectedPatient['phone'] : 'N/A'; ?></span>
                    </div>
                    <div class="info-box">
                        <label>Email Address</label>
                        <span><?php echo isset($selectedPatient['email']) ? $selectedPatient['email'] : 'N/A'; ?></span>
                    </div>
                </div>

                <!-- Notes Section -->
                <section class="notes-section">
                    <h3>Notes</h3>
                    <ul>
                        <li><?php echo $selectedPatient['notes']; ?></li>
                    </ul>
                </section>

                <!-- Medications Section -->
                <section class="medication-section">
                    <h3>Medications</h3>
                    <?php if (!empty($medications)): ?>
                        <table>
                            <thead>
                                <tr>
                                    <th>Medication Name</th>
                                    <th>Dosage</th>
                                    <th>Frequency</th>
                                    <th>Admin Route</th>
                                    <th>Date Prescribed</th>
                                    <th>Prescribed By</th>
                                </tr>
                            </thead>
                            <tbody>
                                <?php foreach ($medications as $medication): ?>
                                    <tr>
                                        <td><?php echo htmlspecialchars($medication['name'] ?? 'N/A'); ?></td>
                                        <td><?php echo htmlspecialchars($medication['dosage'] ?? 'N/A'); ?></td>
                                        <td><?php echo htmlspecialchars($medication['frequency'] ?? 'N/A'); ?></td>
                                        <td><?php echo htmlspecialchars($medication['route'] ?? 'N/A'); ?></td>
                                        <td><?php echo htmlspecialchars($medication['datePrescribed'] ?? 'N/A'); ?></td>
                                        <td><?php echo htmlspecialchars($medication['prescribedBy'] ?? 'N/A'); ?></td>
                                    </tr>
                                <?php endforeach; ?>
                            </tbody>
                        </table>
                    <?php else: ?>
                        <p>No medications found for this patient.</p>
                    <?php endif; ?>
                </section>

                <!-- Diet Section -->
                <section class="diet-section">
                    <h3>Diet</h3>
                    <?php if (!empty($diet)): ?>
                        <table>
                            <thead>
                                <tr>
                                    <th>Diet Regime</th>
                                    <th>Food</th>
                                    <th>Exercise</th>
                                    <th>Beauty</th>
                                </tr>
                            </thead>
                            <tbody>
                                <?php foreach ($diet as $item): ?>
                                    <tr>
                                        <td><?php echo htmlspecialchars($item['regimeName']); ?></td>
                                        <td><?php echo htmlspecialchars($item['food']); ?></td>
                                        <td><?php echo htmlspecialchars($item['exercise']); ?></td>
                                        <td><?php echo htmlspecialchars($item['beauty']); ?></td>
                                    </tr>
                                <?php endforeach; ?>
                            </tbody>
                        </table>
                    <?php else: ?>
                        <p>No diet information available for this patient.</p>
                    <?php endif; ?>
                </section>

            <?php else: ?>
                <p>Please select a patient to view their details.</p>
            <?php endif; ?>
        </main>
    </div>

</body>
</html>
