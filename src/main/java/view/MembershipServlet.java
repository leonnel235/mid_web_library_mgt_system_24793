package view;

import java.io.IOException;
import java.text.ParseException;
import java.text.SimpleDateFormat;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import controller.MembershipDAO;
import model.Membership;
import model.MembershipType;
import model.Status;
import model.User;

import java.util.UUID;

@WebServlet("/MembershipServlet")
public class MembershipServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;
    private MembershipDAO membershipDao = new MembershipDAO(); // Use the DAO to interact with the database
    private SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd"); // Date format for parsing

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String action = req.getParameter("action");

        if ("approveMembership".equals(action)) {
            approveMembership(req, resp);
        } else if ("registerMembership".equals(action)) {
            registerMembership(req, resp);
        } else {
            resp.sendError(HttpServletResponse.SC_BAD_REQUEST, "Invalid action");
        }
    }

    private void approveMembership(HttpServletRequest req, HttpServletResponse resp) throws IOException {
        String membershipIdStr = req.getParameter("membershipId");

        if (membershipIdStr == null) {
            resp.sendError(HttpServletResponse.SC_BAD_REQUEST, "Membership ID is missing");
            return;
        }

        UUID membershipId;
        try {
            membershipId = UUID.fromString(membershipIdStr); // Parse as UUID
        } catch (IllegalArgumentException e) {
            resp.sendError(HttpServletResponse.SC_BAD_REQUEST, "Invalid Membership ID format");
            return;
        }

        // Fetch the membership based on the ID and approve it
        Membership membership = membershipDao.getMembershipById(membershipId);
        if (membership != null) {
            membership.setMembershipStatus(Status.APPROVED);
            membershipDao.updateMembership(membership); // Assuming you have this method to update the membership
            resp.getWriter().write("Membership approved successfully");
        } else {
            resp.sendError(HttpServletResponse.SC_NOT_FOUND, "Membership not found");
        }
    }

    private void registerMembership(HttpServletRequest req, HttpServletResponse resp) throws IOException {
        String membershipTypeIdStr = req.getParameter("membershipTypeId");
        User loggedInUser = (User) req.getSession().getAttribute("loggedInUser"); // Ensure the user is logged in

        // Validate membership type ID and user session
        if (membershipTypeIdStr == null || loggedInUser == null) {
            resp.sendError(HttpServletResponse.SC_BAD_REQUEST, "Membership Type ID or user session is missing");
            return;
        }

        UUID membershipTypeId;
        try {
            membershipTypeId = UUID.fromString(membershipTypeIdStr); // Parse as UUID
        } catch (IllegalArgumentException e) {
            resp.sendError(HttpServletResponse.SC_BAD_REQUEST, "Invalid Membership Type ID format");
            return;
        }

        // Fetch the MembershipType based on UUID
        MembershipType membershipType = membershipDao.getMembershipTypeById(membershipTypeId);
        if (membershipType == null) {
            resp.sendError(HttpServletResponse.SC_NOT_FOUND, "Membership Type not found");
            return;
        }

        // Create a new Membership
        Membership membership = new Membership();
        membership.setMembershipType(membershipType);
        membership.setReader(loggedInUser); // Link the logged-in user
        membership.setMembershipCode(req.getParameter("membershipCode")); // Use user-inputted membership code

        // Retrieve and log registration and expiration dates
        String registrationDateStr = req.getParameter("registrationDate");
        String expiringDateStr = req.getParameter("expiringDate");

        // Log the received parameters for debugging
        System.out.println("Registration Date: " + registrationDateStr);
        System.out.println("Expiring Date: " + expiringDateStr);

        // Check for null parameters before parsing
        if (registrationDateStr == null || expiringDateStr == null) {
            resp.sendError(HttpServletResponse.SC_BAD_REQUEST, "Date parameters are missing.");
            return;
        }

        // Parse registration and expiration dates
        try {
            membership.setRegistrationDate(dateFormat.parse(registrationDateStr)); // Parse registration date
            membership.setExpiringDate(dateFormat.parse(expiringDateStr)); // Parse expiration date
        } catch (ParseException e) {
            resp.sendError(HttpServletResponse.SC_BAD_REQUEST, "Invalid date format. Please use yyyy-MM-dd.");
            return;
        }

        // Set membership status
        String membershipStatusStr = req.getParameter("membershipStatus");
        if (membershipStatusStr != null) {
            try {
                membership.setMembershipStatus(Status.valueOf(membershipStatusStr)); // Convert to enum
            } catch (IllegalArgumentException e) {
                resp.sendError(HttpServletResponse.SC_BAD_REQUEST, "Invalid membership status.");
                return;
            }
        } else {
            membership.setMembershipStatus(Status.APPROVED); // Default status
        }

        // Save membership using the MembershipDAO instance method
        membershipDao.createMembership(membership);
        resp.setStatus(HttpServletResponse.SC_OK);
    }
}
