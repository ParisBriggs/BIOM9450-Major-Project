<?php
include_once 'fetch_report_data.php';

// get med rounds
$medRounds = getMedicationRounds();

// get diet rounds
$dietRounds = getDietRounds();

// Get unique patients for dropdown
$patients = array();
foreach ($medRounds as $round) {
    if (!isset($patients[$round['patient_name']])) {
        $patients[$round['patient_name']] = $round['room_number'];
    }
}
ksort($patients);

// Set placeholder practitioner info
$currentPractitionerUsername = 'emma.brown';
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
        <form action="generate_pdf.php" method="POST" target="_blank">
            <div class="button-group">
                <button type="button" id="patientReportButton" class="toggle-button">Patient Report</button>
                <button type="button" id="practitionerReportButton" class="toggle-button">Practitioner Report</button>
            </div>

            <!-- Hidden inputs for form submission -->
            <input type="hidden" name="reportType" id="reportType" value="patient">
            <input type="hidden" name="practitionerUsername" value="<?php echo htmlspecialchars($currentPractitionerUsername); ?>">

            <!-- Patient Selection Dropdown -->
            <div id="patientSelection" class="conditional-field">
                <label for="patientSelect">Select Patient:</label>
                <select name="patientSelect" id="patientSelect">
                    <?php foreach ($patients as $name => $room): ?>
                        <option value="<?php echo htmlspecialchars($room); ?>"><?php echo htmlspecialchars($name); ?></option>
                    <?php endforeach; ?>
                </select>
            </div>

            <button type="submit" class="generate-button">Generate Report</button>
        </form>
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
        document.addEventListener('DOMContentLoaded', function() {
        const patientButton = document.getElementById('patientReportButton');
        const practitionerButton = document.getElementById('practitionerReportButton');
        const patientSelection = document.getElementById('patientSelection');
        const reportTypeInput = document.getElementById('reportType');
        const generateButton = document.querySelector('.generate-button');

        // Initially hide the patient selection and disable generate button
        patientSelection.style.display = 'none';
        generateButton.disabled = true;
        reportTypeInput.value = '';

        // Remove 'selected' class from both buttons initially
        patientButton.classList.remove('selected');
        practitionerButton.classList.remove('selected');

        // Function to handle report type selection
        function selectReportType(type) {
            if (type === 'patient') {
                patientButton.classList.add('selected');
                practitionerButton.classList.remove('selected');
                patientSelection.style.display = 'block';
                reportTypeInput.value = 'patient';
            } else {
                practitionerButton.classList.add('selected');
                patientButton.classList.remove('selected');
                patientSelection.style.display = 'none';
                reportTypeInput.value = 'practitioner';
            }
            generateButton.disabled = false; // Enable generate button once a type is selected
        }

        // Add click event listeners to buttons
        patientButton.addEventListener('click', () => selectReportType('patient'));
        practitionerButton.addEventListener('click', () => selectReportType('practitioner'));
    });
    
    </script>

    <script src="generate_reports.js"></script>
</body>
</html>