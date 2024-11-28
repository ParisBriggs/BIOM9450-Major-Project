<?php
include_once 'fetch_report_data.php';

if ($_SERVER['REQUEST_METHOD'] == 'POST') {
    $reportType = $_POST['reportType'] ?? '';
    
    if ($reportType === 'patient') {
        $room = $_POST['patientSelect'] ?? '';
        if (empty($room)) {
            die("No room number provided");
        }
        $medRounds = getPatientMedicationRounds($room);
        $dietRounds = getPatientDietRounds($room);
        $name = !empty($medRounds) ? $medRounds[0]['patient_name'] : 
              (!empty($dietRounds) ? $dietRounds[0]['patient_name'] : 'Unknown Patient');
        $title = "Patient Report for " . $name;
    } else {
        // Practitioner report
        $practitionerUsername = $_POST['practitionerUsername'] ?? '';
        if (empty($practitionerUsername)) {
            die("No practitioner username provided");
        }
        $medRounds = getPractitionerMedicationRounds($practitionerUsername);
        $dietRounds = getPractitionerDietRounds($practitionerUsername);
        // Get the practitioner's full name from the first record
        $practitionerName = !empty($medRounds) ? $medRounds[0]['practitioner_name'] : 
                           (!empty($dietRounds) ? $dietRounds[0]['practitioner_name'] : 'Unknown Practitioner');
        $title = "Practitioner Report for " . $practitionerName;
    }
    ?>
    <!DOCTYPE html>
    <html>
    <head>
        <title><?php echo htmlspecialchars($title); ?></title>
        <style>
            body { 
                font-family: Arial, sans-serif; 
                padding: 20px; 
                max-width: 1200px; 
                margin: 0 auto; 
            }
            h1 { 
                color: #333; 
                margin-bottom: 20px; 
                text-align: center;
                padding: 10px;
                border-bottom: 2px solid #333;
            }
            h2 { 
                color: #666; 
                margin-top: 30px;
                padding-bottom: 10px;
                border-bottom: 1px solid #ddd;
            }
            table { 
                width: 100%; 
                border-collapse: collapse; 
                margin-bottom: 30px; 
                background: white;
            }
            th, td { 
                padding: 12px; 
                text-align: left; 
                border: 1px solid #ddd; 
            }
            th { 
                background-color: #f5f5f5; 
                font-weight: bold;
            }
            tr:nth-child(even) { 
                background-color: #f9f9f9; 
            }
            .no-data { 
                color: #666; 
                font-style: italic; 
                padding: 20px;
                text-align: center;
                background: #f5f5f5;
                border: 1px solid #ddd;
                border-radius: 4px;
            }
        </style>
    </head>
    <body>
        <h1><?php echo htmlspecialchars($title); ?></h1>
        
        <h2>Medication Distribution</h2>
        <?php if (!empty($medRounds)): ?>
            <table>
                <thead>
                    <tr>
                        <?php if ($reportType === 'practitioner'): ?>
                            <th>Patient Name</th>
                            <th>Room</th>
                        <?php endif; ?>
                        <th>Medication</th>
                        <?php if ($reportType === 'patient'): ?>
                            <th>Administered By</th>
                        <?php endif; ?>
                        <th>Date</th>
                        <th>Time</th>
                        <th>Status</th>
                    </tr>
                </thead>
                <tbody>
                    <?php foreach ($medRounds as $round): ?>
                        <tr>
                            <?php if ($reportType === 'practitioner'): ?>
                                <td><?php echo htmlspecialchars($round['patient_name']); ?></td>
                                <td><?php echo htmlspecialchars($round['room_number']); ?></td>
                            <?php endif; ?>
                            <td><?php echo htmlspecialchars($round['medication_name']); ?></td>
                            <?php if ($reportType === 'patient'): ?>
                                <td><?php echo htmlspecialchars($round['practitioner_name']); ?></td>
                            <?php endif; ?>
                            <td><?php echo htmlspecialchars($round['round_date']); ?></td>
                            <td><?php echo htmlspecialchars($round['round_time']); ?></td>
                            <td><?php echo htmlspecialchars($round['round_status']); ?></td>
                        </tr>
                    <?php endforeach; ?>
                </tbody>
            </table>
        <?php else: ?>
            <p class="no-data">No medication records found</p>
        <?php endif; ?>

        <h2>Diet Distribution</h2>
        <?php if (!empty($dietRounds)): ?>
            <table>
                <thead>
                    <tr>
                        <?php if ($reportType === 'practitioner'): ?>
                            <th>Patient Name</th>
                            <th>Room</th>
                        <?php endif; ?>
                        <th>Diet</th>
                        <?php if ($reportType === 'patient'): ?>
                            <th>Administered By</th>
                        <?php endif; ?>
                        <th>Time</th>
                        <th>Status</th>
                    </tr>
                </thead>
                <tbody>
                    <?php foreach ($dietRounds as $round): ?>
                        <tr>
                            <?php if ($reportType === 'practitioner'): ?>
                                <td><?php echo htmlspecialchars($round['patient_name']); ?></td>
                                <td><?php echo htmlspecialchars($round['room_number']); ?></td>
                            <?php endif; ?>
                            <td><?php echo htmlspecialchars($round['diet_name']); ?></td>
                            <?php if ($reportType === 'patient'): ?>
                                <td><?php echo htmlspecialchars($round['practitioner_name']); ?></td>
                            <?php endif; ?>
                            <td><?php echo htmlspecialchars($round['round_time']); ?></td>
                            <td><?php echo htmlspecialchars($round['round_status']); ?></td>
                        </tr>
                    <?php endforeach; ?>
                </tbody>
            </table>
        <?php else: ?>
            <p class="no-data">No diet records found</p>
        <?php endif; ?>
    </body>
    </html>
    <?php
}
?>