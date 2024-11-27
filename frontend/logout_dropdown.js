// Function to toggle the visibility of the dropdown
function toggleDropdown() {
    const dropdown = document.getElementById('dropdown-content');
    dropdown.style.display = dropdown.style.display === 'block' ? 'none' : 'block';
}

// Close the dropdown if the user clicks outside of it
window.addEventListener('click', function(event) {
    const dropdown = document.getElementById('dropdown-content');
    const button = document.querySelector('.dropdown-button');
    if (!button.contains(event.target) && dropdown.style.display === 'block') {
        dropdown.style.display = 'none';
    }
});
