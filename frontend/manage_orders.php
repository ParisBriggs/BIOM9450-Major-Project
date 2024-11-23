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
    <title>Medication Orders</title>
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@400;500;600;700&display=swap" rel="stylesheet">
    <style>
        table {
            width: 100%;
            border-collapse: collapse;
            margin: 20px 0;
            font-size: 16px;
            text-align: left;
        }
        th, td {
            padding: 12px;
            border: 1px solid #ddd;
        }
        th {
            background-color: #f4f4f4;
        }
        form {
            margin: 20px 0;
        }
    </style>
</head>
<body>
    <h1>Medication Orders</h1>

    <!-- Display Success Message -->
    <?php if (isset($_GET['message'])): ?>
        <p id="confirmation-message" style="color: green;">
            <?php echo htmlspecialchars($_GET['message']); ?>
        </p>
        <script>
            // Hide the success message after 20 seconds
            setTimeout(() => {
                const messageElement = document.getElementById('confirmation-message');
                if (messageElement) {
                    messageElement.style.display = 'none';
                }
            }, 5000);
        </script>
    <?php endif; ?>

    <!-- Display Error Message -->
    <?php if (isset($_GET['error'])): ?>
        <p id="error-message" style="color: red;">
            <?php echo htmlspecialchars($_GET['error']); ?>
        </p>
        <script>
            // Hide the error message after 20 seconds
            setTimeout(() => {
                const errorElement = document.getElementById('error-message');
                if (errorElement) {
                    errorElement.style.display = 'none';
                }
            }, 5000);
        </script>
    <?php endif; ?>

    <!-- Display Orders -->
    <form method="POST" action="fetch_medication_orders.php">
        <table>
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
            <tbody>
                <?php foreach ($orders as $order): ?>
                    <tr>
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

    <!-- Delete Orders Button -->
        <button type="submit" name="delete_orders">Delete Selected Orders</button>
    </form>

    <!-- Add New Order Form -->
    <h2>Add New Order</h2>
    <form method="POST" action="medication_order_actions.php">
        <label for="patient">Patient:</label>
        <select name="patient" id="patient" required>
            <option value="">Select Patient</option>
            <?php foreach ($patients as $patient): ?>
                <option value="<?php echo $patient['id']; ?>">
                    <?php echo $patient['name']; ?>
                </option>
            <?php endforeach; ?>
        </select>
        <br>
        <label for="medication">Medication:</label>
        <select name="medication" id="medication" required>
            <option value="">Select Medication</option>
            <?php foreach ($medications as $medication): ?>
                <option value="<?php echo $medication['id']; ?>">
                    <?php echo $medication['name']; ?>
                </option>
            <?php endforeach; ?>
        </select>
        <br>
        <label for="dateOrdered">Date Ordered:</label>
        <input type="date" name="dateOrdered" id="dateOrdered" required>
        <br>
        <label for="frequency">Frequency:</label>
        <input type="number" name="frequency" id="frequency" required>
        <br>
        <label for="dosage">Dosage:</label>
        <input type="number" step="0.01" name="dosage" id="dosage" required>
        <br>
        <button type="submit" name="add_order">Add New Order</button>
    </form>

</body>
</html>
