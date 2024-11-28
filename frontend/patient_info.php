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
?>



<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Patient Information - Nutrimed Health</title>
    <link rel="stylesheet" href="styles/styles_edit_patient_info.css">
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@400;500;600;700&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/intl-tel-input/17.0.8/css/intlTelInput.min.css">
    <script src="https://cdnjs.cloudflare.com/ajax/libs/intl-tel-input/17.0.8/js/intlTelInput.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/intl-tel-input/17.0.8/js/utils.js"></script>
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
            <a href="patient_info.php"class="active">Patient Information</a>
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
        <form method="POST" action="../connections/process_patient.php" enctype="multipart/form-data" class="form-grid">
            <!-- Patient Details Section -->
            <div class="form-section">
                <h2>Patient Details</h2>
                
                <div class="form-group">
                    <label for="firstname">First Name:<span class="required">*</span></label>
                    <input type="text" id="firstname" name="firstname" required>
                    <span class="validation-feedback"></span>
                </div>
        
                <div class="form-group">
                    <label for="lastname">Last Name:<span class="required">*</span></label>
                    <input type="text" id="lastname" name="lastname" required>
                    <span class="validation-feedback"></span>
                </div>
        
                <div class="form-group">
                    <label for="dob">Date of Birth:<span class="required">*</span></label>
                    <input type="date" id="dob" name="dob" required>
                    <span class="validation-feedback"></span>
                </div>

                <div class="form-group">
                    <label for="email">Email:<span class="required">*</span></label>
                    <input type="email" id="email" name="email">
                    <span class="validation-feedback"></span>
                </div>
        
                <div class="form-group">
                    <label for="patient_phone">Phone:<span class="required">*</span></label>
                    <input id="patient_phone" type="tel" name="patient_phone" placeholder="Enter patient's phone number" required>
                    <span class="validation-feedback"></span>
                </div>
                
                <div class="form-group">
                    <label>Sex: <span class="required">*</span></label>
                    <div class="radio-group">
                        <label class="radio-label">
                            <input type="radio" name="sex" value="male" required> Male
                        </label>
                        <label class="radio-label">
                            <input type="radio" name="sex" value="female" required> Female
                        </label>
                    </div>
                    <span class="validation-feedback"></span>
                </div>
        
                <div class="form-group">
                    <label for="room">Room: <span class="required">*</span></label>
                    <select id="room" name="room" required>
                        <option value="101">WB.101</option>
                        <option value="102">WB.102</option>
                        <option value="103">WB.103</option>
                        <option value="104">WB.104</option>
                    </select>
                    <span class="validation-feedback"></span>
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
                    <span class="validation-feedback"></span>
                </div>
        
                <div class="form-group">
                    <label for="notes">Notes:</label>
                    <textarea id="notes" name="notes" rows="4" placeholder="• Write your note here..."></textarea>
                </div>
                <span class="validation-feedback"></span>
            </div>
        
            <!-- Emergency Contact Details Section -->
            <div class="form-section">
                <h2>Emergency Contact Details</h2>
                
                <div class="form-group">
                    <label for="em_firstname">First Name:<span class="required">*</span></label>
                    <input type="text" id="em_firstname" name="em_firstname" required>
                    <span class="validation-feedback"></span>
                </div>
        
                <div class="form-group">
                    <label for="em_lastname">Last Name:<span class="required">*</span></label>
                    <input type="text" id="em_lastname" name="em_lastname" required>
                    <span class="validation-feedback"></span>
                </div>
        
                <div class="form-group">
                    <label for="em_email">Email:<span class="required">*</span></label>
                    <input type="email" id="em_email" name="em_email">
                    <span class="validation-feedback"></span>
                </div>
        
                <div class="form-group">
                    <label for="em_phone">Phone:<span class="required">*</span></label>
                    <input id="em_phone" type="tel" name="em_phone" placeholder="Enter emergency contact's phone number" required>
                    <span class="validation-feedback"></span>
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
                    <span class="validation-feedback"></span>
                </div>
                <div class="form-group" id="other-relationship-group" style="display: none;">
                    <label for="other-relationship">Please Specify:</label>
                    <input type="text" id="other-relationship" name="other-relationship" placeholder="Specify other relationship">
                    <span class="validation-feedback"></span>
                </div>
            
            <div class="form-actions">
                <button type="submit" class="save-button">Save Patient Details</button>
                <span class="validation-feedback"></span>
            </div>
        </form>
    </div>



    <script>
    document.addEventListener("DOMContentLoaded", () => {
        // Helper function to display validation messages
        function setValidationMessage(input, message) {
            const feedback = input.nextElementSibling;
            if (feedback) {
                feedback.textContent = message;
                feedback.style.color = message ? "red" : "green";
                input.style.borderColor = message ? "red" : "green";
            }
        }

        // Name validation: Letters and spaces only
        const namePattern = /^[A-Za-z\s]+$/;
        const nameFields = [
            document.getElementById("firstname"),
            document.getElementById("lastname"),
            document.getElementById("em_firstname"),
            document.getElementById("em_lastname"),
        ];
        nameFields.forEach((field) => {
            field.addEventListener("input", () => {
                if (!namePattern.test(field.value.trim())) {
                    setValidationMessage(field, "Only letters and spaces are allowed.");
                } else {
                    setValidationMessage(field, "");
                }
            });
        });

        // Phone validation: International format (+, numbers, spaces, 7-15 characters)
        const phonePattern = /^\+?[0-9\s]{7,15}$/;
        const phoneFields = [
            document.getElementById("patient_phone"),
            document.getElementById("em_phone"),
        ];
        phoneFields.forEach((field) => {
            field.addEventListener("input", () => {
                if (!phonePattern.test(field.value.trim())) {
                    setValidationMessage(field, "Enter a valid international phone number (e.g., +123456789).");
                } else {
                    setValidationMessage(field, "");
                }
            });
        });

        // Email validation: Standard email format
        const emailPattern = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;
        const emailFields = [
            document.getElementById("email"),
            document.getElementById("em_email"),
        ];
        emailFields.forEach((field) => {
            field.addEventListener("input", () => {
                if (field.value.trim() && !emailPattern.test(field.value.trim())) {
                    setValidationMessage(field, "Enter a valid email address (e.g., example@domain.com).");
                } else {
                    setValidationMessage(field, "");
                }
            });
        });

        // Relationship validation: Show/hide "Other" textbox dynamically
        const relationshipField = document.getElementById("relationship");
        const otherRelationshipGroup = document.getElementById("other-relationship-group");
        relationshipField.addEventListener("change", () => {
            if (relationshipField.value === "other") {
                otherRelationshipGroup.style.display = "block";
            } else {
                otherRelationshipGroup.style.display = "none";
            }
        });

        // Form submission validation
        document.querySelector("form").addEventListener("submit", (event) => {
            let isValid = true; // Track overall validity
            let errorMessages = [];

            // Check required fields
            nameFields.forEach((field) => {
                if (!field.value.trim()) {
                    isValid = false;
                    setValidationMessage(field, "This field is required.");
                }
            });

            if (!document.querySelector('input[name="sex"]:checked')) {
                isValid = false;
                alert("Sex must be selected."); // Example for radio buttons
            }

            if (!relationshipField.value) {
                isValid = false;
                alert("Relationship must be selected.");
            }

            if (!isValid) {
                event.preventDefault(); // Prevent submission if invalid
            }
        });
    });
