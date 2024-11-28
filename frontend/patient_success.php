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

// Check if success message exists
if (!isset($_SESSION['success_message'])) {
    // Redirect to patient records page if no success message
    header('Location: patient_records.php');
    exit();
}

// Get the message and clear it from session
$successMessage = $_SESSION['success_message'];
unset($_SESSION['success_message']);
?>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Success - Nutrimed Health</title>
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@400;500;600;700&display=swap" rel="stylesheet">    
    <link rel="stylesheet" href="styles/styles_edit_patient_info.css">
    <script src="logout_dropdown.js" defer></script>
    <style>
        .success-container {
            max-width: 600px;
            margin: 50px auto;
            padding: 20px;
            background: #ffffff;
            border-radius: 8px;
            box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
            text-align: center;
        }

        .success-message {
            color: #2e7d32;
            font-size: 1.2em;
            margin-bottom: 20px;
        }

        .success-buttons {
            display: flex;
            justify-content: center;
            gap: 20px;
            margin-top: 30px;
        }

        .success-button {
            padding: 10px 20px;
            border: none;
            border-radius: 4px;
            cursor: pointer;
            font-weight: 500;
            text-decoration: none;
            transition: background-color 0.3s;
        }

        .primary-button {
            background-color: #1976d2;
            color: white;
        }

        .secondary-button {
            background-color: #f5f5f5;
            color: #333;
        }

        .success-button:hover {
            opacity: 0.9;
        }
    </style>
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

    <div class="success-container">
        <div class="success-message">
            <?php echo htmlspecialchars($successMessage); ?>
        </div>
        <div class="success-buttons">
            <a href="patient_info.php" class="success-button secondary-button">Add Another Patient</a>
            <a href="patient_records.php" class="success-button primary-button">View Patient Records</a>
        </div>
    </div>
</body>
</html>