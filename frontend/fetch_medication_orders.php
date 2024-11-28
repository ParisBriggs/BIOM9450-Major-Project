<?php
include_once 'db_connection.php'; // Ensure this connects to your database

// Fetch practitioner ID
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

// Explicitly cast prescribedBy to integer
$prescribedBy = $practitionerData['id'];

// Add a new order
if (isset($_POST['add_order'])) {
    $patient = $_POST['patient'];
    $medication = $_POST['medication'];
    $dateOrdered = $_POST['dateOrdered'];
    $frequency = $_POST['frequency'];
    $dosage = $_POST['dosage'];

    $query = "INSERT INTO MedicationOrder (patient, medication, dateOrdered, frequency, dosage, prescribedBy) 
              VALUES (?, ?, ?, ?, ?, ?)";
    $stmt = $conn->prepare($query);
    $stmt->bind_param("iisidi", $patient, $medication, $dateOrdered, $frequency, $dosage, $prescribedBy);

    if ($stmt->execute()) {
        header("Location: manage_orders.php?message=Order added successfully");
    } else {
        die("Error adding order: " . $stmt->error);
    }
}

// Delete selected orders
if (isset($_POST['delete_orders'])) {
    $orderIds = $_POST['order_ids'];

    if (!empty($orderIds)) {
        $placeholders = implode(',', array_fill(0, count($orderIds), '?'));

        // Attempt to delete the selected orders
        try {
            $deleteOrdersQuery = "DELETE FROM MedicationOrder WHERE id IN ($placeholders)";
            $deleteOrdersStmt = $conn->prepare($deleteOrdersQuery);
            $deleteOrdersStmt->bind_param(str_repeat('i', count($orderIds)), ...$orderIds);
            $deleteOrdersStmt->execute();

            // Redirect with a success message
            header("Location: manage_orders.php?message=Orders deleted successfully");
            exit;

        } catch (mysqli_sql_exception $e) {
            // Check if the error is a foreign key constraint error
            if ($e->getCode() == 1451) {
                header("Location: manage_orders.php?error=Sorry, this order cannot be deleted because it is referenced in medication rounds.");
                exit;
            } else {
                // For other errors, display a generic error message
                die("Error deleting orders: " . $e->getMessage());
            }
        }
    } else {
        header("Location: manage_orders.php?error=No orders selected for deletion.");
        exit;
    }
}
?>
