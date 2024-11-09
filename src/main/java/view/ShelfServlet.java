package view;

import model.Shelf;
import model.Room;
import org.hibernate.Session;
import org.hibernate.Transaction;
import util.HibernateUtil;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.UUID;

@WebServlet("/ShelfServlet")
public class ShelfServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String action = req.getParameter("action");

        switch (action) {
            case "addShelf":
                addShelf(req, resp);
                break;
            case "updateShelf":
                updateShelf(req, resp);
                break;
            default:
                resp.sendError(HttpServletResponse.SC_BAD_REQUEST, "Invalid action");
                break;
        }
    }

    private void addShelf(HttpServletRequest req, HttpServletResponse resp) throws IOException {
        String bookCategory = req.getParameter("bookCategory");
        int initialStock = Integer.parseInt(req.getParameter("initialStock"));
        String roomIdStr = req.getParameter("roomId");

        try (Session session = HibernateUtil.getSession().openSession()) {
            Transaction transaction = session.beginTransaction();
            
            Room room = session.get(Room.class, UUID.fromString(roomIdStr));
            if (room == null) {
                resp.sendError(HttpServletResponse.SC_BAD_REQUEST, "Invalid room ID.");
                return;
            }

            Shelf shelf = new Shelf(bookCategory, initialStock, 0, initialStock, null, room);
            session.save(shelf);
            transaction.commit();

            resp.getWriter().write("Shelf added successfully");
        } catch (Exception e) {
            resp.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Error adding shelf: " + e.getMessage());
        }
    }

    private void updateShelf(HttpServletRequest req, HttpServletResponse resp) throws IOException {
        UUID shelfId = UUID.fromString(req.getParameter("shelfId"));
        String bookCategory = req.getParameter("bookCategory");
        int availableStock = Integer.parseInt(req.getParameter("availableStock"));
        int borrowedNumber = Integer.parseInt(req.getParameter("borrowedNumber"));

        try (Session session = HibernateUtil.getSession().openSession()) {
            Transaction transaction = session.beginTransaction();

            Shelf shelf = session.get(Shelf.class, shelfId);
            if (shelf == null) {
                resp.sendError(HttpServletResponse.SC_NOT_FOUND, "Shelf not found.");
                return;
            }

            shelf.setBookCategory(bookCategory);
            shelf.setAvailableStock(availableStock);
            shelf.setBorrowedNumber(borrowedNumber);

            session.update(shelf);
            transaction.commit();

            resp.getWriter().write("Shelf updated successfully");
        }
    }
}
