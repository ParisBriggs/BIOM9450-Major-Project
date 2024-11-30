function validateForm(event) {
    event.preventDefault();
    
    // Clear all previous error messages
    clearErrors();
    
    let isValid = true;
    const errors = [];
    
    // Name validations
    const nameRegex = /^[a-zA-Z\s'-]+$/;
    const emailRegex = /^[a-zA-Z0-9._-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,4}$/;
    const phoneRegex = /^\d{10}$/;
    
    // Patient validation
    if (!nameRegex.test(document.getElementById('firstName').value)) {
        errors.push('First Name must contain only letters, spaces, hyphens, or apostrophes.');
        document.getElementById('firstName').classList.add('error-input');
        isValid = false;
    }
    
    if (!nameRegex.test(document.getElementById('lastName').value)) {
        errors.push('Last Name must contain only letters, spaces, hyphens, or apostrophes.');
        document.getElementById('lastName').classList.add('error-input');
        isValid = false;
    }
    
    const email = document.getElementById('email').value;
    if (email && !emailRegex.test(email)) {
        errors.push('Please enter a valid email address.');
        document.getElementById('email').classList.add('error-input');
        isValid = false;
    }
    
    if (!phoneRegex.test(document.getElementById('patient_phone').value)) {
        errors.push('Phone number must be 10 digits.');
        document.getElementById('patient_phone').classList.add('error-input');
        isValid = false;
    }
    
    const room = document.getElementById('room').value;
    if (!(/^\d+$/).test(room)) {
        errors.push('Room number must be numeric.');
        document.getElementById('room').classList.add('error-input');
        isValid = false;
    }
    
    // Emergency contact validation
    if (!nameRegex.test(document.getElementById('em_firstname').value)) {
        errors.push('Emergency Contact First Name must contain only letters, spaces, hyphens, or apostrophes.');
        document.getElementById('em_firstname').classList.add('error-input');
        isValid = false;
    }
    
    if (!nameRegex.test(document.getElementById('em_lastname').value)) {
        errors.push('Emergency Contact Last Name must contain only letters, spaces, hyphens, or apostrophes.');
        document.getElementById('em_lastname').classList.add('error-input');
        isValid = false;
    }
    
    const emEmail = document.getElementById('em_email').value;
    if (emEmail && !emailRegex.test(emEmail)) {
        errors.push('Please enter a valid emergency contact email address.');
        document.getElementById('em_email').classList.add('error-input');
        isValid = false;
    }
    
    if (!phoneRegex.test(document.getElementById('em_phone').value)) {
        errors.push('Emergency contact phone number must be 10 digits.');
        document.getElementById('em_phone').classList.add('error-input');
        isValid = false;
    }
    
    if (!isValid) {
        showErrors(errors);
        return false;
    } else {
        // If validation passes, submit form data
        const form = event.target;
        const formData = new FormData(form);
        
        // Make sure to include the add_patient parameter
        formData.append('add_patient', '1');

        // Submit the form data
        fetch(form.action || window.location.href, {
            method: 'POST',
            body: formData,
            // Add this to follow redirects
            redirect: 'follow'
        })
        .then(response => {
            // Always go to patient_success.php on successful save
            if (response.ok) {
                window.location.href = 'patient_success.php';
            } else {
                showErrors(['An error occurred while saving. Please try again.']);
            }
        })
        .catch(error => {
            console.error('Error:', error);
            showErrors(['An error occurred while saving. Please try again.']);
        });
    }
}

function showErrors(errors) {
    const errorElement = document.getElementById('errors');
    errorElement.innerHTML = errors.join('<br>');
    errorElement.style.color = '#dc2626';
}

function clearErrors() {
    // Clear the error messages
    const errorElement = document.getElementById('errors');
    errorElement.innerHTML = '';
    
    // Remove error styling from inputs
    document.querySelectorAll('.error-input').forEach(input => {
        input.classList.remove('error-input');
    });
}

// Add form submit event listener when DOM is loaded
document.addEventListener('DOMContentLoaded', function() {
    const form = document.querySelector('form');
    form.setAttribute('novalidate', ''); // Disable browser default validation
    form.addEventListener('submit', validateForm);
});