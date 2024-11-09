package filter;

import javax.servlet.*;
import javax.servlet.annotation.WebFilter;
import javax.servlet.http.*;
import java.io.IOException;
import model.User;
import model.Role;

@WebFilter("/*")  // Intercepts all requests
public class AuthFilter implements Filter {

    @Override
    public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain)
            throws IOException, ServletException {

        HttpServletRequest req = (HttpServletRequest) request;
        HttpServletResponse resp = (HttpServletResponse) response;

        String appContext = req.getContextPath();
        String path = req.getRequestURI().substring(appContext.length());

        System.out.println("Adjusted Path: " + path);

        // Allow access to public pages and static resources
        if (isPublicPage(path) || isSignupRequest(req) || isLocationCreationRequest(path)) {
            chain.doFilter(request, response);  // Allow access
            return;
        }

        HttpSession session = req.getSession(false);
        boolean isLoggedIn = (session != null && session.getAttribute("loggedInUser") != null);

        if (!isLoggedIn) {
            System.out.println("No session found or user not logged in. Redirecting to signin.");
            resp.sendRedirect(req.getContextPath() + "/signin.jsp?error=Please log in.");
            return;
        }

        // Role-based access control
        User user = (User) session.getAttribute("loggedInUser");
        Role role = user.getRole();

        if ((path.contains("manageBooks") && role != Role.LIBRARIAN) || 
            (path.contains("approveMembers") && role != Role.LIBRARIAN) || 
            (path.contains("borrowBook") && (role == Role.HOD || role == Role.DEAN || role == Role.REGISTER || role == Role.MANAGER)) ||
            (path.contains("viewReports") && (role != Role.HOD && role != Role.DEAN && role != Role.REGISTER && role != Role.MANAGER && role != Role.LIBRARIAN))) {
            
            System.out.println("Unauthorized access attempt by " + role + ". Redirecting to unauthorized page.");
            resp.sendRedirect(req.getContextPath() + "/unauthorized.jsp");
            return;
        }

        chain.doFilter(request, response);
    }

    // Method to allow access to specific public pages and static resources
    private boolean isPublicPage(String path) {
        return path.equals("/") || 
               path.equals("/signin.jsp") || 
               path.equals("/signup.jsp") || 
               path.equals("/createLocation.jsp") || 
               path.equals("/assignRoom.css") ||        // Specific CSS file
               path.equals("/assignRoom.js") ||         // Specific JS file
               path.equals("/assignShelf.css") ||		// Specific CSS file
               path.equals("/assignShelf.js") ||		// Specific JS file
               path.equals("/approveMembers.css") ||	// Specific CSS file
               path.equals("/approveMembers.js") ||		// Specific JS file
               path.endsWith(".css") ||                 // Allow all .css files
               path.endsWith(".js") ||                  // Allow all .js files
               path.endsWith(".png") ||                 // Allow .png images
               path.endsWith(".jpg");                   // Allow .jpg images
    }

    // Check if the request is for signup
    private boolean isSignupRequest(HttpServletRequest req) {
        String action = req.getParameter("action");
        return "signup".equalsIgnoreCase(action) || "createUser".equalsIgnoreCase(action);
    }

    // Check if the request is for location creation
    private boolean isLocationCreationRequest(String path) {
        return path.endsWith("createLocation.jsp") || path.endsWith("/createLocation");
    }
}
