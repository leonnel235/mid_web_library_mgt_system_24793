<%@ page contentType="text/html;charset=UTF-8"%>
<%@ page import="java.util.List"%>
<%@ page import="model.MembershipType"%>
<%@ page import="controller.UserDao"%>
<%
UserDao userDao = new UserDao();
List<MembershipType> membershipTypes = userDao.getAllMembershipTypes();

// Debugging: Output the number of membership types retrieved
System.out.println("Membership Types Retrieved: " + membershipTypes.size());
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Register for Membership</title>
    <link rel="stylesheet" href="registerMembership.css">
    <script src="registerMembership.js" defer></script> <!-- Link to JavaScript -->
</head>
<body>
    <nav class="navbar">
        <a href="home.jsp" class="back-link">Back to Home</a>
    </nav>

    <div class="container">
        <h2>Register for Library Membership</h2>
        <form id="registerForm">
            <input type="hidden" name="action" value="registerMembership">
            <div class="form-group">
                <label for="membershipCode">Membership Code:</label>
                <input type="text" id="membershipCode" name="membershipCode" required>
            </div>
            <div class="form-group">
                <label for="membershipType">Select Membership Type:</label>
                <select id="membershipType" name="membershipTypeId" required>
                    <option value="">Choose Membership Type</option>
                    <%
                    for (MembershipType type : membershipTypes) {
                    %>
                    <option value="<%=type.getId()%>"><%=type.getMembershipName()%> - $<%=type.getPrice()%></option>
                    <%
                    }
                    %>
                </select>
            </div>
            <div class="form-group">
                <label for="registrationDate">Registration Date:</label>
                <input type="date" id="registrationDate" name="registrationDate" required>
            </div>
            <div class="form-group">
                <label for="expiringDate">Expiring Date:</label>
                <input type="date" id="expiringDate" name="expiringDate" required>
            </div>
            <div class="form-group">
                <label for="membershipStatus">Membership Status:</label>
                <select id="membershipStatus" name="membershipStatus">
                    <option value="APPROVED">Approved</option>
                    <option value="PENDING">Pending</option>
                    <option value="REJECTED">Rejected</option>
                </select>
            </div>
            <button type="submit" class="btn-submit">Register</button>
        </form>

        <p id="message"></p>
    </div>
</body>
</html>
