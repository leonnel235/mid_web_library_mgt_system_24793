package view;

import controller.UserDao;
import model.*;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;
import java.util.ArrayList;
import java.util.UUID;

@WebServlet("/user")
public class UserServlet extends HttpServlet {
    private final UserDao userDao = new UserDao();

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String action = req.getParameter("action");
        System.out.println("Received action: " + action);

        switch (action.toLowerCase()) {
            case "signup":
                handleSignUp(req, resp);
                break;
            case "signin":
                handleSignIn(req, resp);
                break;
            case "createlocation":
                handleCreateLocation(req, resp);
                break;
            default:
                resp.sendRedirect("signin.jsp?error=Invalid action.");
        }
    }

    private void handleSignUp(HttpServletRequest req, HttpServletResponse resp) throws IOException {
        try {
            // Retrieve user details from the request
            String firstName = req.getParameter("firstName");
            String lastName = req.getParameter("lastName");
            String userName = req.getParameter("userName");
            String password = req.getParameter("password");
            String phoneNumber = req.getParameter("phoneNumber");
            Gender gender = Gender.valueOf(req.getParameter("gender").toUpperCase());
            Role role = Role.valueOf(req.getParameter("role").toUpperCase());
            UUID villageId = UUID.fromString(req.getParameter("villageId"));

            // Fetch the village location from the database
            Location village = userDao.getLocationById(villageId);
            if (village == null) {
                resp.sendRedirect("signup.jsp?error=Invalid village ID.");
                return;
            }

            // Hash the user's password
            String hashedPassword = userDao.hashPassword(password);

            // Generate a unique personId
            String personId = UUID.randomUUID().toString();

            // Create a new User object using the correct constructor
            User user = new User(
                personId,        // personId
                firstName,       // First name
                lastName,        // Last name
                gender,          // Gender
                phoneNumber,     // Phone number
                hashedPassword,  // Password
                role,            // Role
                userName,        // Username
                village,         // Village (Location)
                new ArrayList<>(),  // Empty Memberships list
                new ArrayList<>()   // Empty Borrowers list
            );

            // Persist the new user in the database
            userDao.createUser(user);

            // Create a new session for the user
            HttpSession newSession = req.getSession(true);
            newSession.setAttribute("loggedInUser", user);

            // Redirect to the home page with a success message
            resp.sendRedirect("home.jsp?message=User created successfully.");
        } catch (Exception e) {
            e.printStackTrace();
            resp.sendRedirect("signup.jsp?error=User creation failed: " + e.getMessage());
        }
    }

    private void handleSignIn(HttpServletRequest req, HttpServletResponse resp) throws IOException {
        try {
            String userName = req.getParameter("userName");
            String password = req.getParameter("password");

            System.out.println("Attempting to log in user: " + userName);
            User user = userDao.getUserByUsername(userName);

            if (user == null || !userDao.verifyPassword(password, user.getPassword())) {
                resp.sendRedirect("signin.jsp?error=Invalid username or password.");
                return;
            }

            HttpSession oldSession = req.getSession(false);
            if (oldSession != null) {
                oldSession.invalidate();
            }

            HttpSession newSession = req.getSession(true);
            newSession.setAttribute("loggedInUser", user);

            String redirectPath = (String) newSession.getAttribute("redirectAfterLogin");
            resp.sendRedirect(redirectPath != null ? redirectPath : "home.jsp?message=Login successful.");
        } catch (Exception e) {
            e.printStackTrace();
            resp.sendRedirect("signin.jsp?error=An error occurred during login: " + e.getMessage());
        }
    }

    private void handleCreateLocation(HttpServletRequest req, HttpServletResponse resp) throws IOException {
        try {
            String locationCode = req.getParameter("locationCode");
            String locationName = req.getParameter("locationName");
            LocationType locationType = LocationType.valueOf(req.getParameter("locationType").toUpperCase());
            String parentIdStr = req.getParameter("parentId");

            Location parentLocation = null;
            if (parentIdStr != null && !parentIdStr.isEmpty()) {
                UUID parentId = UUID.fromString(parentIdStr);
                parentLocation = userDao.getLocationById(parentId);
            }

            Location location = new Location(locationCode, locationName, locationType, parentLocation);
            System.out.println("Creating location: " + locationName);

            userDao.createLocation(location);

            resp.sendRedirect("locations.jsp?message=Location created successfully.");
        } catch (IllegalArgumentException e) {
            e.printStackTrace();
            resp.sendRedirect("createLocation.jsp?error=Invalid input: " + e.getMessage());
        } catch (Exception e) {
            e.printStackTrace();
            resp.sendRedirect("createLocation.jsp?error=Failed to create location: " + e.getMessage());
        }
    }
}
