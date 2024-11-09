<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Sign In</title>
    <!-- Bootstrap CSS -->
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/signin.css">

    <style>
        /* Custom styles for a professional sign-in page with background image */
        body {
            font-family: Arial, sans-serif;
            background: url('images/library.jpg') no-repeat center center fixed;
            background-size: cover;
            display: flex;
            justify-content: center;
            align-items: center;
            height: 100vh;
            margin: 0;
            position: relative;
            color: #fff;
        }
        
        /* Overlay to darken the background image for better contrast */
        body::before {
            content: "";
            position: absolute;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            background-color: rgba(0, 0, 0, 0.5);
            z-index: 1;
        }
        
        .container {
            position: relative;
            z-index: 2;
            max-width: 400px;
            padding: 2rem;
            background-color: #fff;
            border-radius: 8px;
            box-shadow: 0 4px 10px rgba(0, 0, 0, 0.2);
            color: #333;
        }
        
        .form-container h2 {
            text-align: center;
            color: #343a40;
            font-weight: bold;
            margin-bottom: 1.5rem;
        }
        
        .form-control {
            border-radius: 5px;
        }
        
        .btn-primary {
            background-color: #007bff;
            border-color: #007bff;
            border-radius: 5px;
            padding: 0.75rem;
            width: 100%;
        }
        
        .btn-primary:hover {
            background-color: purple;
            border-color: #0062cc;
        }
        
        .form-container p {
            text-align: center;
        }
        
        .success {
            color: green;
            text-align: center;
            margin-top: 1rem;
        }
        
        .error {
            color: red;
            text-align: center;
            margin-top: 1rem;
        }
    </style>
</head>
<body>
    <div class="container">
        <div class="form-container">
            <h2>Sign In</h2>
            <form action="${pageContext.request.contextPath}/user" method="post">
                <input type="hidden" name="action" value="login">
                
                <div class="form-group">
                    <input type="text" name="userName" class="form-control" placeholder="Username" required>
                </div>
                <div class="form-group">
                    <input type="password" name="password" class="form-control" placeholder="Password" required>
                </div>
                
                <button type="submit" class="btn btn-primary">Sign In</button>
            </form>

            <p class="mt-3">Don't have an account? <a href="${pageContext.request.contextPath}/signup.jsp">Sign up here</a></p>

        <%--     <!-- Success/Error message display -->
            <% 
                String message = request.getParameter("message");
                String error = request.getParameter("error");
                if (message != null) { %>
                    <p class="success"><%= message %></p>
            <% } else if (error != null) { %>
                    <p class="error"><%= error %></p>
            <% } %>
        </div>
    </div> --%>

    <!-- Bootstrap JS, jQuery -->
    <script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@4.5.2/dist/js/bootstrap.bundle.min.js"></script>
    <%-- <script src="${pageContext.request.contextPath}/signin.js" defer></script> --%>
</body>
</html>
