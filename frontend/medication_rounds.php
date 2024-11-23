<?php
include_once 'db_connection.php'; // Ensure this connects to your database

// Get current date
$currentDate = date('Y-m-d');

// Fetch filtered data
$dateFiltered = isset($_GET['date']) ? $_GET['date'] : $currentDate;
$roundTimeFiltered = isset($_GET['roundTime']) ? $_GET['roundTime'] : 'morning';

$query = "SELECT MedicationRound.id AS roundId, orderId, patient, medication, roundTime, status, notes, roundDate
          FROM MedicationRound
          JOIN MedicationOrder ON MedicationRound.orderId = MedicationOrder.id
          WHERE roundDate = ? AND roundTime = ?";
$stmt = $conn->prepare($query);
$stmt->bind_param('ss', $dateFiltered, $roundTimeFiltered);
$stmt->execute();
$result = $stmt->get_result();
$medications = $result->fetch_all(MYSQLI_ASSOC);

// Handle Form Submission
if ($_SERVER['REQUEST_METHOD'] === 'POST' && isset($_POST['updateRounds'])) {
    foreach ($_POST['roundId'] as $key => $roundId) {
        $status = $_POST['status'][$key] ?? NULL;
        $notes = $_POST['notes'][$key] ?? NULL;

        $updateQuery = "UPDATE MedicationRound SET status = ?, notes = ? WHERE id = ?";
        $updateStmt = $conn->prepare($updateQuery);
        $updateStmt->bind_param('ssi', $status, $notes, $roundId);
        $updateStmt->execute();
    }

    header("Location: medication_rounds.php?date=$dateFiltered&roundTime=$roundTimeFiltered&message=Updated successfully");
    exit;
}
?>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Medication Rounds</title>
    <link rel="stylesheet" href="styles_medication_rounds.css">
</head>
<body>
    <h1>Medication Rounds</h1>

    <!-- Filters -->
    <form method="GET" id="filters">
        <label for="date">Select Date:</label>
        <input type="date" id="date" name="date" value="<?php echo $dateFiltered; ?>" onchange="this.form.submit()">

        <label for="roundTime">Select Round:</label>
        <select id="roundTime" name="roundTime" onchange="this.form.submit()">
            <option value="morning" <?php echo ($roundTimeFiltered === 'morning') ? 'selected' : ''; ?>>Morning</option>
            <option value="afternoon" <?php echo ($roundTimeFiltered === 'afternoon') ? 'selected' : ''; ?>>Afternoon</option>
            <option value="evening" <?php echo ($roundTimeFiltered === 'evening') ? 'selected' : ''; ?>>Evening</option>
        </select>
    </form>

    <!-- Medications Table -->
    <form method="POST">
        <table>
            <thead>
                <tr>
                    <th>Patient</th>
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
                            <td><?php echo $medication['patient']; ?></td>
                            <td><?php echo $medication['medication']; ?></td>
                            <td><?php echo ucfirst($medication['roundTime']); ?></td>
                            <td>
                                <?php if ($medication['roundDate'] === $currentDate): ?>
                                    <select name="status[]">
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
                <?php else: ?>
                    <tr>
                        <td colspan="5">No medications found for <?php echo $dateFiltered; ?> - <?php echo ucfirst($roundTimeFiltered); ?> Round.</td>
                    </tr>
                <?php endif; ?>
            </tbody>
        </table>
        <?php if ($dateFiltered === $currentDate): ?>
            <button type="submit" name="updateRounds">Update Rounds</button>
        <?php endif; ?>
    </form>
</body>
</html>
