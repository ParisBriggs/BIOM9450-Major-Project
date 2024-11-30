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
if ($_SERVER['REQUEST_METHOD'] == 'POST' && isset($_POST['add_patient'])) {
    // Patient information
    $firstName = htmlspecialchars(trim($_POST['firstName']));
    $lastName = htmlspecialchars(trim($_POST['lastName']));
    $dob = htmlspecialchars(trim($_POST['dob']));
    $email = htmlspecialchars(trim($_POST['email']));
    $phone = htmlspecialchars(trim($_POST['patient_phone']));
    $sex = htmlspecialchars(trim($_POST['sex']));
    $room = htmlspecialchars(trim($_POST['room']));
    
    // Clean notes - remove bullet points and trim each line
    $notesRaw = htmlspecialchars(trim($_POST['notes']));
    $notesLines = explode("\n", $notesRaw);
    $cleanedLines = [];
    foreach ($notesLines as $line) {
        // Remove bullet point and trim whitespace
        $cleanLine = trim(str_replace('• ', '', $line));
        if (!empty($cleanLine)) {
            $cleanedLines[] = $cleanLine;
        }
    }
    $notes = implode("\n", $cleanedLines);

    // Emergency contact information
    $em_firstName = htmlspecialchars(trim($_POST['em_firstname']));
    $em_lastName = htmlspecialchars(trim($_POST['em_lastname']));
    $em_email = htmlspecialchars(trim($_POST['em_email']));
    $em_phone = htmlspecialchars(trim($_POST['em_phone']));
    $relationship = htmlspecialchars(trim($_POST['relationship']));
    if ($relationship === 'other') {
        $relationship = htmlspecialchars(trim($_POST['other-relationship']));
    }

    // Server-side validation as backup
    $errors = [];

    // Date of Birth validation
    $dobDate = new DateTime($dob);
    $today = new DateTime();
    $minDate = clone $today;
    $minDate->modify('-120 years');
    
    if ($dobDate > $today) {
        $errors[] = 'Date of Birth cannot be in the future.';
    }
    
    if ($dobDate < $minDate) {
        $errors[] = 'Date of Birth cannot be more than 120 years ago.';
    }

    // Patient validation
    if (!preg_match('/^[a-zA-Z\s\'-]+$/', $firstName)) {
        $errors[] = 'First Name must contain only letters, spaces, hyphens, or apostrophes.';
    }

    if (!preg_match('/^[a-zA-Z\s\'-]+$/', $lastName)) {
        $errors[] = 'Last Name must contain only letters, spaces, hyphens, or apostrophes.';
    }

    if (!empty($email) && !preg_match('/^[a-zA-Z0-9._-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,4}$/', $email)) {
        $errors[] = 'Invalid email format.';
    }

    if (!preg_match('/^\d{10}$/', $phone)) {
        $errors[] = 'Phone number must be 10 digits.';
    }

    if (!is_numeric($room)) {
        $errors[] = 'Room number must be numeric.';
    }

    // Emergency contact validation
    if (!preg_match('/^[a-zA-Z\s\'-]+$/', $em_firstName)) {
        $errors[] = 'Emergency Contact First Name must contain only letters, spaces, hyphens, or apostrophes.';
    }

    if (!preg_match('/^[a-zA-Z\s\'-]+$/', $em_lastName)) {
        $errors[] = 'Emergency Contact Last Name must contain only letters, spaces, hyphens, or apostrophes.';
    }

    if (!empty($em_email) && !preg_match('/^[a-zA-Z0-9._-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,4}$/', $em_email)) {
        $errors[] = 'Invalid emergency contact email format.';
    }

    if (!preg_match('/^\d{10}$/', $em_phone)) {
        $errors[] = 'Emergency contact phone number must be 10 digits.';
    }

    // Handle photo upload
    $photoPath = ''; // Default empty path
    if (isset($_FILES['photo']) && $_FILES['photo']['error'] === UPLOAD_ERR_OK) {
        $allowedTypes = ['image/jpeg', 'image/png', 'image/jpg'];
        $fileType = $_FILES['photo']['type'];
        
        if (!in_array($fileType, $allowedTypes)) {
            $errors[] = 'Invalid file type. Only JPG, JPEG and PNG are allowed.';
        } else {
            // Create images directory if it doesn't exist
            $uploadDir = 'images/';
            if (!file_exists($uploadDir)) {
                mkdir($uploadDir, 0777, true);
            }

            // Generate unique filename while keeping original extension
            $fileExtension = pathinfo($_FILES['photo']['name'], PATHINFO_EXTENSION);
            $uniqueFilename = 'profile_image_' . uniqid() . '.' . $fileExtension;
            $uploadPath = $uploadDir . $uniqueFilename;
            
            // Attempt to move uploaded file
            if (move_uploaded_file($_FILES['photo']['tmp_name'], $uploadPath)) {
                $photoPath = $uploadPath;
            } else {
                $errors[] = 'Failed to upload image. Error: ' . error_get_last()['message'];
            }
        }
    }

    if (empty($errors)) {
        // Start transaction
        $conn->begin_transaction();

        try {
            // First insert emergency contact
            $stmt = $conn->prepare('INSERT INTO EmergencyContacts (firstName, lastName, relationship, email, phone) VALUES (?, ?, ?, ?, ?)');
            $stmt->bind_param('sssss', $em_firstName, $em_lastName, $relationship, $em_email, $em_phone);
            $stmt->execute();
            $emergencyContactId = $conn->insert_id;
            $stmt->close();

            // Then insert patient
            $stmt = $conn->prepare('INSERT INTO Patients (firstName, lastName, sex, photo, email, phone, notes, emergencyContact, room, DOB) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?)');
            $stmt->bind_param('sssssssiis', $firstName, $lastName, $sex, $photoPath, $email, $phone, $notes, $emergencyContactId, $room, $dob);
            $stmt->execute();

            // Commit transaction
            $conn->commit();

            $_SESSION['success_message'] = 'Patient successfully added!';
            header('Location: patient_success.php');
            exit();
        } catch (Exception $e) {
            // Rollback transaction on error
            $conn->rollback();
            $errors[] = 'Error adding patient: ' . $e->getMessage();
            
            // If an error occurred after image upload, clean up the uploaded file
            if (!empty($photoPath) && file_exists($photoPath)) {
                unlink($photoPath);
            }
        }
    }
}
?>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Patient Information - Nutrimed Health</title>
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@400;500;600;700&display=swap" rel="stylesheet">    
    <link rel="stylesheet" href="styles/styles_edit_patient_info.css">
    <style>
        .error-message {
            color: #dc2626;
            font-size: 0.875rem;
            margin-top: 0.25rem;
            margin-bottom: 0.5rem;
        }

        .error-input {
            border-color: #dc2626 !important;
            background-color: #fef2f2 !important;
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

    <div class="outer-container">
        <a href="patient_records.php" class="back-button">
            <span>←</span> Back
        </a>

        <form method="POST" action="" enctype="multipart/form-data" class="form-grid">
            <!-- Patient Details Section -->
            <div class="form-section">
                <h2>Create New Patient Account</h2>
                
                <div class="form-group">
                    <label for="firstName">First Name:</label>
                    <input type="text" id="firstName" name="firstName" required>
                </div>
        
                <div class="form-group">
                    <label for="lastName">Last Name:</label>
                    <input type="text" id="lastName" name="lastName" required>
                </div>
        
                <div class="form-group">
                    <label for="dob">Date of Birth:</label>
                    <input type="date" id="dob" name="dob" required>
                </div>

                <div class="form-group">
                    <label for="email">Email:</label>
                    <input type="email" id="email" name="email">
                </div>
        
                <div class="form-group">
                    <label for="patient_phone">Phone:</label>
                    <input id="patient_phone" type="tel" name="patient_phone" placeholder="Enter patient's phone number" required>
                </div>
                
                <div class="form-group">
                    <label>Sex:</label>
                    <div class="radio-group">
                        <label class="radio-label">
                            <input type="radio" name="sex" value="male" required> Male
                        </label>
                        <label class="radio-label">
                            <input type="radio" name="sex" value="female" required> Female
                        </label>
                    </div>
                </div>
        
                <div class="form-group">
                    <label for="room">Room:</label>
                    <input type="text" id="room" name="room" placeholder="Enter room number" required>
                </div>
        
                <div class="form-group">
                    <label for="photo">Photo:</label>
                    <div class="file-input">
                        <label class="choose-file" for="photo">
                            Choose File
                        </label>
                        <span class="file-name">No file chosen</span>
                        <input type="file" id="photo" name="photo" accept=".png, .jpeg, .jpg" onchange="updateFileName(this)">
                    </div>
                </div>
        
                <div class="form-group">
                    <label for="notes">Notes:</label>
                    <textarea id="notes" name="notes" rows="4" placeholder="• Write your note here..."></textarea>
                </div>
            </div>
        
            <!-- Emergency Contact Details Section -->
            <div class="form-section">
                <h2>Emergency Contact Details</h2>
                
                <div class="form-group">
                    <label for="em_firstname">First Name:</label>
                    <input type="text" id="em_firstname" name="em_firstname" required>
                </div>
        
                <div class="form-group">
                    <label for="em_lastname">Last Name:</label>
                    <input type="text" id="em_lastname" name="em_lastname" required>
                </div>
        
                <div class="form-group">
                    <label for="em_email">Email:</label>
                    <input type="email" id="em_email" name="em_email">
                </div>
        
                <div class="form-group">
                    <label for="em_phone">Phone:</label>
                    <input id="em_phone" type="tel" name="em_phone" placeholder="Enter emergency contact's phone number" required>
                </div>
        
                <div class="form-group">
                    <label for="relationship">Relationship:</label>
                    <select id="relationship" name="relationship" required onchange="toggleOtherTextbox()">
                        <option value="" disabled selected>Select Relationship</option>
                        <option value="parent">Parent</option>
                        <option value="partner">Partner</option>
                        <option value="sibling">Sibling</option>
                        <option value="child">Child</option>
                        <option value="friend">Friend</option>
                        <option value="relative">Relative</option>
                        <option value="other">Other</option>
                    </select>
                </div>

                <div class="form-group" id="other-relationship-group" style="display: none;">
                    <label for="other-relationship">Please Specify:</label>
                    <input type="text" id="other-relationship" name="other-relationship" placeholder="Specify other relationship">
                </div>
            
                <div class="form-actions">
                    <button type="submit" name="add_patient" class="save-button">Save Patient Details</button>
                </div>
                <p id="errors"></p>
            </div>
        </form>
    </div>

    <script src="form_validation.js"></script>
    <script>
        function updateFileName(input) {
            const fileName = input.files[0] ? input.files[0].name : 'No file chosen';
            input.parentElement.querySelector('.file-name').textContent = fileName;
        }

        function toggleOtherTextbox() {
            const relationshipSelect = document.getElementById("relationship");
            const otherRelationshipGroup = document.getElementById("other-relationship-group");
            
            if (relationshipSelect.value === "other") {
                otherRelationshipGroup.style.display = "block";
            } else {
                otherRelationshipGroup.style.display = "none";
                document.getElementById("other-relationship").value = "";
            }
        }

        document.getElementById('notes').addEventListener('keydown', function(e) {
            if (e.key === 'Enter') {
                e.preventDefault();
                const start = this.selectionStart;
                const value = this.value;
                
                this.value = value.substring(0, start) + '\n• ' + value.substring(start);
                this.selectionStart = this.selectionEnd = start + 3;
            }
        });

        document.getElementById('notes').addEventListener('focus', function() {
            if (this.value.trim() === '') {
                this.value = '• ';
            }
        });
    </script>
</body>
</html>