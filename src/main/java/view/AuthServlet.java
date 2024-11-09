package view;

import controller.UserDao;
import model.User;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;

@WebServlet("/auth")
public class AuthServlet extends HttpServlet {

	private static final long serialVersionUID = 1L;
	private UserDao userDao = new UserDao();

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws IOException {
        String username = req.getParameter("username");
        String password = req.getParameter("password");

        User user = userDao.getUserByUsername(username);

        if (user != null && userDao.hashPassword(password).equals(user.getPassword())) {
            HttpSession session = req.getSession();
            session.setAttribute("user", user);
            session.setAttribute("role", user.getRole().toString());

            resp.sendRedirect("home.jsp");
        } else {
            resp.sendRedirect("signin.jsp?error=Invalid credentials.");
        }
    }

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws IOException {
        HttpSession session = req.getSession(false);
        if (session != null) {
            session.invalidate();
        }
        resp.sendRedirect("signin.jsp?message=You have been logged out.");
    }
}
