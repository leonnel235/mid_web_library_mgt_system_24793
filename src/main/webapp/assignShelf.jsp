<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%@ page import="java.util.List"%>
<%@ page import="model.Book"%>
<%@ page import="model.Shelf"%>
<%@ page import="controller.UserDao"%>
<%
    UserDao userDao = new UserDao();
    List<Book> books = userDao.getAllBooks();
    List<Shelf> shelves = userDao.getAllShelves();
    
    // Fetch any message from the request
    String message = (String) request.getAttribute("message");
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Assign Book to Shelf</title>
    <link rel="stylesheet" type="text/css" href="assignShelf.css">
</head>
<body>
    <nav class="navbar">
        <a href="home.jsp" class="back-link">Back to Home</a>
    </nav>

    <div class="container">
        <h2>Assign Book to Shelf</h2>
        
        <!-- Display the message if it exists -->
        <p id="message" style="color:red;"><%= message != null ? message : "" %></p>

        <form id="assignForm" action="BookServlet" method="post">
            <input type="hidden" name="action" value="assignToShelf">
            <div class="form-group">
                <label for="bookId">Select Book:</label>
                <select id="bookId" name="bookId" required>
                    <option value="">Select Book</option>
                    <% for (Book book : books) { %>
                        <option value="<%= book.getBookId() %>"><%= book.getTitle() %> - ISBN: <%= book.getIsbnCode() %></option>
                    <% } %>
                </select>
            </div>
            <div class="form-group">
                <label for="shelfId">Select Shelf:</label>
                <select id="shelfId" name="shelfId" required>
                    <option value="">Select Shelf </option>
                    <% for (Shelf shelf : shelves) { %>
                        <option value="<%= shelf.getShelfId() %>"><%= shelf.getBookCategory() %> - Available: <%= shelf.getAvailableStock() %></option>
                    <% } %>
                </select>
            </div>
            <button type="submit" class="btn-submit">Assign Book</button>
        </form>
    </div>
</body>
</html>
