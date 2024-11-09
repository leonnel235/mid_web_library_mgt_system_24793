package view;

import controller.UserDao;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;

@WebServlet("/InitServlet")
public class InitServlet extends HttpServlet {
    private UserDao userDao = new UserDao();

    @Override
    public void init() throws ServletException {
        super.init();
        userDao.initializeMembershipTypes(); // Call to initialize membership types
    }
}
