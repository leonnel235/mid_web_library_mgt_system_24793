<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Create Location</title>
    
    <!-- Bootstrap CSS -->
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">

    <style>
        /* Custom styles for create location form */
        body {
            font-family: Arial, sans-serif;
            background-color: #f4f4f4;
            display: flex;
            justify-content: center;
            align-items: center;
            height: 100vh;
            margin: 0;
        }

        h2 {
            text-align: center;
            color: #333;
        }

        .container {
            max-width: 500px;
            padding: 20px;
            background-color: #fff;
            border-radius: 8px;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
        }

        .form-group {
            margin-bottom: 1rem;
        }

        .btn-primary {
            background-color: #007bff;
            border: none;
            padding: 10px 20px;
            width: 100%;
            border-radius: 4px;
            font-weight: bold;
        }

        .btn-primary:hover {
            background-color: #0069d9;
        }

        .login-redirect p {
            text-align: center;
            margin-top: 1rem;
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
        <h2>Create Location</h2>

        <div id="feedbackMessage" style="display: none;"></div>

        <form action="${pageContext.request.contextPath}/createLocation" method="post" id="locationForm">
            <div class="form-group">
                <label for="locationCode">Location Code:</label>
                <input type="text" id="locationCode" name="locationCode" class="form-control" required>
            </div>

            <div class="form-group">
                <label for="locationName">Location Name:</label>
                <input type="text" id="locationName" name="locationName" class="form-control" required>
            </div>

            <div class="form-group">
                <label for="locationType">Location Type:</label>
                <select id="locationType" name="locationType" class="form-control" required>
                    <option value="PROVINCE">Province</option>
                    <option value="DISTRICT">District</option>
                    <option value="SECTOR">Sector</option>
                    <option value="CELL">Cell</option>
                    <option value="VILLAGE">Village</option>
                </select>
            </div>

            <div class="form-group" id="parentLocationSection" style="display: none;">
                <label for="parentId">Parent Location ID:</label>
                <input type="text" id="parentId" name="parentId" placeholder="Enter parent ID (UUID)" class="form-control">
            </div>

            <button type="submit" class="btn btn-primary">Create Location</button>

            <div class="login-redirect">
                <p>Already have a Location? <a href="${pageContext.request.contextPath}/signup.jsp">Sign Up here</a></p>
            </div>
        </form>
    </div>

    <!-- Inline JavaScript for handling form interactivity -->
    <script>
        document.addEventListener('DOMContentLoaded', function () {
            const locationTypeSelect = document.getElementById('locationType');
            const parentSection = document.getElementById('parentLocationSection');
            const parentIdInput = document.getElementById('parentId');
            const feedbackMessage = document.getElementById('feedbackMessage');

            // Show or hide parent location section based on location type
            locationTypeSelect.addEventListener('change', function () {
                parentSection.style.display = this.value === 'PROVINCE' ? 'none' : 'block';
                if (this.value === 'PROVINCE') parentIdInput.value = '';
            });

            locationTypeSelect.dispatchEvent(new Event('change'));

            // Display feedback message from query parameters
            const urlParams = new URLSearchParams(window.location.search);
            const message = urlParams.get('message');
            const error = urlParams.get('error');

            if (message) {
                feedbackMessage.textContent = message;
                feedbackMessage.style.color = 'green';
                feedbackMessage.style.display = 'block';
                setTimeout(() => window.location.href = '${pageContext.request.contextPath}/signup.jsp', 2000);
            } else if (error) {
                feedbackMessage.textContent = error;
                feedbackMessage.style.color = 'red';
                feedbackMessage.style.display = 'block';
            }
        });
    </script>

    <!-- Bootstrap JS (for potential future interactions) -->
    <script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@4.5.2/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
