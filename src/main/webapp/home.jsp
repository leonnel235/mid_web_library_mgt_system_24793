<%@ page import="model.Role" %>
<%@ page import="model.User" %>
<%@ page session="true" %>

<%
    HttpSession currentSession = request.getSession(false);
    User loggedInUser = (currentSession != null) ? (User) currentSession.getAttribute("loggedInUser") : null;

    if (loggedInUser == null) {
        response.sendRedirect("signin.jsp?error=Session expired. Please log in.");
        return;
    }

    Role userRole = loggedInUser.getRole();
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Library Management System - Home</title>
    
    <link rel="stylesheet" href="styles.css">

    <style>
        /* General Styling */
        body {
            font-family: 'Poppins', sans-serif;
            color: #333;
            background: url('images/library.jpg') no-repeat center center fixed;
            background-size: cover;
            margin: 0;
            padding: 0;
            opacity: 0;
            transition: opacity 0.5s ease;
        }

        .fade-in {
            opacity: 1;
            transition: opacity 1s ease-in;
        }

        * {
            box-sizing: border-box;
        }

        /* Navbar */
        .navbar {
            background-color: rgba(255, 255, 255, 0.8);
            position: fixed;
            top: 0;
            width: 100%;
            z-index: 1000;
            box-shadow: 0 4px 15px rgba(0, 0, 0, 0.2);
            display: flex;
            justify-content: space-between;
            align-items: center;
            padding: 10px 20px;
        }

        .navbar a {
            color: blue;
            font-size: 1.2em;
            padding: 10px 15px;
            transition: background 0.3s, color 0.3s;
        }

        .navbar a:hover {
            background-color: purple;
            color: #fff;
            border-radius: 5px;
        }

        .navbar a.active {
            background-color: blue;
        }

        .navbar-menu {
            display: flex;
            list-style: none;
        }

        .navbar-menu li {
            margin: 0 10px;
        }

        /* Hero Section */
        .hero-section {
            height: 100vh;
            display: flex;
            justify-content: center;
            align-items: center;
            color: white;
            text-align: center;
        }

        .hero-overlay {
            background: rgba(0, 0, 0, 0.5);
            padding: 20px;
            border-radius: 10px;
        }

        .hero-overlay h1 {
            font-size: 3.5em;
        }

        .hero-overlay p {
            font-size: 1.5em;
        }

        .hero-overlay .button {
            background-color: blue;
            color: white;
            padding: 12px 25px;
            border-radius: 5px;
            text-decoration: none;
            font-weight: bold;
            transition: background-color 0.3s;
        }

        .hero-overlay .button:hover {
            background-color: purple;
        }

        /* Fade-in animation */
        .featured-section, .welcome-message {
            opacity: 0;
            transform: translateY(20px);
            transition: opacity 1s ease, transform 1s ease;
        }

        .visible {
            opacity: 1;
            transform: translateY(0);
        }

        /* Footer */
        .footer {
            background-color: rgba(0, 0, 0, 0.8);
            color: #fff;
            text-align: center;
            padding: 15px;
            width: 100%;
        }

        .footer a {
            color: #dd9933;
            text-decoration: none;
        }

        .footer a:hover {
            color: purple;
        }
    </style>

    <script>
        document.addEventListener('DOMContentLoaded', function () {
            document.querySelectorAll('.navbar a').forEach(anchor => {
                anchor.addEventListener('click', function (e) {
                    if (this.hash !== "") {
                        e.preventDefault();
                        document.querySelector(this.hash).scrollIntoView({ behavior: 'smooth' });
                    }
                });
            });
        });

        window.addEventListener('load', () => {
            document.body.classList.add('fade-in');
        });

        const observerOptions = { threshold: 0.1 };

        const revealOnScroll = (entries, observer) => {
            entries.forEach(entry => {
                if (entry.isIntersecting) {
                    entry.target.classList.add('visible');
                    observer.unobserve(entry.target);
                }
            });
        };

        const observer = new IntersectionObserver(revealOnScroll, observerOptions);
        document.querySelectorAll('.featured-section, .welcome-message').forEach(section => {
            observer.observe(section);
        });
    </script>
</head>
<body class="fade-in">
    <nav class="navbar">
        <a href="HomePage.jsp" class="navbar-logo">Member Management</a>
        <ul class="navbar-menu">
            <% if (userRole == Role.LIBRARIAN) { %>
                <li><a href="manageBooks.jsp">Manage Books</a></li>
                <li><a href="assignShelf.jsp">Assign Shelf</a></li>
                <li><a href="addShelf.jsp">Add New Shelf</a></li>
                <li><a href="insertShelf.jsp">Assign Rooms</a></li>
                <li><a href="countBooksInRoom.jsp">Check Books in Room</a></li>
            <% } else if (userRole == Role.STUDENT || userRole == Role.TEACHER) { %>
                <li><a href="registerMembership.jsp">Register Membership</a></li>
                <li><a href="borrowBook.jsp">Borrow Books</a></li>
                <li><a href="returnBook.jsp">Return Books</a></li>
            <% } else if (userRole == Role.HOD || userRole == Role.DEAN || userRole == Role.REGISTER || userRole == Role.MANAGER) { %>
                <li><a href="viewReports.jsp">View Reports</a></li>
                <li><a href="manageUsers.jsp">Manage Users</a></li>
            <% } %>
            <li><a href="GetProvince.jsp">Get Province</a></li>
            <li><a href="signin.jsp">Logout</a></li>
        </ul>
    </nav>

    <section class="hero-section">
        <div class="hero-overlay">
            <h1>Welcome, <%= loggedInUser.getFirstName() %>!</h1>
            <p>Explore our library resources and services</p>
            <a href="#welcome" class="button">Learn More</a>
        </div>
    </section>

    <section id="welcome" class="welcome-message">
        <h2>Welcome, <%= userRole %>!</h2>
        <p>Discover a variety of resources available to you as a <%= userRole %> in our library system.</p>
    </section>

    <% if (userRole == Role.LIBRARIAN) { %>
    <section class="featured-section">
        <div class="featured-photo">
            <img src="images/library.jpg" alt="Books Management">
        </div>
        <div class="featured-text">
            <h2>Manage Library Resources</h2>
            <p>Manage books, members, and room assignments easily with the library management system.</p>
        </div>
    </section>
    <% } %>
</body>
</html>
