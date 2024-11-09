<%@ page import="java.util.List" %>
<%@ page import="model.Room" %>
<%@ page import="controller.UserDao" %>
<%
    UserDao userDao = new UserDao();
    List<Room> rooms = userDao.getAllRooms();
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Count Books in Room</title>
    <link rel="stylesheet" type="text/css" href="countBooksInRoom.css">
</head>
<body>
    <nav class="navbar">
        <a href="home.jsp" class="back-link">Back to Home</a>
    </nav>
    <div class="container">
        <h2>Count Books in Room</h2>
        <!-- Updated form method to POST -->
        <form id="countForm" action="RoomServlet" method="post" onsubmit="return fetchBookCount(event)">
            <div class="form-group">
                <label for="roomId">Select Room:</label>
                <select id="roomId" name="roomId" required>
                    <option value="">Select Room</option>
                    <% for (Room room : rooms) { %>
                        <option value="<%= room.getRoomId() %>"><%= room.getRoomCode() %></option>
                    <% } %>
                </select>
            </div>
            <button type="submit" class="btn-submit">Check Book Count</button>
        </form>
        <p id="message"></p>
    </div>
    <script src="countBooksInRoom.js"></script>
</body>
</html>
