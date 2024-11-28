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
            <a href="dashboard.php">Home</a>
            <a href="medication_rounds.php">Medication Rounds</a>
            <a href="diet_rounds.php">Diet Regime Rounds</a>
            <a href="patient_records.php">Patient Records</a>
            <a href="manage_orders.php">Manage Orders</a>
            <a href="generate_reports.php" class="active">Generate Reports</a>
            <a href="patient_info.php">Patient Information</a>

        </nav>
        <div class="header-right">
            <div class="ward-profile">
              
                <div class="dropdown">
                    <button class="dropdown-button" onclick="toggleDropdown()"><br><small>Welcome</small>
                        <?php echo $_SESSION['user_name']; ?><br>
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

        <!-- Patient Selection Dropdown, hidden by default -->
        <div id="patientSelection" class="conditional-field" style="display: none;">
            <label for="patientSelect">Select Patient:</label>
            <select id="patientSelect">
                <option value="101">John Doe</option>
                <option value="102">Jane Smith</option>
                <option value="103">Mike Johnson</option>
                <option value="104">Emma Brown</option>
                <option value="105">Chris White</option>
            </select>
        </div>

        <button type="button" onclick="generateReport()" class="generate-button">Generate Report</button>
    </section>

    <!-- Display Table -->
    <section class="data-table">
        <h2>Medication and Food Distribution</h2>
        <table class="report-table">
            <thead>
                <tr>
                    <th>Patient Name</th>
                    <th>Room Number</th>
                    <th>Medication</th>
                    <th>Food</th>
                    <th>Administered By</th>
                    <th>Date</th>
                </tr>
            </thead>
            <tbody id="reportData">
                <tr><td>John Doe</td><td>101</td><td>Aspirin</td><td>Chicken Soup</td><td>Dr. Alex Moore</td><td>2024-11-10</td></tr>
                <tr><td>Jane Smith</td><td>102</td><td>Ibuprofen</td><td>Salad</td><td>Dr. Alex Moore</td><td>2024-11-11</td></tr>
                <tr><td>Mike Johnson</td><td>103</td><td>Paracetamol</td><td>Fruit Mix</td><td>Nurse Lisa Wong</td><td>2024-11-12</td></tr>
                <tr><td>Emma Brown</td><td>104</td><td>Metformin</td><td>Vegetable Soup</td><td>Dr. Alex Moore</td><td>2024-11-13</td></tr>
                <tr><td>Chris White</td><td>105</td><td>Amoxicillin</td><td>Yogurt</td><td>Nurse Ben Lee</td><td>2024-11-14</td></tr>
                <tr><td>John Doe</td><td>101</td><td>Atorvastatin</td><td>Sandwich</td><td>Dr. Alex Moore</td><td>2024-11-15</td></tr>
                <tr><td>Jane Smith</td><td>102</td><td>Lisinopril</td><td>Apple</td><td>Nurse Lisa Wong</td><td>2024-11-15</td></tr>
                <tr><td>Emma Brown</td><td>104</td><td>Insulin</td><td>Salad</td><td>Dr. Alex Moore</td><td>2024-11-16</td></tr>
            </tbody>
        </table>
    </section>

    <script src="generate_reports.js"></script>
</body>
</html>
