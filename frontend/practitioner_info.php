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
            header('Location: practitioner_success.php'); // Redirect to the manage practitioners page
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
        <div class="form-box">
            <!-- Back Button -->
            <div class="back-button-container">
                <button class="back-button" onclick="window.location.href='dashboard.php';">← Back</button>
            </div>

            <h2>Create New Practitioner Account</h2>

            <form method="POST" action="" class="practitioner-form">
                <div class="form-group">
                    <label for="firstName">First Name:</label>
                    <input type="text" name="firstName" id="firstName" required>
                    <p class="error" id="firstNameError"></p>
                </div>
                <div class="form-group">
                    <label for="lastName">Last Name:</label>
                    <input type="text" name="lastName" id="lastName" required>
                    <p class="error" id="lastNameError"></p>
                </div>
                <div class="form-group">
                    <label for="userName">Username:</label>
                    <input type="text" name="userName" id="userName" required>
                    <p class="error" id="userNameError"></p>
                </div>
                <div class="form-group">
                    <label for="password">Password:</label>
                    <input type="password" name="password" id="password" required>
                    <p class="error" id="passwordError"></p>
                </div>
                <div class="form-actions">
                    <button type="submit" name="add_practitioner" class="submit-button">Submit</button>
                </div>
            </form>
            </div>
            </main>

            <script>
            // Add live validation for each field
            const firstName = document.getElementById('firstName');
            const lastName = document.getElementById('lastName');
            const userName = document.getElementById('userName');
            const password = document.getElementById('password');

            const firstNameError = document.getElementById('firstNameError');
            const lastNameError = document.getElementById('lastNameError');
            const userNameError = document.getElementById('userNameError');
            const passwordError = document.getElementById('passwordError');

            // Validate first name
            firstName.addEventListener('input', () => {
            if (!/^[a-zA-Z]+$/.test(firstName.value)) {
                firstNameError.textContent = 'First Name must contain only letters.';
            } else {
                firstNameError.textContent = '';
            }
            });

            // Validate last name
            lastName.addEventListener('input', () => {
            if (!/^[a-zA-Z]+$/.test(lastName.value)) {
                lastNameError.textContent = 'Last Name must contain only letters.';
            } else {
                lastNameError.textContent = '';
            }
            });

            // Validate username
            userName.addEventListener('input', () => {
            if (userName.value.length < 5) {
                userNameError.textContent = 'Username must be at least 5 characters long.';
            } else {
                userNameError.textContent = '';
            }
            });

            // Validate password
            password.addEventListener('input', () => {
            if (password.value.length < 8) {
                passwordError.textContent = 'Password must be at least 8 characters long.';
            } else {
                passwordError.textContent = '';
            }
            });
            </script>

</body>
</html>
