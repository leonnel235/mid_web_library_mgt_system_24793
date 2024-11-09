<%@ page import="model.Membership" %>
<%@ page import="model.MembershipType" %>
<%@ page import="model.Status" %>
<%@ page import="model.User" %>
<%@ page import="controller.UserDao" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Membership Management</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f4f4f4;
            margin: 0;
        }

        .container {
            width: 70%;
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

        .form-container, .table-container {
            margin: 20px 0;
        }

        input[type="text"], input[type="number"], select, input[type="date"], button {
            width: 100%;
            padding: 10px;
            margin: 10px 0;
            border-radius: 4px;
            border: 1px solid #ccc;
        }

        button {
            background-color: #5cb85c;
            color: #fff;
            font-size: 16px;
            cursor: pointer;
            border: none;
        }

        button:hover {
            background-color: #4cae4c;
        }

        table {
            width: 100%;
            border-collapse: collapse;
            margin-top: 20px;
        }

        table, th, td {
            border: 1px solid #ddd;
        }

        th, td {
            padding: 10px;
            text-align: center;
        }

        th {
            background-color: #333;
            color: #fff;
        }

        .action-btn {
            padding: 5px 10px;
            margin: 0 2px;
            border: none;
            color: #fff;
            cursor: pointer;
            border-radius: 4px;
        }

        .action-btn.approve { background-color: #5bc0de; }
        .action-btn.delete { background-color: #d9534f; }

        .result {
            margin-top: 20px;
            padding: 10px;
            background-color: #dff0d8;
            border: 1px solid #3c763d;
            color: #3c763d;
            text-align: center;
        }

        .error {
            margin-top: 20px;
            padding: 10px;
            background-color: #f2dede;
            border: 1px solid #ebccd1;
            color: #a94442;
            text-align: center;
        }
    </style>
</head>
<body>

    <div class="container">
        <h1>Manage Memberships</h1>

        <!-- Membership Registration Form -->
        <div class="form-container">
            <h2>Register Membership</h2>
            <form action="MembershipServlet" method="POST">
                <input type="hidden" name="action" value="registerMembership">

                <label for="membershipTypeId">Select Membership Type:</label>
                <select id="membershipTypeId" name="membershipTypeId" required>
                    <option value="">Select Type</option>
                    <!-- Populate with dynamic data -->
                    <option value="1">Gold - 50 Rwf/day, 5 books max</option>
                    <option value="2">Silver - 30 Rwf/day, 3 books max</option>
                    <option value="3">Striver - 10 Rwf/day, 2 books max</option>
                </select>

                <label for="membershipCode">Membership Code:</label>
                <input type="text" id="membershipCode" name="membershipCode" required>

                <label for="registrationDate">Registration Date:</label>
                <input type="date" id="registrationDate" name="registrationDate" required>

                <label for="expiringDate">Expiring Date:</label>
                <input type="date" id="expiringDate" name="expiringDate" required>

                <label for="membershipStatus">Membership Status:</label>
                <select id="membershipStatus" name="membershipStatus">
                    <option value="APPROVED">Approved</option>
                    <option value="PENDING">Pending</option>
                    <option value="SUSPENDED">Suspended</option>
                </select>

                <button type="submit">Register Membership</button>
            </form>
        </div>

        <!-- Membership Approval Table -->
        <div class="table-container">
            <h2>Memberships Pending Approval</h2>
            <table>
                <thead>
                    <tr>
                        <th>Membership Code</th>
                        <th>Reader Name</th>
                        <th>Type</th>
                        <th>Registration Date</th>
                        <th>Status</th>
                        <th>Actions</th>
                    </tr>
                </thead>
                <tbody>
                    <!-- Example of a dynamically populated row -->
                    <tr>
                        <td>12345</td>
                        <td>John Doe</td>
                        <td>Gold</td>
                        <td>2024-11-07</td>
                        <td>Pending</td>
                        <td>
                            <button class="action-btn approve" onclick="approveMembership('12345')">Approve</button>
                            <button class="action-btn delete" onclick="deleteMembership('12345')">Delete</button>
                        </td>
                    </tr>
                    <!-- Additional rows can be populated dynamically from the backend -->
                </tbody>
            </table>
        </div>

        <!-- Result and Error Messages -->
        <div id="resultContainer"></div>
    </div>

    <script>
        // Function to handle membership approval
        function approveMembership(membershipCode) {
            var xhr = new XMLHttpRequest();
            xhr.open('POST', 'MembershipServlet', true);
            xhr.setRequestHeader('Content-Type', 'application/x-www-form-urlencoded');
            xhr.onreadystatechange = function() {
                if (xhr.readyState === 4 && xhr.status === 200) {
                    var resultContainer = document.getElementById('resultContainer');
                    resultContainer.innerHTML = '<div class="result">' + xhr.responseText + '</div>';
                } else if (xhr.readyState === 4 && xhr.status !== 200) {
                    var resultContainer = document.getElementById('resultContainer');
                    resultContainer.innerHTML = '<div class="error">Error: Unable to approve membership</div>';
                }
            };
            xhr.send('action=approveMembership&membershipId=' + encodeURIComponent(membershipCode));
        }

        // Function to handle membership deletion (simulated)
        function deleteMembership(membershipCode) {
            if (confirm("Are you sure you want to delete this membership?")) {
                // Simulate membership deletion (you can implement actual logic in the servlet)
                alert('Membership ' + membershipCode + ' deleted.');
            }
        }
    </script>

</body>
</html>
