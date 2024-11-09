<%@ page import="java.util.List" %>
<%@ page import="model.Book" %>
<%@ page import="controller.UserDao" %>

<%
    UserDao userDao = new UserDao();
    List<Book> books = userDao.getAllBooks();
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Manage Books</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/manageBooks.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css" crossorigin="anonymous">
    <script src="${pageContext.request.contextPath}/manageBooks.js" defer></script>
</head>
<body>
    <!-- Display success or failure messages -->
    <%
        String message = request.getParameter("message");
        if (message != null && !message.isEmpty()) {
    %>
        <div class="alert"><%= message %></div>
    <%
        }
    %>

    <!-- Back to Home Link -->
    <nav class="navbar">
        <a href="home.jsp" class="back-link"><i class="fas fa-arrow-left"></i> Back to Home</a>
    </nav>

    <!-- Manage Books Section -->
    <section class="manage-books-section">
        <!-- Add Book Form -->
        <div class="form-container">
            <h2>Add New Book</h2>
            <form id="addBookForm" action="BookServlet?action=addBook" method="POST">
                <input type="text" name="title" placeholder="Book Title" required>
                <input type="text" name="isbnCode" placeholder="ISBN Code" required>
                <input type="number" name="edition" placeholder="Edition" required>
                <input type="number" name="year" placeholder="Publication Year" required>
                <input type="text" name="publisherName" placeholder="Publisher Name" required>
                <input type="text" name="shelfId" placeholder="Shelf ID" required>
                <select name="bookStatus" required>
                    <option value="AVAILABLE">Available</option>
                    <option value="BORROWED">Borrowed</option>
                    <option value="RESERVED">Reserved</option>
                </select>
                <button type="submit" class="btn-submit">Add Book</button>
            </form>
        </div>

        <!-- Book List -->
        <div class="book-list">
            <h2>Available Books</h2>
            <table>
                <thead>
                    <tr>
                        <th>Title</th>
                        <th>ISBN Code</th>
                        <th>Year</th>
                        <th>Shelf</th>
                        <th>Status</th>
                        <th>Actions</th>
                    </tr>
                </thead>
                <tbody id="bookTableBody">
                    <% for (Book book : books) { %>
                        <tr data-book-id="<%= book.getBookId() %>">
                            <td><%= book.getTitle() %></td>
                            <td><%= book.getIsbnCode() %></td>
                            <td><%= book.getPublicationYear() %></td>
                            <td><%= book.getShelf() != null ? book.getShelf().getShelfId() : "Unassigned" %></td>
                            <td><%= book.getBookStatus() %></td>
                            <td>
                                <button onclick="openEditForm('<%= book.getBookId() %>')" class="action-btn edit">Edit</button>
                                <button onclick="assignToShelf('<%= book.getBookId() %>')" class="action-btn assign">Assign to Shelf</button>
                                <button onclick="deleteBook('<%= book.getBookId() %>')" class="action-btn delete">Delete</button>
                            </td>
                        </tr>
                    <% } %>
                </tbody>
            </table>
        </div>
    </section>
</body>
</html>
