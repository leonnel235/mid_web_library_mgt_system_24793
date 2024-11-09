// Assign a book to a shelf
function assignToShelf(bookId) {
    const shelfId = prompt("Enter Shelf ID to assign:");
    if (shelfId) {
        fetch(`BookServlet?action=assignToShelf&bookId=${bookId}&shelfId=${shelfId}`, {
            method: "POST"
        }).then(response => {
            if (response.ok) {
                alert("Book assigned to shelf successfully!");
                location.reload();
            } else {
                alert("Failed to assign book to shelf.");
            }
        });
    }
}

// Delete a book
function deleteBook(bookId) {
    if (confirm("Are you sure you want to delete this book?")) {
        fetch(`BookServlet?action=deleteBook&bookId=${bookId}`, {
            method: "DELETE"
        }).then(response => {
            if (response.ok) {
                alert("Book deleted successfully!");
                location.reload();
            } else {
                alert("Failed to delete book.");
            }
        });
    }
}

// Open Edit Form Modal
function openEditForm(bookId) {
    fetch(`BookServlet?action=getBook&bookId=${bookId}`)
        .then(response => response.json())
        .then(book => {
            document.getElementById("editBookId").value = book.bookId;
            document.getElementById("editTitle").value = book.title;
            document.getElementById("editIsbnCode").value = book.isbnCode;
            document.getElementById("editEdition").value = book.edition;
            document.getElementById("editYear").value = book.publicationYear;
            document.getElementById("editPublisherName").value = book.publisherName;
            document.getElementById("editBookModal").style.display = "block";
        });
}
