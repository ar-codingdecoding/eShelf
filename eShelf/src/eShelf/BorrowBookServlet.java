package eShelf;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.time.LocalDate;

@WebServlet("/borrowBook")
public class BorrowBookServlet extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();

        // Get user ID from session and book ID from the form
        int userId = (int) session.getAttribute("userId");
        int bookId = Integer.parseInt(request.getParameter("bookId"));

        String insertBorrowSql = "INSERT INTO borrowings (book_id, user_id, start_date, finish_date) VALUES (?, ?, ?, ?)";
        String updateBookSql = "UPDATE books SET brwcopies = brwcopies - 1 WHERE id = ?";

        try (Connection conn = DatabaseConnection.getConnection()) {
            // Start a transaction
            conn.setAutoCommit(false);

            try (PreparedStatement insertStmt = conn.prepareStatement(insertBorrowSql);
                 PreparedStatement updateStmt = conn.prepareStatement(updateBookSql)) {

                // 1. Insert into borrowings table
                insertStmt.setInt(1, bookId);
                insertStmt.setInt(2, userId);
                insertStmt.setDate(3, java.sql.Date.valueOf(LocalDate.now()));
                insertStmt.setDate(4, java.sql.Date.valueOf(LocalDate.now().plusDays(14))); 
                insertStmt.executeUpdate();

                // 2. Decrement the available borrowing copies
                updateStmt.setInt(1, bookId);
                updateStmt.executeUpdate();

                // If both commands succeed, commit the transaction
                conn.commit();

            } catch (Exception e) {
                // If anything fails, rollback the transaction
                conn.rollback();
                throw new ServletException("Error during borrowing process.", e);
            }

        } catch (Exception e) {
            throw new ServletException("Database error during borrowing process.", e);
        }

        // Redirect back to the book list
        response.sendRedirect("viewBooks");
    }
}
