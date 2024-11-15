// Function to handle the selection of report type and toggle the patient selection dropdown
function selectReportType(type) {
    const patientButton = document.getElementById('patientReportButton');
    const practitionerButton = document.getElementById('practitionerReportButton');
    const patientSelection = document.getElementById('patientSelection');

    // Toggle button appearance and show/hide the patient dropdown
    if (type === 'patient') {
        patientButton.classList.add('selected');
        practitionerButton.classList.remove('selected');
        patientSelection.style.display = 'block'; // Show dropdown for Patient Report
    } else {
        practitionerButton.classList.add('selected');
        patientButton.classList.remove('selected');
        patientSelection.style.display = 'none'; // Hide dropdown for Practitioner Report
    }
}

// Function to generate the report based on the selected report type
function generateReport() {
    const isPatientReport = document.getElementById('patientReportButton').classList.contains('selected');
    const reportType = isPatientReport ? 'patient' : 'practitioner';
    const patientSelect = document.getElementById('patientSelect');
    const patientID = patientSelect.options[patientSelect.selectedIndex].value;
    const patientName = patientSelect.options[patientSelect.selectedIndex].text;

    // Validate the report type selection
    if (!reportType) {
        alert('Please select a report type.');
        return;
    }

    // Generate content based on selected report type
    let reportContent = '';
    if (reportType === 'patient') {
        reportContent = `<h1>Patient Report for ${patientName}</h1>`;
        reportContent += generatePatientReport(patientID);
    } else if (reportType === 'practitioner') {
        const practitionerName = 'Dr. Alex Moore';
        reportContent = `<h1>Practitioner Report for ${practitionerName}</h1>`;
        reportContent += generatePractitionerReport(practitionerName);
    }

    // Convert reportContent to PDF and initiate download
    generatePDF(reportContent);
}

// Helper function to create content for Patient Report
function generatePatientReport(patientID) {
    const patientData = [
        { patientName: "John Doe", room: "101", medication: "Aspirin", food: "Chicken Soup", date: "2024-11-10" },
        { patientName: "John Doe", room: "101", medication: "Atorvastatin", food: "Sandwich", date: "2024-11-15" },
        { patientName: "Jane Smith", room: "102", medication: "Ibuprofen", food: "Salad", date: "2024-11-11" },
        { patientName: "Mike Johnson", room: "103", medication: "Paracetamol", food: "Fruit Mix", date: "2024-11-12" },
        { patientName: "Emma Brown", room: "104", medication: "Metformin", food: "Vegetable Soup", date: "2024-11-13" },
        { patientName: "Chris White", room: "105", medication: "Amoxicillin", food: "Yogurt", date: "2024-11-14" }
    ];

    let report = '<table><tr><th>Room</th><th>Medication</th><th>Food</th><th>Date</th></tr>';
    patientData.forEach((entry) => {
        if (entry.patientName === document.getElementById('patientSelect').selectedOptions[0].text) {
            report += `<tr><td>${entry.room}</td><td>${entry.medication}</td><td>${entry.food}</td><td>${entry.date}</td></tr>`;
        }
    });
    report += '</table>';
    return report;
}

// Helper function to create content for Practitioner Report
function generatePractitionerReport(practitionerName) {
    const practitionerData = [
        { patientName: "John Doe", room: "101", medication: "Aspirin", food: "Chicken Soup", date: "2024-11-10" },
        { patientName: "Jane Smith", room: "102", medication: "Ibuprofen", food: "Salad", date: "2024-11-11" },
        { patientName: "Emma Brown", room: "104", medication: "Metformin", food: "Vegetable Soup", date: "2024-11-13" }
    ];

    let report = '<table><tr><th>Patient</th><th>Room</th><th>Medication</th><th>Food</th><th>Date</th></tr>';
    practitionerData.forEach((entry) => {
        report += `<tr><td>${entry.patientName}</td><td>${entry.room}</td><td>${entry.medication}</td><td>${entry.food}</td><td>${entry.date}</td></tr>`;
    });
    report += '</table>';
    return report;
}

// PDF generation function
function generatePDF(content) {
    const pdfWindow = window.open('', '_blank');
    pdfWindow.document.write(`
        <html>
        <head><title>PDF Report</title></head>
        <body>${content}</body>
        </html>
    `);
    pdfWindow.print();
}
