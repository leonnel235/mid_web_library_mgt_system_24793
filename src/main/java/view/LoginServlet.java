package view;

import controller.UserDao;
import model.User;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;

@WebServlet("/login")
public class LoginServlet extends HttpServlet {

	private static final long serialVersionUID = 1L;
	private UserDao userDao = new UserDao();

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String username = req.getParameter("userName");
        String password = req.getParameter("password");

        User user = userDao.getUserByUsername(username);
        if (user != null && userDao.hashPassword(password).equals(user.getPassword())) {
            HttpSession session = req.getSession();
            session.setAttribute("user", user);
            resp.sendRedirect("home.jsp");
        } else {
            resp.sendRedirect("signin.jsp?error=Invalid credentials");
        }
    }
}
