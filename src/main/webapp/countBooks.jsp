<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <title>Count Books</title>
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
        input[type="text"] {
            padding: 8px;
            font-size: 14px;
            border: 1px solid #ccc;
            border-radius: 3px;
        }
        button {
            padding: 10px;
            background-color: #2196F3;
            color: white;
            font-size: 16px;
            border: none;
            border-radius: 3px;
            cursor: pointer;
            transition: background-color 0.3s ease;
        }
        button:hover {
            background-color: #1e88e5;
        }
    </style>
</head>
<body>
<div class="container">
    <h2>Count Books in Room</h2>
    <form action="RoomServlet" method="get">
        <input type="hidden" name="action" value="countBooks">
        
        <label for="roomId">Room ID:</label>
        <input type="text" id="roomId" name="roomId" required>
        
        <button type="submit">Count Books</button>
    </form>
</div>
</body>
</html>
