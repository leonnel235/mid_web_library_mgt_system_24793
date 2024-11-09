package view;

import java.io.IOException;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;
import java.util.UUID;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import controller.UserDao;
import model.Borrower;
import model.Book;
import model.BookStatus;
import model.User;

@WebServlet("/BorrowerServlet")
public class BorrowerServlet extends HttpServlet {

    private UserDao userDao = new UserDao();
    private SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd"); // Define your date format

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String action = req.getParameter("action");

        if ("borrowBook".equals(action)) {
            borrowBook(req, resp);
        } else {
            resp.sendError(HttpServletResponse.SC_BAD_REQUEST, "Invalid action");
        }
    }

    private void borrowBook(HttpServletRequest req, HttpServletResponse resp) throws IOException {
        User loggedInUser = (User) req.getSession().getAttribute("loggedInUser");

        if (loggedInUser == null) {
            resp.sendError(HttpServletResponse.SC_UNAUTHORIZED, "User not logged in");
            return;
        }

        Long bookId = Long.parseLong(req.getParameter("bookId"));
        String dueDateStr = req.getParameter("dueDate"); // Get the due date as a string

        Date dueDate;
        try {
            dueDate = dateFormat.parse(dueDateStr); // Parse the string into a Date object
        } catch (ParseException e) {
            resp.sendError(HttpServletResponse.SC_BAD_REQUEST, "Invalid due date format. Please use yyyy-MM-dd.");
            return;
        }

        Book book = userDao.getBookById(bookId); // Fetch the book by ID
        if (book == null || book.getBookStatus() != BookStatus.AVAILABLE) {
            resp.sendError(HttpServletResponse.SC_BAD_REQUEST, "Book is not available for borrowing.");
            return;
        }

        // Create a new Borrower instance
        Borrower borrower = new Borrower(book, loggedInUser, dueDate, null, new Date(), null, null);
        userDao.createBorrower(borrower); // Assuming you have a method to create the borrower in UserDao

        // Update the book status
        book.setBookStatus(BookStatus.BORROWED);
        userDao.updateBook(book); // Update the book's status

        resp.setStatus(HttpServletResponse.SC_OK);
    }
    
    private void returnBook(HttpServletRequest req, HttpServletResponse resp) throws IOException {
        UUID reservationId = UUID.fromString(req.getParameter("reservationId")); // Assuming you pass this in your request
        Borrower borrower = userDao.getBorrowerById(reservationId); // Fetch the borrower record

        if (borrower == null) {
            resp.sendError(HttpServletResponse.SC_BAD_REQUEST, "Borrower record not found.");
            return;
        }

        Date returnDate = new Date(); // Get the current date
        borrower.setReturnDate(returnDate); // Set the return date

        // Calculate late fee
        int lateFee = userDao.calculateLateFee(borrower.getDueDate(), returnDate);
        borrower.setLateFees(lateFee); // Set the calculated late fees

        // Update the borrower record in the database
        userDao.updateBorrower(borrower); // Assuming you have a method to update the borrower

        // Optionally update the book status to available again
        Book book = borrower.getBook();
        book.setBookStatus(BookStatus.AVAILABLE);
        userDao.updateBook(book); // Update the book's status

        resp.getWriter().write("Book returned successfully. Late fee: " + lateFee);
    }
    private void showActiveBorrowers(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        User loggedInUser = (User) req.getSession().getAttribute("loggedInUser");
        List<Borrower> activeBorrowers = userDao.getActiveBorrowers(loggedInUser.getPersonId());
        req.setAttribute("activeBorrowers", activeBorrowers);
        req.getRequestDispatcher("returnBook.jsp").forward(req, resp);
    }


}
