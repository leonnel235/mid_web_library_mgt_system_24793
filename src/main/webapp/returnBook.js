document.getElementById("returnForm").addEventListener("submit", function(event) {
    event.preventDefault(); // Prevent the default form submission

    const reservationId = document.getElementById("borrowerSelect").value;

    if (reservationId) {
        fetch('BorrowerServlet', {
            method: 'POST',
            headers: {
                'Content-Type': 'application/x-www-form-urlencoded',
            },
            body: new URLSearchParams({
                action: 'returnBook',
                reservationId: reservationId
            })
        })
        .then(response => {
            if (!response.ok) {
                throw new Error('Network response was not ok');
            }
            return response.text();
        })
        .then(data => {
            document.getElementById("message").innerText = data;
            document.getElementById("returnForm").reset(); // Reset the form after successful submission
        })
        .catch(error => {
            document.getElementById("message").innerText = 'Error: ' + error.message;
        });
    } else {
        document.getElementById("message").innerText = 'Please select a borrow record.';
    }
});
