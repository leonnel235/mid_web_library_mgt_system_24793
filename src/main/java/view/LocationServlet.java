package view;

import controller.UserDao;
import model.Location;
import model.LocationType;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;
import java.util.UUID;

@WebServlet("/createLocation")
public class LocationServlet extends HttpServlet {

    private final UserDao userDao = new UserDao();  // DAO instance

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        // Forward to createLocation.jsp for the GET request
        req.getRequestDispatcher("/createLocation.jsp").forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String locationCode = req.getParameter("locationCode");
        String locationName = req.getParameter("locationName");
        String locationTypeStr = req.getParameter("locationType");
        String parentIdStr = req.getParameter("parentId");

        // Validate input fields
        if (locationCode == null || locationName == null || locationTypeStr == null) {
            forwardWithError(req, resp, "All fields are required.");
            return;
        }

        try {
            // Convert location type
            LocationType locationType = LocationType.valueOf(locationTypeStr.toUpperCase());

            Location parentLocation = null;

            // Handle parent location logic for non-Province types
            if (locationType != LocationType.PROVINCE) {
                if (parentIdStr != null && !parentIdStr.trim().isEmpty()) {
                    if (isValidUUID(parentIdStr)) {
                        parentLocation = userDao.getLocationById(UUID.fromString(parentIdStr));
                        if (parentLocation == null) {
                            forwardWithError(req, resp, "Parent location not found.");
                            return;
                        }
                    } else {
                        forwardWithError(req, resp, "Invalid UUID format for parent location.");
                        return;
                    }
                } else {
                    forwardWithError(req, resp, "Parent location is required for this type.");
                    return;
                }
            }

            // Create the Location entity
            Location location = new Location(locationCode, locationName, locationType, parentLocation);

            // Persist the location
            userDao.createLocation(location);

            // Redirect to success page
            resp.sendRedirect("createLocation.jsp?message=Location created successfully.");

        } catch (IllegalArgumentException e) {
            e.printStackTrace();
            forwardWithError(req, resp, "Invalid location type: " + locationTypeStr);
        } catch (Exception e) {
            e.printStackTrace();
            forwardWithError(req, resp, "Failed to create location.");
        }
    }

    // Helper method to validate UUID format
    private boolean isValidUUID(String uuid) {
        try {
            UUID.fromString(uuid);
            return true;
        } catch (IllegalArgumentException e) {
            return false;
        }
    }

    // Helper method to forward requests with error messages
    private void forwardWithError(HttpServletRequest req, HttpServletResponse resp, String error) throws ServletException, IOException {
        req.setAttribute("error", error);
        req.getRequestDispatcher("/createLocation.jsp").forward(req, resp);
    }
}
