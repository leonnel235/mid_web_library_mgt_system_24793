document.getElementById('insertShelfForm').addEventListener('submit', function(event) {
    event.preventDefault(); // Prevent the default form submission

    const roomCode = document.getElementById('roomCode').value;
    const bookCategory = document.getElementById('bookCategory').value;
    const availableStock = document.getElementById('availableStock').value;
    const initialStock = document.getElementById('initialStock').value;

    // Perform fetch to submit form data
    fetch('RoomServlet?action=insertShelf', {
        method: 'POST',
        headers: {
            'Content-Type': 'application/x-www-form-urlencoded',
        },
        body: `roomCode=${roomCode}&bookCategory=${bookCategory}&availableStock=${availableStock}&initialStock=${initialStock}`
    })
    .then(response => response.text())
    .then(message => {
        document.getElementById('statusMessage').innerText = message; // Show success or error message
        document.getElementById('insertShelfForm').reset(); // Reset the form fields
    })
    .catch(error => {
        document.getElementById('statusMessage').innerText = 'An error occurred. Please try again.'; // Handle errors
        console.error('Error:', error);
    });
});
