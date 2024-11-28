// Wait for DOM to be fully loaded
document.addEventListener('DOMContentLoaded', function() {
    console.log('Document loaded');
    console.log('Medical Rounds available:', medicalRounds.length);
    console.log('Diet Rounds available:', dietRounds.length);
    
    // Attach event listeners
    document.getElementById('patientReportButton').addEventListener('click', () => selectReportType('patient'));
    document.getElementById('practitionerReportButton').addEventListener('click', () => selectReportType('practitioner'));
    document.querySelector('.generate-button').addEventListener('click', generateReport);
});

function selectReportType(type) {
    console.log('Selecting report type:', type);
    const patientButton = document.getElementById('patientReportButton');
    const practitionerButton = document.getElementById('practitionerReportButton');
    const patientSelection = document.getElementById('patientSelection');

    if (type === 'patient') {
        patientButton.classList.add('selected');
        practitionerButton.classList.remove('selected');
        patientSelection.style.display = 'block';
    } else {
        practitionerButton.classList.add('selected');
        patientButton.classList.remove('selected');
        patientSelection.style.display = 'none';
    }
}

function generateReport() {
    console.log('Generating report...');
    const isPatientReport = document.getElementById('patientReportButton').classList.contains('selected');
    const reportType = isPatientReport ? 'patient' : 'practitioner';
    
    if (!reportType) {
        alert('Please select a report type.');
        return;
    }

    if (reportType === 'patient') {
        const patientSelect = document.getElementById('patientSelect');
        const selectedRoom = patientSelect.value;
        const patientName = patientSelect.options[patientSelect.selectedIndex].text;
        console.log('Generating patient report for:', patientName, 'Room:', selectedRoom);
        generatePatientReport(selectedRoom, patientName);
    } else {
        const practitionerName = document.querySelector('.dropdown-button').textContent.split('\n')[0];
        console.log('Generating practitioner report for:', practitionerName);
        generatePractitionerReport(practitionerName);
    }
}

function generatePatientReport(selectedRoom, patientName) {
    console.log('Filtering data for room:', selectedRoom);
    
    // Filter data for selected patient
    const patientMedRounds = medicalRounds.filter(round => 
        round.room_number === selectedRoom
    );
    const patientDietRounds = dietRounds.filter(round => 
        round.room_number === selectedRoom
    );

    console.log('Found med rounds:', patientMedRounds.length);
    console.log('Found diet rounds:', patientDietRounds.length);

    let reportContent = `
        <html>
        <head>
            <title>Patient Report</title>
            <style>
                body { font-family: Arial, sans-serif; padding: 20px; }
                h1 { color: #333; margin-bottom: 20px; text-align: center; }
                h2 { color: #666; margin-top: 30px; }
                table { width: 100%; border-collapse: collapse; margin-bottom: 30px; }
                th, td { padding: 8px; text-align: left; border: 1px solid #ddd; }
                th { background-color: #f5f5f5; }
                tr:nth-child(even) { background-color: #f9f9f9; }
            </style>
        </head>
        <body>
            <h1>Patient Report for ${patientName}</h1>
            
            <h2>Medication Distribution</h2>
            ${patientMedRounds.length > 0 ? `
                <table>
                    <thead>
                        <tr>
                            <th>Medication</th>
                            <th>Administered By</th>
                            <th>Date</th>
                            <th>Time</th>
                            <th>Status</th>
                        </tr>
                    </thead>
                    <tbody>
                        ${patientMedRounds.map(round => `
                            <tr>
                                <td>${round.medication_name}</td>
                                <td>${round.practitioner_name}</td>
                                <td>${round.round_date}</td>
                                <td>${round.round_time}</td>
                                <td>${round.round_status}</td>
                            </tr>
                        `).join('')}
                    </tbody>
                </table>
            ` : '<p>No medication records found</p>'}

            <h2>Diet Distribution</h2>
            ${patientDietRounds.length > 0 ? `
                <table>
                    <thead>
                        <tr>
                            <th>Diet</th>
                            <th>Administered By</th>
                            <th>Time</th>
                            <th>Status</th>
                        </tr>
                    </thead>
                    <tbody>
                        ${patientDietRounds.map(round => `
                            <tr>
                                <td>${round.diet_name}</td>
                                <td>${round.practitioner_name}</td>
                                <td>${round.round_time}</td>
                                <td>${round.round_status}</td>
                            </tr>
                        `).join('')}
                    </tbody>
                </table>
            ` : '<p>No diet records found</p>'}
        </body>
        </html>
    `;

    const pdfWindow = window.open('', '_blank');
    pdfWindow.document.write(reportContent);
    pdfWindow.document.close();
    setTimeout(() => {
        pdfWindow.print();
    }, 500);
}

function generatePractitionerReport(practitionerName) {
    // Filter data for selected practitioner
    const practitionerMedRounds = medicalRounds.filter(round => 
        round.practitioner_name === practitionerName
    );
    const practitionerDietRounds = dietRounds.filter(round => 
        round.practitioner_name === practitionerName
    );

    let reportContent = `
        <html>
        <head>
            <title>Practitioner Report</title>
            <style>
                body { font-family: Arial, sans-serif; padding: 20px; }
                h1 { color: #333; margin-bottom: 20px; text-align: center; }
                h2 { color: #666; margin-top: 30px; }
                table { width: 100%; border-collapse: collapse; margin-bottom: 30px; }
                th, td { padding: 8px; text-align: left; border: 1px solid #ddd; }
                th { background-color: #f5f5f5; }
                tr:nth-child(even) { background-color: #f9f9f9; }
            </style>
        </head>
        <body>
            <h1>Practitioner Report for ${practitionerName}</h1>
            
            <h2>Medications Administered</h2>
            ${practitionerMedRounds.length > 0 ? `
                <table>
                    <thead>
                        <tr>
                            <th>Patient Name</th>
                            <th>Room</th>
                            <th>Medication</th>
                            <th>Date</th>
                            <th>Time</th>
                            <th>Status</th>
                        </tr>
                    </thead>
                    <tbody>
                        ${practitionerMedRounds.map(round => `
                            <tr>
                                <td>${round.patient_name}</td>
                                <td>${round.room_number}</td>
                                <td>${round.medication_name}</td>
                                <td>${round.round_date}</td>
                                <td>${round.round_time}</td>
                                <td>${round.round_status}</td>
                            </tr>
                        `).join('')}
                    </tbody>
                </table>
            ` : '<p>No medication records found</p>'}

            <h2>Diets Administered</h2>
            ${practitionerDietRounds.length > 0 ? `
                <table>
                    <thead>
                        <tr>
                            <th>Patient Name</th>
                            <th>Room</th>
                            <th>Diet</th>
                            <th>Time</th>
                            <th>Status</th>
                        </tr>
                    </thead>
                    <tbody>
                        ${practitionerDietRounds.map(round => `
                            <tr>
                                <td>${round.patient_name}</td>
                                <td>${round.room_number}</td>
                                <td>${round.diet_name}</td>
                                <td>${round.round_time}</td>
                                <td>${round.round_status}</td>
                            </tr>
                        `).join('')}
                    </tbody>
                </table>
            ` : '<p>No diet records found</p>'}
        </body>
        </html>
    `;

    const pdfWindow = window.open('', '_blank');
    pdfWindow.document.write(reportContent);
    pdfWindow.document.close();
    setTimeout(() => {
        pdfWindow.print();
    }, 500);
}