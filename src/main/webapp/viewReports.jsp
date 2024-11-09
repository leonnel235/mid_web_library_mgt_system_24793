<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page import="java.util.List" %>
<%@ page import="model.Book" %>
<%@ page import="controller.UserDao" %>

<%
    UserDao userDao = new UserDao();
    List<Book> books = userDao.getAllBooks(); // Assuming this retrieves all books
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>View Reports</title>
    <link rel="stylesheet" type="text/css" href="viewReports.css">
</head>
<body>
    <nav class="navbar">
        <a href="home.jsp" class="back-link">Back to Home</a>
    </nav>
    <div class="container">
        <h2>Book Reports</h2>
        <table>
            <thead>
                <tr>
                    <th>Book ID</th>
                    <th>Title</th>
                    <th>ISBN Code</th>
                    <th>Edition</th>
                    <th>Publication Year</th>
                    <th>Publisher Name</th>
                    <th>Book Status</th>
                </tr>
            </thead>
            <tbody>
                <% for (Book book : books) { %>
                    <tr>
                        <td><%= book.getBookId() %></td>
                        <td><%= book.getTitle() %></td>
                        <td><%= book.getIsbnCode() %></td>
                        <td><%= book.getEdition() %></td>
                        <td><%= book.getPublicationYear() %></td>
                        <td><%= book.getPublisherName() %></td>
                        <td><%= book.getBookStatus() %></td>
                    </tr>
                <% } %>
            </tbody>
        </table>
    </div>

    <script src="viewReports.js"></script>
</body>
</html>
