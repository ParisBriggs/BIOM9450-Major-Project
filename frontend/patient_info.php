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
                </div>
        
                <div class="form-group">
                    <label for="lastname">Last Name:<span class="required">*</span></label>
                    <input type="text" id="lastname" name="lastname" required>
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
                    <label for="patient_phone">Phone:<span class="required">*</span></label>
                    <input id="patient_phone" type="tel" name="patient_phone" placeholder="Enter patient's phone number" required>
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
                </div>
        
                <div class="form-group">
                    <label for="room">Room: <span class="required">*</span></label>
                    <select id="room" name="room" required>
                        <option value="101">WB.101</option>
                        <option value="102">WB.102</option>
                        <option value="103">WB.103</option>
                        <option value="104">WB.104</option>
                    </select>
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
                    <label for="em_phone">Phone:<span class="required">*</span></label>
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
                <button type="submit" class="save-button">Save Patient Details</button>
            </div>
        </form>
    </div>


<script> 
//NOTE : the notes section of the form is not validated or required 

function validateForm(event) {
    event.preventDefault(); // Prevent the default form submission behavior

    let isValid = true; // Flag to track overall validity
    let errorMessages = []; // Array to collect error messages

    // Get form fields
    const firstname = document.getElementById('firstname').value.trim();
    const lastname = document.getElementById('lastname').value.trim();
    const dob = document.getElementById('dob').value;
    const email = document.getElementById('email').value.trim();
    const phone = document.getElementById('patient_phone').value.trim();
    const sex = document.querySelector('input[name="sex"]:checked');
    const room = document.getElementById('room').value;
    const emFirstname = document.getElementById('em_firstname').value.trim();
    const emLastname = document.getElementById('em_lastname').value.trim();
    const emEmail = document.getElementById('em_email').value.trim();
    const emPhone = document.getElementById('em_phone').value.trim();
    const relationship = document.getElementById('relationship').value;
    const otherRelationship = document.getElementById('other-relationship').value.trim();

    // Validate required fields
    if (!firstname) errorMessages.push("First name is required.");
    if (!lastname) errorMessages.push("Last name is required.");
    if (!dob) errorMessages.push("Date of birth is required.");
    if (!sex) errorMessages.push("Sex must be selected.");
    if (!room) errorMessages.push("Room must be selected.");
    if (!emFirstname) errorMessages.push("Emergency contact first name is required.");
    if (!emLastname) errorMessages.push("Emergency contact last name is required.");
    if (!relationship) errorMessages.push("Relationship must be selected.");
    if (relationship === "other" && !otherRelationship) errorMessages.push("Please specify the 'Other' relationship.");


// Function to validate phone numbers (including international format with '+' and country code)
function validatePhoneNumber(phoneNumber) {
    // Regular expression to allow international phone numbers with the '+' symbol at the start
    const phonePattern = /^[+]{0,1}[0-9]{1,4}[0-9]{6,14}$/;
    return phonePattern.test(phoneNumber);
}

// Inside your validation function
function validateForm(event) {
    event.preventDefault(); // Prevent form submission until validation is complete

    let isValid = true; // Flag to track overall validity
    let errorMessages = []; // Array to collect error messages

    // Get form fields
    const phone = document.getElementById('patient_phone').value.trim();
    const emPhone = document.getElementById('em_phone').value.trim();

    // Validate the patient's phone number
    if (!validatePhoneNumber(phone)) {
        isValid = false;
        errorMessages.push("Valid phone number with country code is required.");
    }

    // Validate the emergency contact's phone number
    if (!validatePhoneNumber(emPhone)) {
        isValid = false;
        errorMessages.push("Valid emergency contact phone number with country code is required.");
    }

    // If there are validation errors, display them
    if (!isValid) {
        alert("Please fix the following errors:\n" + errorMessages.join("\n"));
    } else {
        // Proceed with form submission (for now, you can alert a success message)
        alert("Details were saved!");
        // Normally, you'd submit the form here (e.g., document.forms[0].submit())
    }
}

    //  email validation
    if (email && !/^[^\s@]+@[^\s@]+\.[^\s@]+$/.test(email)) errorMessages.push("Invalid email format.");
    if (emEmail && !/^[^\s@]+@[^\s@]+\.[^\s@]+$/.test(emEmail)) errorMessages.push("Invalid emergency contact email format.");

    // Check if there are any errors
    if (errorMessages.length > 0) {
        alert("Please fix the following errors:\n" + errorMessages.join("\n"));
        isValid = false;
    }

    // If form is valid, proceed with submission
    if (isValid) {
        alert("Details were saved!"); // Display success message
        event.target.submit(); // Submit the form programmatically
    }
}

// Function to toggle visibility of "Other Relationship" textbox
function toggleOtherTextbox() {
    const relationship = document.getElementById('relationship').value;
    const otherGroup = document.getElementById('other-relationship-group');
    if (relationship === "other") {
        otherGroup.style.display = "block";
    } else {
        otherGroup.style.display = "none";
    }
}

// Function to update the file name display
function updateFileName(input) {
    const fileNameSpan = input.parentElement.querySelector('.file-name');
    fileNameSpan.textContent = input.files[0]?.name || "No file chosen";
}

// Attach validation and events to the form
document.addEventListener("DOMContentLoaded", () => {
    // Attach validation to the form's submit event
    const form = document.querySelector('form');
    form.addEventListener('submit', validateForm);

    // Attach change event for "Relationship" dropdown
    document.getElementById('relationship').addEventListener('change', toggleOtherTextbox);

    // Attach change event for file input
    document.getElementById('photo').addEventListener('change', (e) => updateFileName(e.target));
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