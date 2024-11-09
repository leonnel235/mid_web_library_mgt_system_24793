package view;

import java.io.IOException;
import java.util.Arrays;
import java.util.Date;
import java.util.List;
import java.util.UUID;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.hibernate.Session;
import org.hibernate.Transaction;

import com.fasterxml.jackson.databind.ObjectMapper;

import controller.UserDao;
import model.Book;
import model.BookStatus;
import model.Shelf;
import util.HibernateUtil;

@WebServlet("/BookServlet")
public class BookServlet extends HttpServlet {

	private UserDao userDao = new UserDao();
	private ObjectMapper objectMapper = new ObjectMapper();

	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
	    // Log all parameters received
	    req.getParameterMap().forEach((key, value) -> {
	        System.out.println("Parameter: " + key + ", Value: " + Arrays.toString(value));
	    });

	    String action = req.getParameter("action");
	    System.out.println("Received action: " + action);
	    
	    if (action == null) {
	        resp.sendError(HttpServletResponse.SC_BAD_REQUEST, "Action parameter is missing");
	        return;
	    }


	    switch (action) {
	        case "addBook":
	            addBook(req, resp);
	            break;
	        case "updateBook":
	            updateBook(req, resp);
	            break;
	        case "assignToShelf":
	            assignBookToShelf(req, resp);
	            break;
	        default:
	            resp.sendError(HttpServletResponse.SC_BAD_REQUEST, "Invalid action");
	            break;
	    }
	}


	@Override
	protected void doDelete(HttpServletRequest req, HttpServletResponse resp) throws IOException {
		Long bookId = Long.parseLong(req.getParameter("bookId"));
		deleteBook(bookId, resp);
	}

	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws IOException {
		String action = req.getParameter("action");

		if ("searchBooks".equals(action)) {
			searchBooks(req, resp);
		} else {
			resp.sendError(HttpServletResponse.SC_BAD_REQUEST, "Invalid action");
		}
	}

	// Adding a new book
	private void addBook(HttpServletRequest req, HttpServletResponse resp) throws IOException {
		String title = req.getParameter("title");
		String isbnCode = req.getParameter("isbnCode");
		String editionStr = req.getParameter("edition");
		String yearStr = req.getParameter("year");
		String publisherName = req.getParameter("publisherName");
		String shelfIdStr = req.getParameter("shelfId");
		String bookStatusStr = req.getParameter("bookStatus");

		try {
			UUID shelfId = shelfIdStr != null ? UUID.fromString(shelfIdStr) : null;
			Integer edition = Integer.parseInt(editionStr);
			Integer publicationYear = Integer.parseInt(yearStr);
			Date publicationDate = new Date();
			BookStatus bookStatus = BookStatus.valueOf(bookStatusStr.toUpperCase());

			try (Session session = HibernateUtil.getSession().openSession()) {
				Transaction transaction = session.beginTransaction();

				Shelf shelf = shelfId != null ? session.get(Shelf.class, shelfId) : null;

				if (shelfId != null && shelf == null) {
					resp.sendRedirect("manageBooks.jsp?message=Invalid shelf ID.");
					return;
				}

				Book book = new Book(title, isbnCode, edition, publicationDate, publisherName, bookStatus, shelf);
				session.save(book);
				transaction.commit();

				resp.sendRedirect("manageBooks.jsp?message=Book added successfully.");
			}
		} catch (Exception e) {
			resp.sendRedirect("manageBooks.jsp?message=Failed to add book: " + e.getMessage());
		}
	}

	// Updating an existing book
	private void updateBook(HttpServletRequest req, HttpServletResponse resp) throws IOException {
		Long bookId = Long.parseLong(req.getParameter("bookId"));
		String title = req.getParameter("title");
		String isbnCode = req.getParameter("isbnCode");
		Integer edition = Integer.parseInt(req.getParameter("edition"));
		String publisherName = req.getParameter("publisherName");
		BookStatus bookStatus = BookStatus.valueOf(req.getParameter("bookStatus"));

		try (Session session = HibernateUtil.getSession().openSession()) {
			Transaction transaction = session.beginTransaction();

			Book book = session.get(Book.class, bookId);
			if (book == null) {
				resp.sendRedirect("manageBooks.jsp?message=Book not found.");
				return;
			}

			book.setTitle(title);
			book.setIsbnCode(isbnCode);
			book.setEdition(edition);
			book.setPublisherName(publisherName);
			book.setBookStatus(bookStatus);

			session.update(book);
			transaction.commit();

			resp.sendRedirect("manageBooks.jsp?message=Book updated successfully.");
		}
	}

	// Deleting a book
	private void deleteBook(Long bookId, HttpServletResponse resp) throws IOException {
		try (Session session = HibernateUtil.getSession().openSession()) {
			Transaction transaction = session.beginTransaction();

			Book book = session.get(Book.class, bookId);
			if (book == null) {
				resp.sendRedirect("manageBooks.jsp?message=Book not found.");
				return;
			}

			session.delete(book);
			transaction.commit();

			resp.sendRedirect("manageBooks.jsp?message=Book deleted successfully.");
		}
	}

	// Assigning a book to a shelf
	private void assignBookToShelf(HttpServletRequest req, HttpServletResponse resp) throws IOException, ServletException {
	    // Retrieving parameters
	    Long bookId = Long.parseLong(req.getParameter("bookId"));
	    UUID shelfId = UUID.fromString(req.getParameter("shelfId"));

	    try (Session session = HibernateUtil.getSession().openSession()) {
	        Transaction transaction = session.beginTransaction();

	        Book book = session.get(Book.class, bookId);
	        Shelf shelf = session.get(Shelf.class, shelfId);

	        if (book == null || shelf == null) {
	            req.setAttribute("message", "Invalid book or shelf ID.");
	            // Forward back to the same page with message
	            req.getRequestDispatcher("assignShelf.jsp").forward(req, resp);
	            return;
	        }

	        book.setShelf(shelf);
	        session.update(book);
	        transaction.commit();

	        req.setAttribute("message", "Book assigned to shelf successfully.");
	        // Forward back to the same page with message
	        req.getRequestDispatcher("assignShelf.jsp").forward(req, resp);
	    } catch (Exception e) {
	        req.setAttribute("message", "Error assigning book to shelf: " + e.getMessage());
	        // Forward back to the same page with message
	        req.getRequestDispatcher("assignShelf.jsp").forward(req, resp);
	    }
	}


	// Searching for books
	private void searchBooks(HttpServletRequest req, HttpServletResponse resp) throws IOException {
		String keyword = req.getParameter("keyword");

		try (Session session = HibernateUtil.getSession().openSession()) {
			List<Book> books = session
					.createQuery("FROM Book b WHERE b.title LIKE :keyword OR b.isbnCode LIKE :keyword", Book.class)
					.setParameter("keyword", "%" + keyword + "%").getResultList();

			resp.setContentType("application/json");
			resp.getWriter().write(objectMapper.writeValueAsString(books));
		}
	}
}
