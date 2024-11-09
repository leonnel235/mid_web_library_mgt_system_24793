<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page import="java.util.List" %>
<%@ page import="model.Borrower" %>
<%@ page import="model.User" %>
<%@ page import="controller.UserDao" %>

<%
    UserDao userDao = new UserDao();
    User loggedInUser = (User) request.getSession().getAttribute("loggedInUser");

    if (loggedInUser == null) {
        response.sendRedirect("signin.jsp");
        return; // Ensure to exit after redirect
    }

    List<Borrower> activeBorrowers = userDao.getActiveBorrowers(loggedInUser.getPersonId());
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Return a Book</title>
    <link rel="stylesheet" href="returnBook.css">
</head>
<body>
    <nav class="navbar">
        <a href="home.jsp" class="back-link">Back to Home</a>
    </nav>

    <div class="container">
        <h2>Return a Book</h2>
        <form id="returnForm" method="post" action="BorrowerServlet">
            <div class="form-group">
                <label for="borrowerSelect">Select Borrow Record:</label>
                <select id="borrowerSelect" name="reservationId" required>
                    <option value="">Choose a Borrow </option>
                    <% for (Borrower borrower : activeBorrowers) { %>
                        <option value="<%= borrower.getReservationId() %>">
                            <%= borrower.getBook().getTitle() %> - Due: <%= borrower.getDueDate() %>
                        </option>
                    <% } %>
                </select>
            </div>
            <button type="submit" class="btn-submit">Return Book</button>
        </form>
        <p id="message"></p>
    </div>

    <script src="returnBook.js"></script>
</body>
</html>
