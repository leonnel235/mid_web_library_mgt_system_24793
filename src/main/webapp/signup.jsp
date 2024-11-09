<%@ page import="java.util.List" %>
<%@ page import="model.Location" %>
<%@ page import="controller.UserDao" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Sign Up </title>
    <!-- Bootstrap CSS -->
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">

    <style>
        /* Internal CSS for a professional admin dashboard look */
        body {
            font-family: Arial, sans-serif;
            background: #f4f6f9;
            color: #495057;
        }
        .container {
            max-width: 600px;
            margin-top: 5%;
            padding: 2rem;
            background-color: #fff;
            border-radius: 8px;
            box-shadow: 0 4px 10px rgba(0, 0, 0, 0.1);
        }
        .form-header {
            text-align: center;
            margin-bottom: 1.5rem;
        }
        .form-header h2 {
            color: #343a40;
            font-weight: bold;
            font-size: 24px;
        }
        .form-control {
            border-radius: 5px;
        }
        .btn-primary {
            background-color: #007bff;
            border-color: #007bff;
            border-radius: 5px;
            padding: 0.75rem;
        }
        .btn-primary:hover {
            background-color: purple;
            border-color:purple;
        }
        .login-redirect {
            text-align: center;
            margin-top: 1rem;
        }
        .login-redirect a {
            color: #007bff;
            text-decoration: none;
        }
        .login-redirect a:hover {
            text-decoration: underline;
        }
        .alert {
            margin-top: 1rem;
        }
    </style>
</head>
<body>

<div class="container">
    <div class="form-header">
        <h2>Create Your Account</h2>
        <p class="text-muted">Fill in the form below to create a new user account.</p>
    </div>

    <!-- Sign-up form -->
    <form action="${pageContext.request.contextPath}/user" method="post" id="signupForm">
        <input type="hidden" name="action" value="signup">

        <div class="form-row">
            <div class="form-group col-md-6">
                <label for="firstName">First Name</label>
                <input type="text" class="form-control" id="firstName" name="firstName" placeholder="First Name" required maxlength="50">
            </div>
            <div class="form-group col-md-6">
                <label for="lastName">Last Name</label>
                <input type="text" class="form-control" id="lastName" name="lastName" placeholder="Last Name" required maxlength="50">
            </div>
        </div>

        <div class="form-row">
            <div class="form-group col-md-6">
                <label for="gender">Gender</label>
                <select id="gender" name="gender" class="form-control" required>
                    <option value="" disabled selected>Choose...</option>
                    <option value="MALE">Male</option>
                    <option value="FEMALE">Female</option>
                </select>
            </div>
            <div class="form-group col-md-6">
                <label for="phoneNumber">Phone Number</label>
                <input type="tel" class="form-control" id="phoneNumber" name="phoneNumber" placeholder="Phone Number" pattern="[0-9]+" required maxlength="15">
            </div>
        </div>

        <div class="form-group">
            <label for="villageId">Location ID</label>
            <input type="text" class="form-control" id="villageId" name="villageId" placeholder="Enter Location UUID " required pattern="[a-fA-F0-9\\-]{36}">
        </div>

        <div class="form-group">
            <label for="userName">Username</label>
            <input type="text" class="form-control" id="userName" name="userName" placeholder="Username" required maxlength="30">
        </div>

        <div class="form-group">
            <label for="password">Password</label>
            <input type="password" class="form-control" id="password" name="password" placeholder="Password" required>
        </div>

        <div class="form-group">
            <label for="role">Role</label>
            <select id="role" name="role" class="form-control" required>
                <option value="" disabled selected>Select Role</option>
                <option value="STUDENT">Student</option>
                <option value="TEACHER">Teacher</option>
                <option value="LIBRARIAN">Librarian</option>
                <option value="HOD">Head of Department</option>
                <option value="DEAN">Dean</option>
                <option value="REGISTER">Register</option>
                <option value="MANAGER">Manager</option>
            </select>
        </div>

        <button type="submit" class="btn btn-primary btn-block">Sign Up</button>
    </form>

    <div class="login-redirect">
        <p>Already have an account? <a href="${pageContext.request.contextPath}/signin.jsp">Sign in here</a></p>
    </div>

    <%-- <!-- Success/Error message display -->
    <%
        String message = request.getParameter("message");
        String error = request.getParameter("error");
        if (message != null) {
    %>
        <div class="alert alert-success text-center"><%= message %></div>
    <%
        } else if (error != null) {
    %>
        <div class="alert alert-danger text-center"><%= error %></div>
    <%
        }
    %>
</div> --%>

<!-- Bootstrap JS, jQuery, and custom JavaScript for validation -->
<script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@4.5.2/dist/js/bootstrap.bundle.min.js"></script>
<script>
    document.addEventListener('DOMContentLoaded', function () {
        const signupForm = document.getElementById('signupForm');
        const passwordField = document.getElementById('password');
        const phoneField = document.getElementById('phoneNumber');

        signupForm.addEventListener('submit', function (event) {
            // Validate password length
            if (passwordField.value.length < 6) {
                event.preventDefault();
                alert('Password must be at least 6 characters long.');
                return;
            }

            // Validate phone number format (example: only digits, min 10)
            const phoneRegex = /^[0-9]{10,}$/;
            if (!phoneRegex.test(phoneField.value)) {
                event.preventDefault();
                alert('Please enter a valid phone number with at least 10 digits.');
            }
        });
    });
</script>

</body>
</html>
