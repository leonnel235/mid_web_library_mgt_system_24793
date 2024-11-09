// borrowBook.js

document.getElementById('borrowForm').addEventListener('submit', function(event) {
    event.preventDefault();

    const bookId = document.getElementById('bookSelect').value;
    const dueDate = document.getElementById('dueDate').value;

    if (!bookId || !dueDate) {
        document.getElementById('message').textContent = "Please select a book and specify a due date.";
        return;
    }

    fetch('BorrowerServlet', {
        method: 'POST',
        headers: { 'Content-Type': 'application/x-www-form-urlencoded' },
        body: `action=borrowBook&bookId=${bookId}&dueDate=${dueDate}`
    })
    .then(response => {
        if (response.ok) {
            document.getElementById('message').textContent = "Book borrowed successfully!";
            document.getElementById('borrowForm').reset(); // Reset form
        } else {
            document.getElementById('message').textContent = "You could not borrow the Book ";
        }
    })
    .catch(error => {
        document.getElementById('message').textContent = "Network error. Please try again.";
    });
});
