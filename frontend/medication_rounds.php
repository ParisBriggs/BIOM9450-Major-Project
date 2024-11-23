<?php
include_once 'fetch_medication_data.php';

// Get the selected date and round from the URL or default values
$date = isset($_GET['date']) ? $_GET['date'] : date('Y-m-d'); // Default to today's date
$round = isset($_GET['round']) ? $_GET['round'] : 'morning'; // Default to morning

// Fetch medications based on the selected date and round
$medicationData = getMedicationData($date, $round);
?>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Medication Rounds</title>
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@400;500;600;700&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="styles/styles_patient_records.css">
    <style>
        table {
            width: 100%;
            border-collapse: collapse;
            margin: 20px 0;
            font-size: 18px;
            text-align: left;
        }
        th, td {
            padding: 12px;
            border-bottom: 1px solid #ddd;
        }
        th {
            background-color: #f4f4f4;
        }
        img {
            border-radius: 50%;
            width: 50px;
            height: 50px;
        }
    </style>
</head>
<body>
<header>
    <nav class="navbar">
        <a href="dashboard.html">Home</a>
        <a href="medication_rounds.php" class="active">Medication Rounds</a>
        <a href="diet_rounds.html">Diet Regime Rounds</a>
        <a href="patient_records.php">Patient Records</a>
        <a href="manage_orders.php">Manage Orders</a>
        <a href="generate_reports.html">Generate Reports</a>
    </nav>
</header>

<main>
    <h1>Medication Rounds</h1>

    <!-- Filter Form -->
    <form method="GET" action="">
        <label for="date">Select Date:</label>
        <input type="date" name="date" id="date" value="<?php echo $date; ?>">

        <label for="round">Select Round:</label>
        <select name="round" id="round">
            <option value="morning" <?php echo ($round == 'morning') ? 'selected' : ''; ?>>Morning</option>
            <option value="afternoon" <?php echo ($round == 'afternoon') ? 'selected' : ''; ?>>Afternoon</option>
            <option value="evening" <?php echo ($round == 'evening') ? 'selected' : ''; ?>>Evening</option>
        </select>

        <button type="submit">Filter</button>
    </form>

    <!-- Display Filtered Data -->
    <?php if (!empty($medicationData)): ?>
        <h2>Medications for <?php echo $date; ?> - <?php echo ucfirst($round); ?> Round</h2>
        <table>
            <thead>
                <tr>
                    <th>Patient Image</th>
                    <th>Patient Name</th>
                    <th>Medication</th>
                    <th>Dosage</th>
                    <th>Status</th>
                </tr>
            </thead>
            <tbody>
                <?php foreach ($medicationData as $data): ?>
                    <tr>
                        <td><img src="images/patient_placeholder.png" alt="Patient Image"></td>
                        <td>Patient <?php echo $data['patientId']; ?></td>
                        <td>Medication <?php echo $data['medicationId']; ?></td>
                        <td><?php echo $data['dosage']; ?></td>
                        <td><?php echo ucfirst($data['status']); ?></td>
                    </tr>
                <?php endforeach; ?>
            </tbody>
        </table>
    <?php else: ?>
        <p>No medications found for <?php echo $date; ?> - <?php echo ucfirst($round); ?> Round.</p>
    <?php endif; ?>
</main>
</body>
</html>
