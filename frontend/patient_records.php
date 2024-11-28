<?php
include_once 'fetch_patient_data.php';

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
            <a href="dashboard.html">Home</a>
            <a href="medication_rounds.php">Medication Rounds</a>
            <a href="diet_rounds.php">Diet Regime Rounds</a>
            <a href="patient_records.php" class="active">Patient Records</a>
            <a href="manage_orders.php">Manage Orders</a>
            <a href="generate_reports.php">Generate Reports</a>
        </nav>
        <div class="header-right">
            <div class="ward-profile">
                <span class="ward-info">Ward A</span>
                <div class="dropdown">
                    <button class="dropdown-button" onclick="toggleDropdown()">
                        Rachel Sunway<br><small>Nurse</small>
                    </button>
                    <div id="dropdown-content" class="dropdown-content">
                        <a href="logout.html">Logout</a>
                    </div>
                </div>
            </div>
        </div>        
    </header>

    <!-- Main Content Section -->
    <div class="outer-container">
        <!-- Sidebar with Resident List -->
        <aside class="sidebar">
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
                        <span><?php echo isset($selectedPatient['dob']) ? $selectedPatient['dob'] : 'N/A'; ?></span>
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
                        <span><?php echo isset($selectedPatient['emergencyContact']) ? $selectedPatient['emergencyContact'] : 'N/A'; ?></span>
                    </div>
                </div>

                <!-- Notes Section -->
                <section class="notes-section">
                    <h3>Notes</h3>
                    <ul>
                        <li><?php echo $selectedPatient['notes']; ?></li>
                    </ul>
                </section>

                <hr />

                <!-- Medications Section -->
                <section class="medication-section">
                    <h3>Medications</h3>
                    <?php if (!empty($medications)): ?>
                        <table>
                            <tr>
                                <th>Medication Name</th>
                                <th>Dosage</th>
                                <th>Frequency</th>
                                <th>Admin Route</th>
                                <th>Date Prescribed</th>
                                <th>Prescribed By</th>
                            </tr>
                            <?php foreach ($medications as $medication): ?>
                                <tr>
                                    <td><?php echo $medication['name']; ?></td>
                                    <td><?php echo $medication['dosage']; ?></td>
                                    <td><?php echo $medication['frequency']; ?></td>
                                    <td><?php echo $medication['route']; ?></td>
                                    <td><?php echo $medication['datePrescribed']; ?></td>
                                    <td><?php echo $medication['prescribedBy']; ?></td>
                                </tr>
                            <?php endforeach; ?>
                        </table>
                    <?php else: ?>
                        <p>No medications found for this patient.</p>
                    <?php endif; ?>
                </section>

                <hr />

                <!-- Diet Section -->
                <section class="diet-section">
                    <h3>Diet</h3>
                    <?php if (!empty($diet)): ?>
                        <?php foreach ($diet as $item): ?>
                            <div class="diet-item">
                                <strong><?php echo $item['type']; ?>:</strong> <?php echo $item['description']; ?>
                            </div>
                        <?php endforeach; ?>
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
