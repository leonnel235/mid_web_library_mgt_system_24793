<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page import="java.util.List" %>
<%@ page import="model.User" %>
<%@ page import="controller.UserDao" %>

<%
    UserDao userDao = new UserDao();
    List<User> users = userDao.getAllUsers(); // Fetching all users
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Manage Users</title>
    <link rel="stylesheet" type="text/css" href="manageUsers.css">
</head>
<body>
    <nav class="navbar">
        <a href="home.jsp" class="back-link">Back to Home</a>
    </nav>
    <div class="container">
        <h2>Manage Users</h2>
        <table>
            <thead>
                <tr>
                    <th>User ID</th>
                    <th>Username</th>
                    <th>First Name</th>
                    <th>Last Name</th>
                    <th>Gender</th>
                    <th>Phone Number</th>
                    <th>Role</th>
                    <th>Actions</th>
                </tr>
            </thead>
            <tbody>
                <% for (User user : users) { %>
                    <tr>
                        <td><%= user.getPersonId() %></td>
                        <td><%= user.getUserName() %></td>
                        <td><%= user.getFirstName() %></td>
                        <td><%= user.getLastName() %></td>
                        <td><%= user.getGender() %></td>
                        <td><%= user.getPhoneNumber() %></td>
                        <td><%= user.getRole() %></td>
                        <td>
                            <button class="edit-button" onclick="editUser('<%= user.getPersonId() %>')">Edit</button>
                            <button class="delete-button" onclick="deleteUser('<%= user.getPersonId() %>')">Delete</button>
                        </td>
                    </tr>
                <% } %>
            </tbody>
        </table>
        <p id="message"></p>
    </div>

    <script src="manageUsers.js"></script>
</body>
</html>
