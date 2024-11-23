<?php
include_once 'db_connection.php';
include_once 'fetch_medication_orders.php'; // For adding/deleting orders

// Fetch medications for the dropdown
$medicationQuery = "SELECT id, name FROM Medications";
$medicationResult = $conn->query($medicationQuery);

if (!$medicationResult) {
    die("Database query failed: " . $conn->error);
}

$medications = $medicationResult->fetch_all(MYSQLI_ASSOC);

// Fetch patients for the dropdown
$patientQuery = "SELECT id, CONCAT(firstName, ' ', lastName) AS name FROM Patients";
$patientResult = $conn->query($patientQuery);

if (!$patientResult) {
    die("Database query failed: " . $conn->error);
}

$patients = $patientResult->fetch_all(MYSQLI_ASSOC);
?>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Medication Rounds</title>
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@400;500;600;700&display=swap" rel="stylesheet">    
    <link rel="stylesheet" href="styles/styles_add_prescription.css">
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
            <a href="medication_rounds.html">Medication Rounds</a>
            <a href="diet_rounds.html">Diet Regime Rounds</a>
            <a href="patient_records.php">Patient Records</a>
            <a href="manage_orders.php"class="active">Manage Orders</a>
            <a href="generate_reports.html">Generate Reports</a>
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


    <main class="form-container">
        <div class="form-box">

            <!-- Back Button -->
            <div class="back-button-container">
                <button class="back-button" onclick="window.location.href='manage_orders.php';">← Back</button>
            </div>

            <h2>Add New Prescription</h2>
            <form method="POST" action="manage_orders.php" class="prescription-form">
                <div class="form-group">
                    <label for="patient">Patient:</label>
                    <select name="patient" id="patient" required>
                        <option value="">Select Patient</option>
                        <?php foreach ($patients as $patient): ?>
                            <option value="<?php echo $patient['id']; ?>">
                                <?php echo $patient['name']; ?>
                            </option>
                        <?php endforeach; ?>
                    </select>
                </div>
                <div class="form-group">
                    <label for="medication">Medication:</label>
                    <select name="medication" id="medication" required>
                        <option value="">Select Medication</option>
                        <?php foreach ($medications as $medication): ?>
                            <option value="<?php echo $medication['id']; ?>">
                                <?php echo $medication['name']; ?>
                            </option>
                        <?php endforeach; ?>
                    </select>
                </div>
                <div class="form-group">
                    <label for="dateOrdered">Date Ordered:</label>
                    <input type="date" name="dateOrdered" id="dateOrdered" required>
                </div>
                <div class="form-group">
                    <label for="frequency">Daily Frequency:</label>
                    <input type="number" name="frequency" id="frequency" required>
                </div>
                <div class="form-group">
                    <label for="dosage">Dosage (mg):</label>
                    <input type="number" step="0.01" name="dosage" id="dosage" required>
                </div>
                <div class="form-actions">
                    <button type="submit" name="add_order" class="submit-button">Submit</button>
                </div>
            </form>
        </div>
    </main>

</body>
</html>
