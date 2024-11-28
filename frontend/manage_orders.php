<?php
include_once 'db_connection.php';
include_once 'fetch_medication_orders.php'; // For adding/deleting orders

// Fetch orders with medication and patient names
$query = "
    SELECT 
        mo.id, 
        CONCAT(p.firstName, ' ', p.lastName) AS patientName,
        m.name AS medicationName, 
        mo.dateOrdered, 
        mo.frequency, 
        mo.dosage 
    FROM 
        MedicationOrder AS mo
    INNER JOIN 
        Medications AS m 
    ON 
        mo.medication = m.id
    INNER JOIN 
        Patients AS p 
    ON 
        mo.patient = p.id
";
$result = $conn->query($query);

if (!$result) {
    die("Database query failed: " . $conn->error);
}

$orders = $result->fetch_all(MYSQLI_ASSOC);

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
    <link rel="stylesheet" href="styles/styles_manage_orders.css">
    <script src="logout_dropdown.js" defer></script>
</head>
<body>
    <!-- Header Section -->
    <header>
        <div class="header-left">
            <img src="images/company_logo.png" alt="Nutrimed Health Logo" class="logo">
        </div>
        <nav class="navbar">
            <a href="dashboard.php">Home</a>
            <a href="medication_rounds.php">Medication Rounds</a>
            <a href="diet_rounds.php">Diet Regime Rounds</a>
            <a href="patient_records.php">Patient Records</a>
            <a href="manage_orders.php" class="active">Manage Orders</a>
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
                        <a href="logout.php">Logout</a>
                    </div>
                </div>
            </div>
        </div> 
    </header>

    <!-- Search and Action Buttons -->
    <div class="search-container">
        <input type="text" id="search-name" placeholder="Search Patient Name" class="search-input" onkeypress="handleSearch(event)">
        <input type="text" id="search-id" placeholder="Search Patient ID" class="search-input" onkeypress="handleSearch(event)">
        <a href="add_prescription.php" class="add-button">Add New Prescription</a>
    </div>

    <!-- Main Content Section -->
    <main class="orders-section">
        <h2>All Past Orders</h2>

        <form method="POST" action="manage_orders.php">
            <div class="orders-table-container">
                <table class="orders-table">
                    <thead>
                        <tr>
                            <th>Select</th>
                            <th>ID</th>
                            <th>Patient</th>
                            <th>Medication</th>
                            <th>Date Ordered</th>
                            <th>Daily Frequency</th>
                            <th>Dosage</th>
                        </tr>
                    </thead>
                    <tbody id="orders-list">
                        <?php foreach ($orders as $order): ?>
                            <tr data-id="<?php echo $order['id']; ?>" data-name="<?php echo strtolower($order['patientName']); ?>">
                                <td><input type="checkbox" name="order_ids[]" value="<?php echo $order['id']; ?>"></td>
                                <td><?php echo $order['id']; ?></td>
                                <td><?php echo $order['patientName']; ?></td>
                                <td><?php echo $order['medicationName']; ?></td>
                                <td><?php echo $order['dateOrdered']; ?></td>
                                <td><?php echo $order['frequency']; ?></td>
                                <td><?php echo $order['dosage']; ?></td>
                            </tr>
                        <?php endforeach; ?>
                    </tbody>
                </table>
            </div>

            <button type="submit" name="delete_orders" class="delete-button">Delete Selected Orders</button>
        </form>
    </main>

    <!-- JavaScript for Searching -->
    <script>
        function handleSearch(event) {
            // Check if Enter key was pressed
            if (event.key === 'Enter') {
                event.preventDefault(); // Prevent default Enter behavior

                const nameInput = document.getElementById('search-name').value.toLowerCase();
                const idInput = document.getElementById('search-id').value.toLowerCase();
                const rows = document.querySelectorAll('#orders-list tr');

                rows.forEach(row => {
                    const rowId = row.getAttribute('data-id');
                    const rowName = row.getAttribute('data-name');

                    // Determine visibility based on the inputs
                    if (
                        (idInput && nameInput && rowId.includes(idInput) && rowName.includes(nameInput)) ||
                        (idInput && !nameInput && rowId.includes(idInput)) ||
                        (!idInput && nameInput && rowName.includes(nameInput)) ||
                        (!idInput && !nameInput) // Show all rows if both inputs are empty
                    ) {
                        row.style.display = ''; // Show the row
                    } else {
                        row.style.display = 'none'; // Hide the row
                    }
                });
            }
        }
    </script>
</body>

</html>
