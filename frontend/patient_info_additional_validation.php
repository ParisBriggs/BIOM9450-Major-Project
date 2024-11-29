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

    // Validation
    $errors = [];

    // Patient details validation
    if (!preg_match('/^[a-zA-Z\s\-]+$/', $firstName)) {
        $errors[] = 'First Name must contain only letters, spaces, or hyphens.';
    }

    if (!preg_match('/^[a-zA-Z\s\-]+$/', $lastName)) {
        $errors[] = 'First Name must contain only letters, spaces, or hyphens.';
    }

    if (!empty($email) && !filter_var($email, FILTER_VALIDATE_EMAIL)) {
        $errors[] = 'Invalid email format.';
    }

    // International phone number regex
$phoneRegex = '/^\+?[0-9\s\-()]{7,15}$/';

// Validate phone number format
if (!preg_match($phoneRegex, $phone)) {
    $errors[] = ' Patient Phone number is invalid. Please enter in international format (e.g., +123456789).';
} else {
    // Normalize the phone number by removing spaces, dashes, and parentheses
    $normalizedPhone = preg_replace('/[^\d+]/', '', $phone);

    // Ensure it has a valid length after normalization
    $minLength = 7; // Minimum digits
    $maxLength = 15; // Maximum digits
    $digitCount = strlen(preg_replace('/\D/', '', $normalizedPhone)); // Count digits only

    if ($digitCount < $minLength || $digitCount > $maxLength) {
        $errors[] = "Phone number must have between $minLength and $maxLength digits.";
    }
}

    if (!is_numeric($room)) {
        $errors[] = 'Room number must be numeric.';
    }

    if (strtotime($dob) > time()) {
        $errors[] = 'Date of Birth cannot be in the future.';
    }

    // Emergency contact validation

    if (!preg_match('/^[a-zA-Z\s\-]+$/', $em_firstName)) {
        $errors[] = 'Emergency Contact First Name must contain only letters, spaces, or hyphens.';
    }
    
    if (!preg_match('/^[a-zA-Z\s\-]+$/', $em_lastName)) {
        $errors[] = 'Emergency Contact Last Name must contain only letters, spaces, or hyphens.';
    }
    

    if (!empty($em_email) && !filter_var($em_email, FILTER_VALIDATE_EMAIL)) {
        $errors[] = 'Invalid emergency contact email format.';
    }
 // International phone number regex
 $phoneRegex = '/^\+?[0-9\s\-()]{7,15}$/';

 // Validate phone number format
 if (!preg_match($phoneRegex, $em_phone)) {
     $errors[] = 'Contact Phone number is invalid. Please enter in international format (e.g., +123456789).';
 } else {
     // Normalize the phone number by removing spaces, dashes, and parentheses
     $normalizedPhone = preg_replace('/[^\d+]/', '', $em_phone);
 
     // Ensure it has a valid length after normalization
     $minLength = 7; // Minimum digits
     $maxLength = 15; // Maximum digits
     $digitCount = strlen(preg_replace('/\D/', '', $normalizedPhone)); // Count digits only
 
     if ($digitCount < $minLength || $digitCount > $maxLength) {
         $errors[] = "Phone number must have between $minLength and $maxLength digits.";
     }
 }

// Validate relationship
$allowedRelationships = ['parent', 'partner', 'sibling', 'child', 'friend', 'relative', 'other'];
if (!in_array($relationship, $allowedRelationships)) {
    $errors[] = 'Invalid relationship selected for emergency contact.';
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
            <!-- Display errors if any -->
            <?php if (!empty($errors)): ?>
                <div class="error-messages">
                    <?php foreach ($errors as $error): ?>
                        <p class="error"><?php echo $error; ?></p>
                    <?php endforeach; ?>
                </div>
            <?php endif; ?>

            <!-- Patient Details Section -->
            <div class="form-section">
                <h2>Create New Patient Account</h2>
                
                <div class="form-group">
                    <label for="firstName">First Name:<span class="required">*</span></label>
                    <input type="text" id="firstName" name="firstName" required>
                </div>
        
                <div class="form-group">
                    <label for="lastName">Last Name:<span class="required">*</span></label>
                    <input type="text" id="lastName" name="lastName" required>
                </div>
        
                <div class="form-group">
                    <label for="dob">Date of Birth:<span class="required">*</span></label>
                    <input type="date" id="dob" name="dob" required>
                </div>

                <div class="form-group">
                    <label for="email">Email:<span class="required">*</span></label>
                    <input type="email" id="email" name="email">
                </div>
        
                <div class="form-group">
                    <label for="patient_phone">Phone (international format):<span class="required">*</span></label>
                    <input id="patient_phone" type="tel" name="patient_phone" placeholder="Enter patient's phone number" required>
                </div>
                
                <div class="form-group">
                    <label>Sex:<span class="required">*</span></label>
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
                    <label for="room">Room:<span class="required">*</span></label>
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
                    <label for="em_firstname">First Name:<span class="required">*</span></label>
                    <input type="text" id="em_firstname" name="em_firstname" required>
                </div>
        
                <div class="form-group">
                    <label for="em_lastname">Last Name:<span class="required">*</span></label>
                    <input type="text" id="em_lastname" name="em_lastname" required>
                </div>
        
                <div class="form-group">
                    <label for="em_email">Email:<span class="required">*</span></label>
                    <input type="email" id="em_email" name="em_email">
                </div>
        
                <div class="form-group">
                    <label for="em_phone">Phone (international format):<span class="required">*</span></label>
                    <input id="em_phone" type="tel" name="em_phone" placeholder="Enter emergency contact's phone number" required>
                </div>
        
                <div class="form-group">
                    <label for="relationship">Relationship:<span class="required">*</span></label>
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
            </div>
        </form>
    </div>

    <script>
        function updateFileName(input) {
            const fileName = input.files[0] ? input.files[0].name : 'No file chosen';
            input.parentElement.querySelector('.file-name').textContent = fileName;
        }
        
        function toggleOtherTextbox() {
            const relationshipSelect = document.getElementById('relationship');
            const otherRelationshipGroup = document.getElementById('other-relationship-group');
             // Show or hide the text input based on the selected value
             if (relationshipSelect.value === 'other') {
                 otherRelationshipGroup.style.display = 'block'; // Show the input
                 } else {
                    otherRelationshipGroup.style.display = 'none';  // Hide the input
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