package view;

import controller.UserDao;
import model.MembershipType;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;

@WebServlet("/MembershipTypeServlet")
public class MembershipTypeServlet extends HttpServlet {
    private UserDao userDao = new UserDao();

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String action = req.getParameter("action");

        if ("createMembershipType".equals(action)) {
            createMembershipType(req, resp);
        } else {
            resp.sendError(HttpServletResponse.SC_BAD_REQUEST, "Invalid action");
        }
    }

    private void createMembershipType(HttpServletRequest req, HttpServletResponse resp) throws IOException {
        String membershipName = req.getParameter("membershipName");
        int maxBooks = Integer.parseInt(req.getParameter("maxBooks"));
        int price = Integer.parseInt(req.getParameter("price"));

        MembershipType membershipType = new MembershipType(membershipName, maxBooks, price);
        userDao.createMembershipType(membershipType);

        resp.getWriter().write("Membership type created successfully");
    }


    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        // Fetch all membership types from the database
        List<MembershipType> membershipTypes = userDao.getAllMembershipTypes();

        // Set the membership types list as a request attribute
        req.setAttribute("membershipTypes", membershipTypes);

        // Forward the request to the JSP page
        req.getRequestDispatcher("/displayMembershipTypes.jsp").forward(req, resp);
    }
}
