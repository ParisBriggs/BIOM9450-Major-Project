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

// Handle form submission
if ($_SERVER['REQUEST_METHOD'] == 'POST' && isset($_POST['add_practitioner'])) {
    $firstName = htmlspecialchars(trim($_POST['firstName']));
    $lastName = htmlspecialchars(trim($_POST['lastName']));
    $userName = htmlspecialchars(trim($_POST['userName']));
    $password = htmlspecialchars(trim($_POST['password']));

    // Validation
    $errors = [];

    if (!preg_match('/^[a-zA-Z]+$/', $firstName)) {
        $errors[] = 'First Name must contain only letters.';
    }

    if (!preg_match('/^[a-zA-Z]+$/', $lastName)) {
        $errors[] = 'Last Name must contain only letters.';
    }

    if (strlen($userName) < 5) {
        $errors[] = 'Username must be at least 5 characters long.';
    }

    if (strlen($password) < 8) {
        $errors[] = 'Password must be at least 8 characters long.';
    }

    if (empty($errors)) {
        // Hash the password
        $hashedPassword = password_hash($password, PASSWORD_BCRYPT);

        // Insert practitioner into the database
        $stmt = $conn->prepare('INSERT INTO practitioners (firstName, lastName, userName, password) VALUES (?, ?, ?, ?)');
        $stmt->bind_param('ssss', $firstName, $lastName, $userName, $hashedPassword);

        if ($stmt->execute()) {
            $_SESSION['success_message'] = 'Practitioner successfully added!';
            header('Location: practitioner_info.php'); // Redirect to the manage practitioners page
            exit();
        } else {
            $errors[] = 'Error adding practitioner: ' . $stmt->error;
        }

        $stmt->close();
    }
}
?>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Medication Rounds</title>
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@400;500;600;700&display=swap" rel="stylesheet">    
    <link rel="stylesheet" href="styles/styles_practitioner_info.css">
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
            <a href="manage_orders.php"class="active">Manage Orders</a>
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

    <main class="form-container">
            <h1>You have successfully created this account!</h1>
    </main>

</body>
</html>
