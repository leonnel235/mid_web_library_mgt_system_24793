<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <title>Manage Books</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f9f9f9;
        }
        .container {
            width: 50%;
            margin: 20px auto;
            padding: 20px;
            background-color: #fff;
            border-radius: 5px;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
        }
        h2 {
            text-align: center;
            color: #333;
        }
        form {
            display: flex;
            flex-direction: column;
            gap: 15px;
        }
        label {
            font-weight: bold;
            color: #555;
        }
        input[type="text"], input[type="number"] {
            padding: 8px;
            font-size: 14px;
            border: 1px solid #ddd;
            border-radius: 3px;
        }
        button {
            padding: 10px;
            background-color: blue;
            color: white;
            font-size: 16px;
            border: none;
            border-radius: 3px;
            cursor: pointer;
            transition: background-color 0.3s ease;
        }
        button:hover {
            background-color: purple;
        }
        .message {
            color: #4CAF50;
            text-align: center;
        }
    </style>
</head>
<body>
<div class="container">
    <h2>Manage Books</h2>
    <c:if test="${not empty param.message}">
        <p class="message">${param.message}</p>
    </c:if>
    <form action="BookServlet" method="post">
        <input type="hidden" name="action" value="${param.action == 'update' ? 'updateBook' : 'addBook'}">
        <label for="title">Title:</label>
        <input type="text" id="title" name="title" required>

        <label for="isbnCode">ISBN Code:</label>
        <input type="text" id="isbnCode" name="isbnCode" required>

        <label for="edition">Edition:</label>
        <input type="number" id="edition" name="edition" required>

        <label for="year">Publication Year:</label>
        <input type="number" id="year" name="year" required>

        <label for="publisherName">Publisher Name:</label>
        <input type="text" id="publisherName" name="publisherName" required>

        <label for="shelfId">Shelf ID (Optional):</label>
        <input type="text" id="shelfId" name="shelfId">

        <label for="bookStatus">Book Status:</label>
        <input type="text" id="bookStatus" name="bookStatus" required>

        <button type="submit">${param.action == 'update' ? 'Update Book' : 'Add Book'}</button>
    </form>
</div>
</body>
</html>
