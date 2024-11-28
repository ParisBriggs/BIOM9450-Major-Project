<?php
include_once 'fetch_report_data.php';

/// get med rounds
$medRounds = getMedicationRounds();

// get diet rounds
$dietRounds = getDietRounds();
?>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Medication Rounds</title>
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@400;500;600;700&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="styles/styles_generate_reports.css">
    <script src="logout_dropdown.js" defer></script>
</head>
<body>
    <!-- Logo and Centered Navigation Bar -->
    <header>
        <div class="header-left">
            <img src="images/company_logo.png" alt="Nutrimed Health Logo" class="logo">
        </div>
        <nav class="navbar">
            <a href="dashboard.html">Home</a>
            <a href="medication_rounds.php">Medication Rounds</a>
            <a href="diet_rounds.html">Diet Regime Rounds</a>
            <a href="patient_records.php">Patient Records</a>
            <a href="manage_orders.php">Manage Orders</a>
            <a href="generate_reports.html" class="active">Generate Reports</a>
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
    
    <!-- Report Generator Form -->
    <section class="report-generator">
        <h2>Select Report:</h2>
        <div class="button-group">
            <button id="patientReportButton" onclick="selectReportType('patient')" class="toggle-button">Patient Report</button>
            <button id="practitionerReportButton" onclick="selectReportType('practitioner')" class="toggle-button">Practitioner Report</button>
        </div>

        <!-- Patient Selection Dropdown -->
        <div id="patientSelection" class="conditional-field" style="display: none;">
            <label for="patientSelect">Select Patient:</label>
            <select id="patientSelect">
                <?php
                // Get unique patients from medication rounds
                $patients = array();
                foreach ($medRounds as $round) {
                    $patients[$round['patient_name']] = $round['room_number'];
                }
                foreach ($patients as $name => $room) {
                    echo "<option value=\"$room\">$name</option>";
                }
                ?>
            </select>
        </div>

        <button type="button" onclick="generateReport()" class="generate-button">Generate Report</button>
    </section>

    <!-- Medication Distribution Table -->
    <section class="data-table">
        <h2>Medication Distribution</h2>
        <table class="report-table">
            <thead>
                <tr>
                    <th>Patient Name</th>
                    <th>Room Number</th>
                    <th>Medication</th>
                    <th>Administered By</th>
                    <th>Date</th>
                    <th>Time</th>
                    <th>Status</th>
                </tr>
            </thead>
            <tbody id="reportData">
                <?php foreach ($medRounds as $round): ?>
                <tr>
                    <td><?php echo htmlspecialchars($round['patient_name']); ?></td>
                    <td><?php echo htmlspecialchars($round['room_number']); ?></td>
                    <td><?php echo htmlspecialchars($round['medication_name']); ?></td>
                    <td><?php echo htmlspecialchars($round['practitioner_name']); ?></td>
                    <td><?php echo htmlspecialchars($round['round_date']); ?></td>
                    <td><?php echo htmlspecialchars($round['round_time']); ?></td>
                    <td><?php echo htmlspecialchars($round['round_status']); ?></td>
                </tr>
                <?php endforeach; ?>
            </tbody>
        </table>
    </section>

    <!-- Food Distribution Table -->
    <section class="data-table">
        <h2>Food Distribution</h2>
        <table class="report-table">
            <thead>
                <tr>
                    <th>Patient Name</th>
                    <th>Room Number</th>
                    <th>Diet</th>
                    <th>Administered By</th>
                    <th>Time</th>
                    <th>Status</th>
                </tr>
            </thead>
            <tbody id="reportData">
                <?php foreach ($dietRounds as $round): ?>
                <tr>
                    <td><?php echo htmlspecialchars($round['patient_name']); ?></td>
                    <td><?php echo htmlspecialchars($round['room_number']); ?></td>
                    <td><?php echo htmlspecialchars($round['diet_name']); ?></td>
                    <td><?php echo htmlspecialchars($round['practitioner_name']); ?></td>
                    <td><?php echo htmlspecialchars($round['round_time']); ?></td>
                    <td><?php echo htmlspecialchars($round['round_status']); ?></td>
                </tr>
                <?php endforeach; ?>
            </tbody>
        </table>
    </section>

    <script>
        // Pass PHP data to JavaScript with proper JSON encoding options
        const medicalRounds = <?php echo json_encode($medRounds, JSON_HEX_TAG | JSON_HEX_APOS | JSON_HEX_QUOT | JSON_HEX_AMP); ?>;
        const dietRounds = <?php echo json_encode($dietRounds, JSON_HEX_TAG | JSON_HEX_APOS | JSON_HEX_QUOT | JSON_HEX_AMP); ?>;
        
        // Debug logs with full data expansion
        console.log('Medical Rounds Data:', JSON.stringify(medicalRounds, null, 2));
        console.log('Diet Rounds Data:', JSON.stringify(dietRounds, null, 2));
    </script>

    <script src="generate_reports.js"></script>
</body>
</html>