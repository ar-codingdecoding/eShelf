package eShelf;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;

@WebServlet("/returnBook")
public class ReturnBookServlet extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        int borrowId = Integer.parseInt(request.getParameter("borrowId"));
        int bookId = Integer.parseInt(request.getParameter("bookId"));

        String deleteBorrowSql = "DELETE FROM borrowings WHERE id = ?";
        String updateBookSql = "UPDATE books SET brwcopies = brwcopies + 1 WHERE id = ?";

        try (Connection conn = DatabaseConnection.getConnection()) {
            conn.setAutoCommit(false);
            
            try (PreparedStatement deleteStmt = conn.prepareStatement(deleteBorrowSql);
                 PreparedStatement updateStmt = conn.prepareStatement(updateBookSql)) {

                // Remove the borrowing record
                deleteStmt.setInt(1, borrowId);
                deleteStmt.executeUpdate();

                // Increment the available copies back
                updateStmt.setInt(1, bookId);
                updateStmt.executeUpdate();

                conn.commit();
            } catch (Exception e) {
                conn.rollback();
                throw new ServletException("Error during returning process.", e);
            }
        } catch (Exception e) {
            throw new ServletException("Database error during returning process.", e);
        }

        response.sendRedirect("myBooks");
    }
}
