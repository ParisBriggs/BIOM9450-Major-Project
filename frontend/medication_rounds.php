<?php
include_once 'db_connection.php';

// Get current date
date_default_timezone_set('Australia/Sydney'); // Use your server's local timezone
$currentDate = date('Y-m-d');

// Fetch filtered data
$dateFiltered = isset($_GET['date']) ? $_GET['date'] : $currentDate;
$roundTimeFiltered = isset($_GET['roundTime']) ? $_GET['roundTime'] : 'morning';

// Initialize variables
$medications = [];
$generatedRounds = [];

// For current day
if ($dateFiltered === $currentDate) {
    $query = "
        SELECT 
            MedicationOrder.id AS orderId,
            CONCAT(Patients.firstName, ' ', Patients.lastName) AS patientName,
            Medications.name AS medicationName, 
            MedicationOrder.frequency          
        FROM MedicationOrder
        JOIN Patients ON MedicationOrder.patient = Patients.id
        JOIN Medications ON MedicationOrder.medication = Medications.id
    ";
    $stmt = $conn->prepare($query);
    $stmt->execute();
    $result = $stmt->get_result();
    $orders = $result->fetch_all(MYSQLI_ASSOC);

    foreach ($orders as $order) {
        $frequency = $order['frequency'];
        if ($frequency >= 1 && $roundTimeFiltered === 'morning') {
            $generatedRounds[] = $order + ['roundTime' => 'morning'];
        }
        if ($frequency >= 2 && $roundTimeFiltered === 'afternoon') {
            $generatedRounds[] = $order + ['roundTime' => 'afternoon'];
        }
        if ($frequency == 3 && $roundTimeFiltered === 'evening') {
            $generatedRounds[] = $order + ['roundTime' => 'evening'];
        }
    }

    // Handle Form Submission
    if ($_SERVER['REQUEST_METHOD'] === 'POST' && isset($_POST['generatedRounds'])) {
        foreach ($_POST['generatedRounds'] as $key => $round) {
            $roundData = json_decode($round, true);
    
            // Check if the round already exists
            $checkQuery = "
                SELECT id FROM MedicationRound
                WHERE orderId = ? AND roundTime = ? AND roundDate = ?
            ";
            $checkStmt = $conn->prepare($checkQuery);
            $checkStmt->bind_param('iss', $roundData['orderId'], $roundData['roundTime'], $dateFiltered);
            $checkStmt->execute();
            $checkResult = $checkStmt->get_result();
    
            if ($checkResult->num_rows > 0) {
                // Skip insertion if the round already exists
                continue;
            }
    
            // Insert new round if it doesn't exist
            $insertQuery = "
                INSERT INTO MedicationRound (orderId, roundTime, roundDate, status, notes)
                VALUES (?, ?, ?, ?, ?)
            ";
            $status = $_POST['status'][$key];
            $notes = $_POST['notes'][$key] ?? NULL;
            $insertStmt = $conn->prepare($insertQuery);
            $insertStmt->bind_param('issss', $roundData['orderId'], $roundData['roundTime'], $dateFiltered, $status, $notes);
            $insertStmt->execute();
        }
    
        header("Location: medication_rounds.php?date=$dateFiltered&roundTime=$roundTimeFiltered&message=Rounds updated successfully");
        exit;
    }
    
} else {
    $query = "SELECT 
                MedicationRound.id AS roundId, 
                MedicationRound.orderId, 
                CONCAT(Patients.firstName, ' ', Patients.lastName) AS patientName, 
                Medications.name AS medicationName,
                MedicationRound.roundTime, 
                MedicationRound.status, 
                MedicationRound.notes, 
                MedicationRound.roundDate
            FROM MedicationRound
            JOIN MedicationOrder ON MedicationRound.orderId = MedicationOrder.id
            JOIN Medications ON MedicationOrder.medication = Medications.id 
            JOIN Patients ON MedicationOrder.patient = Patients.id
            WHERE MedicationRound.roundDate = ? AND MedicationRound.roundTime = ?";


        $stmt = $conn->prepare($query);
        $stmt->bind_param('ss', $dateFiltered, $roundTimeFiltered);
        $stmt->execute();
        $result = $stmt->get_result();
        $medications = $result->fetch_all(MYSQLI_ASSOC);
} 
?>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Medication Rounds</title>
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@400;500;600;700&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="styles/styles_medication_rounds.css">
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
            <a href="medication_rounds.php" class="active">Medication Rounds</a>
            <a href="diet_rounds.html">Diet Regime Rounds</a>
            <a href="patient_records.php">Patient Records</a>
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
    <main>
        <!-- Dropdowns for Day and Round Selection -->
        <div class="selection-bar">
            <form method="GET" id="filters">
            <label for="date">Select Date:</label>
            <input type="date" id="date" name="date" value="<?php echo $dateFiltered; ?>" 
               max="<?php echo date('Y-m-d'); ?>" onchange="this.form.submit()">

            <label for="roundTime">Select Round:</label>
            <select id="roundTime" name="roundTime" onchange="this.form.submit()">
                <option value="morning" <?php echo ($roundTimeFiltered === 'morning') ? 'selected' : ''; ?>>Morning</option>
                <option value="afternoon" <?php echo ($roundTimeFiltered === 'afternoon') ? 'selected' : ''; ?>>Afternoon</option>
                <option value="evening" <?php echo ($roundTimeFiltered === 'evening') ? 'selected' : ''; ?>>Evening</option>
            </select>
            </form>
        </div>

    <!-- Medications Table -->
    <form method="POST">
    <div class="table-container">

        <table class="medication-table">
            <thead>
                <tr>
                    <th>Patient Name</th>
                    <th>Medication</th>
                    <th>Round Time</th>
                    <th>Status</th>
                    <th>Notes</th>
                </tr>
            </thead>
            <tbody>
                <?php if (!empty($medications)): ?>
                    <?php foreach ($medications as $medication): ?>
                        <tr>
                            <td><?php echo htmlspecialchars($medication['patientName']); ?></td>
                            <td><?php echo htmlspecialchars($medication['medicationName']); ?></td>
                            <td><?php echo ucfirst($medication['roundTime']); ?></td>

                            <!-- Status -->
                            <td>
                                <?php if ($medication['roundDate'] === $currentDate): ?>
                                    <select name="status[]" class="status-select" required>
                                        <option value="" <?php echo ($medication['status'] === NULL) ? 'selected' : ''; ?>>Select</option>
                                        <option value="given" <?php echo ($medication['status'] === 'given') ? 'selected' : ''; ?>>Given</option>
                                        <option value="refused" <?php echo ($medication['status'] === 'refused') ? 'selected' : ''; ?>>Refused</option>
                                        <option value="no stock" <?php echo ($medication['status'] === 'no stock') ? 'selected' : ''; ?>>No Stock</option>
                                        <option value="fasting" <?php echo ($medication['status'] === 'fasting') ? 'selected' : ''; ?>>Fasting</option>
                                    </select>
                                <?php else: ?>
                                    <?php echo ucfirst($medication['status']); ?>
                                <?php endif; ?>
                            </td>

                            <!-- Notes -->
                            <td>
                                <?php if ($medication['roundDate'] === $currentDate): ?>
                                    <input type="text" name="notes[]" value="<?php echo isset($medication['notes']) ? htmlspecialchars($medication['notes']) : ''; ?>">
                                <?php else: ?>
                                    <?php echo htmlspecialchars($medication['notes']); ?>
                                <?php endif; ?>
                            </td>
                            <input type="hidden" name="roundId[]" value="<?php echo $medication['roundId']; ?>">
                        </tr>
                    <?php endforeach; ?>
                <?php elseif (!empty($generatedRounds)): ?>
                    <?php foreach ($generatedRounds as $index => $round): ?>
                        <tr>
                            <td><?php echo htmlspecialchars($round['patientName']); ?></td>
                            <td><?php echo htmlspecialchars($round['medicationName']); ?></td>
                            <td><?php echo htmlspecialchars($round['roundTime']); ?></td>
                            <td>
                            <select name="status[]" class="status-select" required>
                                <option value="">Select</option>
                                <option value="given">Given</option>
                                <option value="refused">Refused</option>
                                <option value="no stock">No Stock</option>
                                <option value="fasting">Fasting</option>
                            </select>
                            </td>
                            <td><input type="text" name="notes[]" class="notes-input" placeholder="Add notes..."></td>
                            <input type="hidden" name="generatedRounds[]" value="<?php echo htmlspecialchars(json_encode($round)); ?>">
                        </tr>
                    <?php endforeach; ?>
                <?php else: ?>
                    <tr><td colspan="5">No medication rounds found for <?php echo htmlspecialchars($dateFiltered); ?>.</td></tr>
                <?php endif; ?>
            </tbody>
        </table>

    </div>
    
    <!-- Update rounds button -->
    <?php if ($dateFiltered === $currentDate): ?>
        <button id="save-button" type="submit" name="updateRounds">Update Rounds</button>
    <?php endif; ?>
    
    </form>

    <!-- Success message after updating database successfully -->
    <?php if (isset($_GET['message'])): ?>
        <div class="success-message">
            <?php echo htmlspecialchars($_GET['message']); ?>
        </div>
    <?php endif; ?>

</body>
</html>

