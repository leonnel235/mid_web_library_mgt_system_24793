package view;

import controller.UserDao;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet("/GetProvinceServlet")
public class GetProvinceServlet extends HttpServlet {

	private static final long serialVersionUID = 1L;
	private UserDao userDao = new UserDao();

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String phoneNumber = request.getParameter("phoneNumber"); // Get the phone number from the request
        String provinceName = userDao.getProvinceByPhoneNumber(phoneNumber); // Fetch province by phone number

        if (provinceName != null) {
            response.getWriter().write(provinceName); // Return the province name
        } else {
            response.getWriter().write("Province not found"); // Return an error message if not found
        }
    }
}
