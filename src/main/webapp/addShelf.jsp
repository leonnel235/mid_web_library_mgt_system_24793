<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Add Shelf</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f4f4f4;
            margin: 0;
            padding: 0;
        }
        .container {
            width: 60%;
            max-width: 600px;
            margin: 50px auto;
            padding: 30px;
            border: 1px solid #ddd;
            border-radius: 8px;
            background-color: #fff;
            box-shadow: 0 4px 12px rgba(0, 0, 0, 0.1);
        }
        h2 {
            text-align: center;
            color: #333;
        }
        form {
            display: flex;
            flex-direction: column;
            gap: 20px;
        }
        label {
            font-weight: bold;
            font-size: 14px;
            color: #555;
        }
        input[type="text"],
        input[type="number"],
        select {
            padding: 10px;
            font-size: 16px;
            border: 1px solid #ccc;
            border-radius: 5px;
            width: 100%;
            box-sizing: border-box;
        }
        select {
            appearance: none;
            -webkit-appearance: none;
        }
        .form-group {
            display: flex;
            flex-direction: column;
            gap: 5px;
        }
        button {
            padding: 12px;
            background-color: #0062cc;
            color: white;
            font-size: 16px;
            border: none;
            border-radius: 5px;
            cursor: pointer;
            transition: background-color 0.3s ease;
        }
        button:hover {
            background-color: #004b99;
        }
        /* Responsive Styling */
        @media (max-width: 600px) {
            .container {
                width: 90%;
                padding: 20px;
            }
        }
    </style>
</head>
<body>
    <div class="container">
        <h2>Add New Shelf</h2>
        <form action="ShelfServlet" method="post">
            <input type="hidden" name="action" value="addShelf">
          
            <!-- Membership Type Dropdown -->
            <div class="form-group">
                <label for="bookCategory">Book Category:</label>
                <select id="bookCategory" name="bookCategory" required>
                    <option value="">Select Membership</option>
                    <option value="Gold">Gold - 50 Rwf/day, 5 books max</option>
                    <option value="Silver">Silver - 30 Rwf/day, 3 books max</option>
                    <option value="Striver">Striver - 10 Rwf/day, 2 books max</option>
                </select>
            </div>

            <!-- Initial Stock -->
            <div class="form-group">
                <label for="initialStock">Initial Stock:</label>
                <input type="number" id="initialStock" name="initialStock" min="0" required placeholder="Enter initial stock">
            </div>

            <!-- Room ID -->
            <div class="form-group">
                <label for="roomId">Room ID:</label>
                <input type="text" id="roomId" name="roomId" required placeholder="Enter Room ID">
            </div>

            <!-- Submit Button -->
            <button type="submit">Add Shelf</button>
        </form>
    </div>
</body>
</html>
