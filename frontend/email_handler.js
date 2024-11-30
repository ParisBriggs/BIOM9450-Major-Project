(function() {
    emailjs.init("hfqui_LoP91QF7GmL");
})();

function sendRefusalEmail(patientId, patientName, practitionerName, type) {
    const templateParams = {
        to_email: 'biom9450.majorproject@gmail.com',
        patient_name: patientName,
        patient_id: patientId,
        practitioner_name: practitionerName,
        type: type,
        date_time: new Date().toLocaleString()
    };

    emailjs.send('service_rik9kgb', 'template_rkvio5u', templateParams)
        .then(function(response) {
            console.log('SUCCESS!', response.status, response.text);
        }, function(error) {
            console.log('FAILED...', error);
        });
}