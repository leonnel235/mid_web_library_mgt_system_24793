<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page import="java.util.List" %>
<%@ page import="model.Book" %>
<%@ page import="controller.UserDao" %>
<%
    UserDao userDao = new UserDao();
    List<Book> availableBooks = userDao.getAllBooks(); // Assuming this method fetches all available books
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Borrow a Book</title>
    <link rel="stylesheet" href="borrowBook.css">
</head>
<body>
    <nav class="navbar">
        <a href="home.jsp" class="back-link">Back to Home</a>
    </nav>

    <div class="container">
        <h2>Borrow a Book</h2>
        <form id="borrowForm">
            <div class="form-group">
                <label for="bookSelect">Select a Book:</label>
                <select id="bookSelect" name="bookId" required>
                    <option value="">Choose a Book</option>
                    <% for (Book book : availableBooks) { %>
                        <option value="<%= book.getBookId() %>"><%= book.getTitle() %> - <%= book.getIsbnCode() %></option>
                    <% } %>
                </select>
            </div>
            <div class="form-group">
                <label for="dueDate">Due Date:</label>
                <input type="date" id="dueDate" name="dueDate" required>
            </div>
            <button type="submit" class="btn-submit">Borrow Book</button>
        </form>
        <p id="message"></p>
    </div>

    <script src="borrowBook.js"></script>
</body>
</html>
