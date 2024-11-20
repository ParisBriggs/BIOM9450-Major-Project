<?php
require_once 'config.php';

error_reporting(E_ALL);
ini_set('display_errors', 1);

try {
    $pdo = new PDO("mysql:host=" . DB_HOST . ";dbname=" . DB_NAME, DB_USER, DB_PASS);
    $pdo->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION);

    if ($_SERVER["REQUEST_METHOD"] == "POST") {
        $photo_path = null;

        if(isset($_FILES['photo']) && $_FILES['photo']['error'] == 0) {
            error_log("Processing file upload...");
            
            // Check file size (5MB limit)
            if ($_FILES['photo']['size'] > 5000000) {
                throw new Exception('File size too large. Maximum is 5MB.');
            }

            // Check file type
            $allowed_types = ['image/jpeg', 'image/png', 'image/jpg'];
            if (!in_array($_FILES['photo']['type'], $allowed_types)) {
                throw new Exception('Invalid file type. Only JPG and PNG are allowed.');
            }

            // Generate filename
            $file_extension = strtolower(pathinfo($_FILES["photo"]["name"], PATHINFO_EXTENSION));
            $new_filename = uniqid() . '.' . $file_extension;
            
            // Set correct paths
            $upload_directory = '../frontend/images/';
            $target_file = $upload_directory . $new_filename;
            $db_file_path = 'images/' . $new_filename;

            error_log("Upload directory: " . $upload_directory);
            error_log("Target file: " . $target_file);
            
            if (!file_exists($upload_directory)) {
                error_log("Creating directory: " . $upload_directory);
                if (!mkdir($upload_directory, 0777, true)) {
                    throw new Exception("Failed to create upload directory");
                }
            }

            if (!move_uploaded_file($_FILES["photo"]["tmp_name"], $target_file)) {
                error_log("Failed to move uploaded file. Error code: " . $_FILES['photo']['error']);
                throw new Exception("Failed to save uploaded file");
            }

            error_log("File successfully moved to: " . $target_file);
            $photo_path = $db_file_path;
            error_log("Database path set to: " . $photo_path);
        }

        // Emergency Contact Details
        $ec_firstname = trim($_POST['em_firstname']);
        $ec_lastname = trim($_POST['em_lastname']);
        $ec_relationship = trim($_POST['relationship']);
        $ec_email = trim($_POST['em_email']);
        $emergency_phone = preg_replace('/[^0-9]/', '', $_POST['em_phone']);

        // GP Details
        $gp_firstname = trim($_POST['gp_firstname']);
        $gp_lastname = trim($_POST['gp_lastname']);
        $gp_practicename = trim($_POST['gp_practicename']);
        $gp_phone = preg_replace('/[^0-9]/', '', $_POST['gp_phone']);
        $gp_email = trim($_POST['gp_email']);
        $gp_address = trim($_POST['gp_address']);
        
        // Patient Details
        $p_firstname = trim($_POST['firstname']);
        $p_lastname = trim($_POST['lastname']);
        $p_sex = strtolower($_POST['sex']);
        $p_email = trim($_POST['email']);
        $patient_phone = preg_replace('/[^0-9]/', '', $_POST['phone']);
        $p_notes = trim($_POST['notes']);
        $p_room = $_POST['room'];
        $p_dob = $_POST['dob'];
        $p_bloodtype = $_POST['bloodtype'];
        $p_allergies = isset($_POST['allergies']) ? $_POST['allergies'] : '';

        // Validate phone numbers
        if (strlen($patient_phone) > 0 && strlen($patient_phone) != 10) {
            throw new Exception("Invalid patient phone number");
        }
        if (strlen($emergency_phone) != 10) {
            throw new Exception("Invalid emergency contact phone number");
        }
        if (strlen($gp_phone) != 10) {
            throw new Exception("Invalid GP phone number");
        }

        // Debug values
        error_log("Values to be inserted:");
        error_log("Photo path: " . $photo_path);
        error_log("Patient name: " . $p_firstname . " " . $p_lastname);

        // Prepare and execute statement with new parameters
        $stmt = $pdo->prepare("CALL InsertPatientWithContact(?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)");
        
        $params = [
            // Emergency Contact Details
            $ec_firstname,
            $ec_lastname, 
            $ec_relationship,
            $ec_email,
            $emergency_phone,
            // GP Details
            $gp_firstname,
            $gp_lastname,
            $gp_practicename,
            $gp_phone,
            $gp_email,
            $gp_address,
            // Patient Details
            $p_firstname,
            $p_lastname,
            $p_sex,
            $photo_path,
            $p_email,
            $patient_phone,
            $p_notes,
            $p_room,
            $p_dob,
            $p_bloodtype,
            $p_allergies
        ];
        
        error_log("Executing stored procedure with parameters: " . print_r($params, true));
        
        if (!$stmt->execute($params)) {
            $error = $stmt->errorInfo();
            throw new Exception("Database error: " . $error[2]);
        }

        error_log("Database insert completed successfully");
        header("Location: /frontend/patient_records.html?status=success");
        exit();
    }
} catch(Exception $e) {
    error_log("Error in process_patient.php: " . $e->getMessage());
    header("Location: /frontend/edit_patient_info.html?status=error&message=" . urlencode($e->getMessage()));
    exit();
}
?>