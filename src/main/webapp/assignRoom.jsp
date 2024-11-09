<%@ page import="java.util.List"%>
<%@ page import="model.Room"%>
<%@ page import="controller.UserDao"%>

<%
UserDao userDao = new UserDao();
List<Room> rooms = userDao.getAllRooms();
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Insert Shelf</title>
    <link rel="stylesheet" type="text/css" href="assignRoom.css">
    <script src="assignRoom.js" defer></script>
</head>
<body>
    <nav class="navbar">
        <a href="home.jsp" class="back-link">Back to Home</a>
    </nav>
    <section class="insert-shelf-section">
        <h1>Insert New Shelf</h1>

        <div class="form-container">
            <form id="insertShelfForm">
                <label for="roomCode">Room Code:</label>
                <input type="text" name="roomCode" id="roomCode" required>

                <label for="bookCategory">Book Category:</label>
                <input type="text" name="bookCategory" id="bookCategory" required>

                <label for="availableStock">Available Stock:</label>
                <input type="number" name="availableStock" id="availableStock" required>

                <label for="initialStock">Initial Stock:</label>
                <input type="number" name="initialStock" id="initialStock" required>

                <button type="submit">Insert Shelf</button>
            </form>
        </div>
        <div id="statusMessage" class="status-message"></div>
    </section>
</body>
</html>
