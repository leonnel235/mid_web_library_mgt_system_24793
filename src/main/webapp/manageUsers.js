function editUser(userId) {
    // Redirect to edit user page
    window.location.href = `editUser.jsp?userId=${userId}`;
}

function deleteUser(userId) {
    if (confirm('Are you sure you want to delete this user?')) {
        // Send request to delete user
        fetch(`UserServlet?action=deleteUser&userId=${userId}`, {
            method: 'POST'
        })
        .then(response => {
            if (response.ok) {
                document.getElementById("message").innerText = "User deleted successfully.";
                setTimeout(() => location.reload(), 1500); // Refresh the page after 1.5 seconds
            } else {
                document.getElementById("message").innerText = "Failed to delete user.";
            }
        })
        .catch(error => {
            document.getElementById("message").innerText = "Error deleting user.";
            console.error("Error:", error);
        });
    }
}
function borrowBook(userId, bookId) {
    fetch(`BookServlet?action=borrowBook&userId=${userId}&bookId=${bookId}`, {
        method: 'POST'
    })
    .then(response => {
        if (response.ok) {
            document.getElementById("message").innerText = "Book borrowed successfully.";
        } else {
            return response.text().then(text => {
                throw new Error(text); // Throw error with server response
            });
        }
    })
    .catch(error => {
        document.getElementById("message").innerText = error.message; // Display error message
    });
}
