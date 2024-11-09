<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <title>Insert Shelf</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f4f4f9;
        }
        .container {
            width: 50%;
            margin: auto;
            border: 1px solid #ddd;
            padding: 20px;
            border-radius: 5px;
            background-color: #fff;
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
        input[type="text"],
        input[type="number"] {
            padding: 8px;
            font-size: 14px;
            border: 1px solid #ccc;
            border-radius: 3px;
        }
        button {
            padding: 10px;
            background-color:  #0069d9;
            color: white;
            font-size: 16px;
            border: none;
            border-radius: 3px;
            cursor: pointer;
            transition: background-color 0.3s ease;
        }
        button:hover {
            background-color:purple;
        }
    </style>
</head>
<body>
<div class="container">
    <h2>Insert New Shelf</h2>
    <form action="RoomServlet" method="post">
        <input type="hidden" name="action" value="insertShelf">
        
        <label for="roomCode">Room Code:</label>
        <input type="text" id="roomCode" name="roomCode" required>
        
        <label for="bookCategory">Book Category:</label>
        <input type="text" id="bookCategory" name="bookCategory" required>
        
        <label for="availableStock">Available Stock:</label>
        <input type="number" id="availableStock" name="availableStock" min="0" required>

        <label for="initialStock">Initial Stock:</label>
        <input type="number" id="initialStock" name="initialStock" min="0" required>

        <button type="submit">Insert Shelf</button>
    </form>
</div>
</body>
</html>
