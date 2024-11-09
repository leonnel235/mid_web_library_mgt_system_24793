<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Library Management System</title>
    <link href="https://fonts.googleapis.com/css2?family=Roboto:wght@400;700&display=swap" rel="stylesheet"> <!-- Google Font -->
    <style>
        body {
            font-family: 'Roboto', sans-serif;
            margin: 0;
            padding: 0;
            background-image: url('images/library.jpg');
            background-size: cover;
            background-position: center;
            color: #333;
        }
        .container {
            width: 80%;
            margin: auto;
            overflow: hidden;
            padding: 20px;
            background-color: rgba(255, 255, 255, 0.9);
            border-radius: 10px;
            box-shadow: 0 4px 20px rgba(0, 0, 0, 0.3);
        }
        header {
            text-align: center;
            padding: 20px 0;
        }
        h1 {
            color: #007BFF;
            font-size: 2.5em;
        }
        nav {
            margin: 20px 0;
            text-align: center;
        }
        nav a {
            text-decoration: none;
            color: #FFFFFF;
            background-color: #007BFF;
            padding: 10px 20px;
            border-radius: 5px;
            margin: 0 10px;
            transition: background 0.3s, transform 0.2s;
            box-shadow: 0 2px 10px rgba(0, 0, 0, 0.2);
        }
        nav a:hover {
            background: purple;
            transform: translateY(-2px);
        }
        section {
            margin: 20px 0;
        }
        .role-info {
            margin: 20px 0;
            padding: 15px;
            border: 1px solid #ddd;
            border-radius: 5px;
            background-color: #f9f9f9;
            box-shadow: 0 2px 10px rgba(0, 0, 0, 0.1);
        }
        h2 {
            color: #007BFF;
        }
        footer {
            text-align: center;
            padding: 10px;
            font-size: 0.9em;
            color: #777;
        }
    </style>
</head>
<body>

<div class="container">
    <header>
        <h1>WELCOME TO AUCA LIBRARY MANAGEMENT SYSTEM</h1>
    </header>

    <nav>
        <a href="displayMembershipTypes.jsp">Membership Display</a>
        <a href="viewReports.jsp">View Report</a>
        <a href="signup.jsp">Register as Member</a>
        <a href="createLocation.jsp">Register Location</a>
        <a href="signin.jsp">Logout</a> <!-- Added logout link here -->
    </nav>

    <section>
        <div class="role-info">
            <h2>Librarian Access</h2>
            <p>Librarians can manage all activities related to books, including:</p>
            <ul>
                <li>Approve membership requests</li>
                <li>Assign books to shelves and shelves to rooms</li>
                <li>Check the number of books in specific rooms</li>
                <li>Charge fees for late returns</li>
            </ul>
        </div>

        <div class="role-info">
            <h2>Administrator Access</h2>
            <p>HOD, Dean, Registrar, and Manager can view all details but cannot insert new data. They cannot borrow books.</p>
        </div>

        <div class="role-info">
            <h2>Member Access</h2>
            <p>Students and teachers can register for membership and borrow books, with validation to ensure they do not exceed their borrowing limits.</p>
        </div>
    </section>

    <footer>
        <p>&copy; 2024 Library Management System. All Rights Reserved.</p>
    </footer>
</div>

</body>
</html>
