package view;

import model.Room;
import model.Shelf;
import controller.UserDao;
import util.HibernateUtil;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import org.hibernate.Session;
import org.hibernate.Transaction;
import java.io.IOException;
import java.util.UUID;

@WebServlet("/RoomServlet")
public class RoomServlet extends HttpServlet {

    private UserDao userDao = new UserDao();

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String action = req.getParameter("action");

        if ("insertShelf".equals(action)) {
            insertShelf(req, resp);
        } else {
            resp.sendError(HttpServletResponse.SC_BAD_REQUEST, "Invalid action");
        }
    }

    private void insertShelf(HttpServletRequest req, HttpServletResponse resp) throws IOException {
        System.out.println("Insert Shelf method called");
        String roomCode = req.getParameter("roomCode");
        String bookCategory = req.getParameter("bookCategory");
        int availableStock = Integer.parseInt(req.getParameter("availableStock"));
        int initialStock = Integer.parseInt(req.getParameter("initialStock"));

        System.out.println("Received values: roomCode=" + roomCode + ", bookCategory=" + bookCategory + ", availableStock=" + availableStock + ", initialStock=" + initialStock);

        // Create new Room and Shelf instances
        Room room = new Room();
        room.setRoomCode(roomCode);
        
        Shelf shelf = new Shelf();
        shelf.setBookCategory(bookCategory);
        shelf.setAvailableStock(availableStock);
        shelf.setInitialStock(initialStock);
        shelf.setRoom(room); // Associate the shelf with the room

        // Insert Room and Shelf into the database
        try {
            userDao.createRoom(room); // Create the room
            userDao.createShelf(shelf); // Create the shelf
            resp.getWriter().write("Shelf inserted successfully.");
        } catch (Exception e) {
            e.printStackTrace(); // Log the error for debugging
            resp.getWriter().write("Failed to insert shelf: " + e.getMessage());
        }
    }
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String action = req.getParameter("action");

        if ("countBooks".equals(action)) {
            countBooks(req, resp);
        } else {
            resp.sendError(HttpServletResponse.SC_BAD_REQUEST, "Invalid action");
        }
    }

    // Method to count books in a specific room
    private void countBooks(HttpServletRequest req, HttpServletResponse resp) throws IOException {
        String roomIdStr = req.getParameter("roomId");
        if (roomIdStr == null || roomIdStr.isEmpty()) {
            resp.sendError(HttpServletResponse.SC_BAD_REQUEST, "Room ID is required");
            return;
        }

        try {
            UUID roomId = UUID.fromString(roomIdStr); // Assuming roomId is of type UUID
            long count = userDao.countBooksInRoom(roomId); // Call to your method that counts books
            resp.getWriter().write(String.valueOf(count)); // Write the count to the response
        } catch (IllegalArgumentException e) {
            resp.sendError(HttpServletResponse.SC_BAD_REQUEST, "Invalid Room ID format");
        }
    }



}
