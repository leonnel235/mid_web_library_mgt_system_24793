<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Librarian Homepage</title>
    <style>
        body {
            background-image: url('images/library.jpg'); /* Add your image path here */
            background-size: cover;
            font-family: Arial, sans-serif;
            color: #fff;
            text-align: center;
            padding: 20px;
        }
        h1 {
            margin-bottom: 20px;
            font-size: 2.5em;
            text-shadow: 2px 2px 4px rgba(0, 0, 0, 0.7);
        }
        .container {
            background: rgba(0, 0, 0, 0.7); /* Semi-transparent background */
            padding: 30px;
            border-radius: 10px;
            display: inline-block;
            margin: 20px auto;
        }
        button {
            background-color: #007BFF;
            color: white;
            border: none;
            padding: 10px 20px;
            border-radius: 5px;
            cursor: pointer;
            font-size: 1em;
            margin: 10px 5px;
        }
        button:hover {
            background-color: #0056b3;
        }
        a {
            color: #FFD700;
            text-decoration: none;
        }
        a:hover {
            text-decoration: underline;
        }
    </style>
</head>
<body>
    <h1>Welcome to the Librarian Dashboard</h1>
    <div class="container">
        <h2>Manage Memberships</h2>
        <button onclick="location.href='MembershipForm.html'">Approve Membership Requests</button>
    </div>

    <div class="container">
        <h2>Book Management</h2>
        <button onclick="location.href='manageBooks.jsp'">Manage books</button>
        <button onclick="location.href='addShelf.jsp'">Add Shelf</button>
        <button onclick="location.href='assignShelf.jsp'">Assign Books to Shelf</button>
          <button onclick="location.href='GetProvince.jsp'">Get Location by PhoneNumber</button>
        <button onclick="location.href='manageUsers.jsp'"> Manage User</button>
        <button onclick="location.href='viewReports.jsp'">View Reports</button>
    </div>

    <div class="container">
        <h2>Fees Management</h2>
        <button onclick="location.href='countBooksInRoom.jsp'">Count Number of books</button>
    </div>
</body>
</html>
