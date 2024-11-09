document.addEventListener('DOMContentLoaded', function () {
    const locationTypeSelect = document.getElementById('locationType');
    const parentSection = document.getElementById('parentLocationSection');
    const feedbackMessage = document.getElementById('feedbackMessage');

    locationTypeSelect.addEventListener('change', function () {
        if (this.value === 'PROVINCE') {
            parentSection.style.display = 'none';  // Hide parent section
        } else {
            parentSection.style.display = 'block';  // Show parent section
        }
    });

    // Trigger change event on page load to set the correct visibility
    locationTypeSelect.dispatchEvent(new Event('change'));

    // Display feedback message from query parameters
    const urlParams = new URLSearchParams(window.location.search);
    const message = urlParams.get('message');
    const error = urlParams.get('error');

    if (message) {
        feedbackMessage.textContent = message;
        feedbackMessage.style.color = 'green';
        feedbackMessage.style.display = 'block';
    } else if (error) {
        feedbackMessage.textContent = error;
        feedbackMessage.style.color = 'red';
        feedbackMessage.style.display = 'block';
    }
});