</script>



</body>
</html>

<script>
    function updateFileName(input) {
        const fileName = input.files[0] ? input.files[0].name : 'No file chosen';
        input.parentElement.querySelector('.file-name').textContent = fileName;
    }

    document.addEventListener("DOMContentLoaded", function () {
        // Initialize intl-tel-input for Patient Phone
        const patientPhoneInputField = document.querySelector("#patient_phone");
        const patientPhoneInput = window.intlTelInput(patientPhoneInputField, {
            preferredCountries: ["au", "us", "gb", "in", "nz"],
            utilsScript: "https://cdnjs.cloudflare.com/ajax/libs/intl-tel-input/17.0.8/js/utils.js",
        });

        // Initialize intl-tel-input for Emergency Contact Phone
        const emPhoneInputField = document.querySelector("#em_phone");
        const emPhoneInput = window.intlTelInput(emPhoneInputField, {
            preferredCountries: ["au", "us", "gb", "in", "nz"],
            utilsScript: "https://cdnjs.cloudflare.com/ajax/libs/intl-tel-input/17.0.8/js/utils.js",
        });
    });

    function toggleOtherTextbox() {
    const relationshipSelect = document.getElementById("relationship");
    const otherRelationshipGroup = document.getElementById("other-relationship-group");

    if (relationshipSelect.value === "other") {
        otherRelationshipGroup.style.display = "block"; // Show the text box
    } else {
        otherRelationshipGroup.style.display = "none"; // Hide the text box
        document.getElementById("other-relationship").value = ""; // Clear the text box value
    }
}

document.getElementById('notes').addEventListener('keydown', function (e) {
    if (e.key === 'Enter') {
        const start = this.selectionStart;
        const end = this.selectionEnd;
        const value = this.value;
        
        // Add bullet point on new line
        this.value = value.substring(0, start) + '\n• ' + value.substring(end);
        
        // Adjust cursor position
        this.selectionStart = this.selectionEnd = start + 3;
        
        // Prevent default behavior of Enter key
        e.preventDefault();
    }
});

// Add a bullet point to the first line when the textarea gains focus
document.getElementById('notes').addEventListener('focus', function () {
    if (this.value.trim() === '') {
        this.value = '• ';
    }
});
    </script>