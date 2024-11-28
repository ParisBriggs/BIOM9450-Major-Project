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

include_once 'db_connection.php';

// Set the timezone
date_default_timezone_set(timezoneId: 'Australia/Sydney');
$currentDate = date('Y-m-d');

// Fetch the practitioner's ID based on the logged-in user's username
$loggedInUserName = $_SESSION['user_name'];
$practitionerQuery = "SELECT id FROM Practitioners WHERE userName = ?";
$practitionerStmt = $conn->prepare($practitionerQuery);
$practitionerStmt->bind_param('s', $loggedInUserName);
$practitionerStmt->execute();
$practitionerResult = $practitionerStmt->get_result();
$practitionerData = $practitionerResult->fetch_assoc();

if (!$practitionerData) {
    die("Error: Practitioner not found for username $loggedInUserName.");
}

$practitioner = $practitionerData['id']; // Retrieve the practitioner's ID

// Fetch filtered data
$dateFiltered = isset($_GET['date']) ? $_GET['date'] : $currentDate;
$roundTimeFiltered = isset($_GET['roundTime']) ? $_GET['roundTime'] : 'morning';

// Check if diet rounds exist in the database for the selected date and round time
$query = "SELECT 
            DietRound.id AS roundId, 
            DietRound.orderId, 
            CONCAT(Patients.firstName, ' ', Patients.lastName) AS patientName, 
            DietRegimes.name AS dietName, 
            DietRound.roundTime, 
            DietRound.status, 
            DietRound.notes, 
            DietRound.roundDate
        FROM DietRound
        JOIN DietOrder ON DietRound.orderId = DietOrder.id
        JOIN DietRegimes ON DietOrder.dietRegime = DietRegimes.id
        JOIN Patients ON DietOrder.patient = Patients.id
        WHERE DietRound.roundDate = ? AND DietRound.roundTime = ?";

$stmt = $conn->prepare($query);
$stmt->bind_param('ss', $dateFiltered, $roundTimeFiltered);
$stmt->execute();
$result = $stmt->get_result();
$diets = $result->fetch_all(MYSQLI_ASSOC);

// If no rounds exist for the current date and round time, generate dynamically
if (empty($diets) && $dateFiltered === $currentDate) {
    $query = "
        SELECT 
            DietOrder.id AS orderId,
            CONCAT(Patients.firstName, ' ', Patients.lastName) AS patientName,
            DietRegimes.name AS dietName,
            DietOrder.frequency
        FROM DietOrder
        JOIN Patients ON DietOrder.patient = Patients.id
        JOIN DietRegimes ON DietOrder.dietRegime = DietRegimes.id
    ";

    $stmt = $conn->prepare($query);
    $stmt->execute();
    $result = $stmt->get_result();
    $orders = $result->fetch_all(MYSQLI_ASSOC);

    $generatedRounds = [];
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

    // Handle Form Submission for Dynamic Rounds
    if ($_SERVER['REQUEST_METHOD'] === 'POST' && isset($_POST['updateRounds'])) {
        foreach ($_POST['generatedRounds'] as $key => $round) {
            $roundData = json_decode($round, true);
            $insertQuery = "
                INSERT INTO DietRound (orderId, roundTime, roundDate, status, notes, practitioner)
                VALUES (?, ?, ?, ?, ?, ?)
            ";
            $status = $_POST['status'][$key];
            $notes = $_POST['notes'][$key] ?? NULL;

            $insertStmt = $conn->prepare($insertQuery);
            $insertStmt->bind_param('issssi', $roundData['orderId'], $roundData['roundTime'], $dateFiltered, $status, $notes, $practitioner);
            $insertStmt->execute();
        }

        // Redirect to the same page to display the newly created rounds
        header("Location: diet_rounds.php?date=$dateFiltered&roundTime=$roundTimeFiltered&message=Rounds updated successfully");
        exit; 
    }
}
?>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Diet Rounds</title>
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
            <a href="dashboard.php">Home</a>
            <a href="medication_rounds.php">Medication Rounds</a>
            <a href="diet_rounds.php" class="active">Diet Regime Rounds</a>
            <a href="patient_records.php">Patient Records</a>
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

        <!-- Diet Table -->
        <form method="POST">
            <div class="table-container">
                <table class="medication-table">
                    <thead>
                        <tr>
                            <th>Patient Name</th>
                            <th>Diet Regime</th>
                            <th>Round Time</th>
                            <th>Status</th>
                            <th>Notes</th>
                        </tr>
                    </thead>
                    <tbody>
                        <!-- Existing rounds in database -->
                        <?php if (!empty($diets)): ?>
                            <?php foreach ($diets as $diet): ?>
                                <tr>
                                    <td><?php echo htmlspecialchars($diet['patientName'] ?? 'N/A'); ?></td>
                                    <td><?php echo htmlspecialchars($diet['dietName'] ?? 'N/A'); ?></td>
                                    <td><?php echo htmlspecialchars($diet['roundTime'] ?? 'N/A'); ?></td>
                                    <td><?php echo htmlspecialchars($diet['status'] ?? 'N/A'); ?></td>
                                    <td><?php echo htmlspecialchars($diet['notes'] ?? 'N/A'); ?></td>
                                </tr>
                            <?php endforeach; ?>
                        
                        <!-- New rounds in database -->
                        <?php elseif (!empty($generatedRounds)): ?>
                            <?php foreach ($generatedRounds as $index => $round): ?>
                                <tr>
                                    <td><?php echo htmlspecialchars($round['patientName'] ?? 'N/A'); ?></td>
                                    <td><?php echo htmlspecialchars($round['dietName'] ?? 'N/A'); ?></td>
                                    <td><?php echo htmlspecialchars($round['roundTime'] ?? 'N/A'); ?></td>
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
                            <tr><td colspan="5">No data available for the selected date and round.</td></tr>
                        <?php endif; ?>
                    </tbody>
                </table>
            </div>

            <!-- Update rounds button (only when new rounds are being generated) -->
            <?php if (!empty($generatedRounds)): ?>
                <button id="save-button" type="submit" name="updateRounds">Update Rounds</button>
            <?php endif; ?>

        </form>
    </main>
</body>
</html>