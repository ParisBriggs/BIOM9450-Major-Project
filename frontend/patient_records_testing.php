<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Medication Rounds</title>
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@400;500;600;700&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="styles/styles_patient_records.css">
    <script src="logout_dropdown.js" defer></script>
</head>
<body>
    <!-- Logo and Centered Navigation Bar -->
    <header>
        <div class="header-left">
            <img src="images/company_logo.png" alt="Nutrimed Health Logo" class="logo">
        </div>
        <nav class="navbar">
            <a href="dashboard.html">Home</a>
            <a href="medication_rounds.html">Medication Rounds</a>
            <a href="diet_rounds.html">Diet Regime Rounds</a>
            <a href="patient_records.html" class="active">Patient Records</a>
            <a href="manage_orders.html">Manage Orders</a>
            <a href="generate_reports.html">Generate Reports</a>
            <a href="patient_info.html">Patient Information</a>
        </nav>
        <div class="header-right">
            <div class="ward-profile">
                <span class="ward-info">Ward A</span>
                <div class="dropdown">
                    <button class="dropdown-button" onclick="toggleDropdown()">
                        Rachel Sunway<br><small>Nurse</small>
                    </button>
                    <div id="dropdown-content" class="dropdown-content">
                        <a href="logout.html">Logout</a>
                    </div>
                </div>
            </div>
        </div>        
    </header>

    <!-- Main Content Section -->
    <div class="outer-container">
        <!-- Sidebar with Resident List -->
        <aside class="sidebar">
            <div class="search">
                <input type="text" placeholder="Search Room" class="search-input">
                <input type="text" placeholder="Search Resident" class="search-input">
            </div>
            <div class="resident-list">
                <?php
                include 'fetch_patient_data.php';

                $patients = getPatientsFromProcedure();

                // Check if there are any patients returned
                if (!empty($patients)) {
                    foreach ($patients as $patient) {
                        echo '<div class="resident-item active">
                                <img src="' . $patient['photoUrl'] . '" alt="Resident Photo" class="resident-photo">
                                <span class="room-number">' . $patient['room'] . '</span>
                                <span class="resident-name">' . $patient['fullName'] . '</span>
                            </div>';
                    }
                } else {
                    echo '<div>No patients found in the database.</div>';
                }
                ?>
            </div>
        </aside>
    
        <!-- Main Profile Section -->
        <main class="profile-section">
            <div class="profile-header">
                <img src="images/profile_image_1.jpg" alt="Profile Photo" class="profile-photo">
                <h2>Richard Smith</h2>
            </div>
            <div class="profile-buttons">
                <button class="edit-button">Edit Patient Profile</button>
                <button class="add-button">Add New Patient</button>
            </div>
            
            <!-- Patient Information with Boxes -->
            <div class="profile-info-grid">
                <div class="info-box">
                    <label>Patient ID</label>
                    <span>657891</span>
                </div>
                <div class="info-box">
                    <label>Date of Birth</label>
                    <span>07/01/1944</span>
                </div>
                <div class="info-box">
                    <label>Room Number</label>
                    <span>WA.01</span>
                </div>
                <div class="info-box">
                    <label>Sex</label>
                    <span>Male</span>
                </div>
                <div class="info-box">
                    <label>Blood Type</label>
                    <span>A</span>
                </div>
                <div class="info-box">
                    <label>Medicare Number</label>
                    <span>4783 85527 314</span>
                </div>
                <div class="info-box">
                    <label>Primary GP</label>
                    <span>Dr Joseph Green <br> PH: 0413892472</span>
                </div>
                <div class="info-box">
                    <label>Emergency Contact</label>
                    <span>Bethany Smith <br> PH: 0413892472</span>
                </div>
            </div>

            <!-- Notes Section -->
            <section class="notes-section">
                <h3>Notes</h3>
                <ul>
                    <li>High fall risk</li>
                    <li>Type II diabetic</li>
                </ul>
            </section>
            <hr />
            <!-- Medication Sections -->
            <section class="medication-section">
                <h3>Medication</h3>
                <table>
                    <tr>
                        <th>Medication Name</th>
                        <th>Dosage</th>
                        <th>Frequency</th>
                        <th>Admin Route</th>
                        <th>Date Prescribed</th>
                        <th>Prescribed By</th>
                        <th></th>
                    </tr>
                    <tr>
                        <td>Panadol lol</td>
                        <td>50mg</td>
                        <td>1x / day</td>
                        <td>Oral</td>
                        <td>3 Jan 2021</td>
                        <td>Dr Phan Ho</td>
                        <td>
                            <button class="prescribe-button">
                                <i class="fas fa-prescription-bottle"></i> Prescribe New
                            </button>
                        </td>
                        </tr>
                    <!-- Additional medications -->
                </table>
            </section>

            <hr />
            <!-- Diet Section -->
            <section class="diet-section">
                <h3>Diet</h3>
                <div class="diet-item">
                    <strong>🍽️ Food:</strong> Low sodium, High fat
                </div>
                <div class="diet-item">
                    <strong>🏃‍♂️ Exercise:</strong> 60-minute walk daily
                </div>
                <div class="diet-item">
                    <strong>🌿 Skincare:</strong> Moisturizer, Retinol
                </div>
            </section>
        </main>
    </div>
</body>
</html>