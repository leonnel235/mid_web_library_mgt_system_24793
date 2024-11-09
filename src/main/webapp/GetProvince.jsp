<%@ page import="java.io.IOException" %>
<%@ page import="javax.servlet.ServletException" %>
<%@ page import="javax.servlet.http.HttpServletRequest" %>
<%@ page import="javax.servlet.http.HttpServletResponse" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Get Province by Phone Number</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f4f4f4;
            margin: 0;
        }

        .container {
            width: 50%;
            margin: 20px auto;
            padding: 20px;
            background-color: #fff;
            border-radius: 8px;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
        }

        h1 {
            text-align: center;
            color: #333;
        }

        label, input[type="text"], button {
            width: 100%;
            padding: 10px;
            margin: 10px 0;
            border-radius: 4px;
            border: 1px solid #ccc;
        }

        button {
            background-color: blue;
            color: #fff;
            font-size: 16px;
            cursor: pointer;
            border: none;
        }

        button:hover {
            background-color:purple;
        }

        .result {
            padding: 10px;
            margin-top: 20px;
            border-radius: 4px;
            background-color: #dff0d8;
            border: 1px solid #3c763d;
            color: #3c763d;
            text-align: center;
        }

        .error {
            padding: 10px;
            margin-top: 20px;
            border-radius: 4px;
            background-color: #f2dede;
            border: 1px solid #ebccd1;
            color: #a94442;
            text-align: center;
        }
    </style>
</head>
<body>

    <div class="container">
        <h1>Get Province by Phone Number</h1>

        <!-- Phone Number Form -->
        <form action="GetProvinceServlet" method="POST">
            <label for="phoneNumber">Enter Phone Number:</label>
            <input type="text" id="phoneNumber" name="phoneNumber" required placeholder="Phone Number">
            <button type="submit">Get Province</button>
        </form>

        <!-- Display the result -->
        <div id="resultContainer"></div>
    </div>

    <script>
        // Listen for the form submission
        document.querySelector('form').addEventListener('submit', function(event) {
            event.preventDefault();  // Prevent default form submission

            var phoneNumber = document.getElementById('phoneNumber').value; // Get the phone number from the input field

            // Send an AJAX request to the servlet
            var xhr = new XMLHttpRequest();
            xhr.open('POST', 'GetProvinceServlet', true);
            xhr.setRequestHeader('Content-Type', 'application/x-www-form-urlencoded');
            xhr.onreadystatechange = function() {
                if (xhr.readyState === 4 && xhr.status === 200) {
                    var response = xhr.responseText; // Get the response from the servlet
                    var resultContainer = document.getElementById('resultContainer');

                    // Display the result or error message
                    if (response === "Province not found") {
                        resultContainer.innerHTML = '<div class="error">' + response + '</div>';
                    } else {
                        resultContainer.innerHTML = '<div class="result">Province: ' + response + '</div>';
                    }
                }
            };
            xhr.send('phoneNumber=' + encodeURIComponent(phoneNumber)); // Send the phone number to the servlet
        });
    </script>

</body>
</html>
