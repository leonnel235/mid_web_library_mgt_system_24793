<%@ page import="java.util.List" %>
<%@ page import="model.MembershipType" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Manage Membership Types</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f4f4f4;
            margin: 0;
        }

        h1, h2 {
            color: #333;
            text-align: center;
        }

        .container {
            width: 80%;
            margin: 20px auto;
            padding: 20px;
            background-color: #fff;
            border-radius: 8px;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
        }

        .form-container, .table-container {
            margin: 20px 0;
        }

        input[type="text"], input[type="number"], select, button {
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
            background-color: purple;
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
            background-color: blue;
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

        .action-btn.edit { background-color: #5bc0de; }
        .action-btn.delete { background-color: #d9534f; }
    </style>
</head>
<body>

    <div class="container">
  
        <!-- Create Membership Type Form -->
        <div class="form-container">
            <h2>Create Membership Type</h2>
            <form action="MembershipTypeServlet" method="POST">
                <input type="hidden" name="action" value="createMembershipType">

                <!-- Membership Type Dropdown -->
                <div class="form-group">
                    <label for="membershipType">Membership Type:</label>
                    <select id="membershipType" name="membershipName" required>
                        <option value="">Select Membership</option>
                        <option value="Gold">Gold - 50 Rwf/day, 5 books max</option>
                        <option value="Silver">Silver - 30 Rwf/day, 3 books max</option>
                        <option value="Striver">Striver - 10 Rwf/day, 2 books max</option>
                    </select>
                </div>

                <!-- Max Books Input -->
                <input type="number" name="maxBooks" placeholder="Maximum Books" required min="1">

                <!-- Price Input -->
                <input type="number" name="price" placeholder="Price (in Rwf)" required min="0">

                <!-- Submit Button -->
                <button type="submit">Create Membership Type</button>
            </form>
        </div>

        <!-- Membership Types Table -->
        <div class="table-container">
            <h2>Existing Membership Types</h2>
            <table>
                <thead>
                    <tr>
                        <th>Membership Name</th>
                        <th>Max Books</th>
                        <th>Price</th>
                        <th>Actions</th>
                    </tr>
                </thead>
                <tbody>
                    <% 
                        List<MembershipType> membershipTypes = (List<MembershipType>) request.getAttribute("membershipTypes");
                        if (membershipTypes != null && !membershipTypes.isEmpty()) {
                            for (MembershipType membership : membershipTypes) {
                    %>
                        <tr>
                            <td><%= membership.getMembershipName() %></td>
                            <td><%= membership.getMaxBooks() %></td>
                            <td><%= membership.getPrice() %> Rwf</td>
                            <td>
                                <button class="action-btn edit" onclick="editMembershipType(<%= membership.getId() %>)">Edit</button>
                                <button class="action-btn delete" onclick="deleteMembershipType(<%= membership.getId() %>)">Delete</button>
                            </td>
                        </tr>
                    <% 
                            }
                        } else {
                    %>
                        <tr>
                            <td colspan="4">No membership types found.</td>
                        </tr>
                    <% 
                        }
                    %>
                </tbody>
            </table>
        </div>
    </div>

    <script>
        // Placeholder function to edit a membership type
        function editMembershipType(id) {
            alert("Edit Membership Type with ID: " + id);
            // You can implement an actual edit functionality here.
        }

        // Placeholder function to delete a membership type
        function deleteMembershipType(id) {
            if (confirm("Are you sure you want to delete this membership type?")) {
                // You can send a DELETE request to the server to delete the membership type.
                alert("Deleted Membership Type with ID: " + id);
            }
        }
    </script>

</body>
</html>
