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

@WebServlet("/buyBook")
public class BuyBookServlet extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();
        int userId = (int) session.getAttribute("userId");
        int bookId = Integer.parseInt(request.getParameter("bookId"));

        String getBookPriceSql = "SELECT price FROM books WHERE id = ?";
        String insertOrderSql = "INSERT INTO orders (book_id, user_id, price, qty) VALUES (?, ?, ?, 1)";
        String updateBookSql = "UPDATE books SET qty = qty - 1 WHERE id = ?";

        try (Connection conn = DatabaseConnection.getConnection()) {
            conn.setAutoCommit(false);
            
            try (PreparedStatement priceStmt = conn.prepareStatement(getBookPriceSql);
                 PreparedStatement insertStmt = conn.prepareStatement(insertOrderSql);
                 PreparedStatement updateStmt = conn.prepareStatement(updateBookSql)) {

                // Get current price of the book
                priceStmt.setInt(1, bookId);
                ResultSet rs = priceStmt.executeQuery();
                double price = 0.0;
                if (rs.next()) {
                    price = rs.getDouble("price");
                }

                // Insert into orders table
                insertStmt.setInt(1, bookId);
                insertStmt.setInt(2, userId);
                insertStmt.setDouble(3, price);
                insertStmt.executeUpdate();

                // Decrement the available physical inventory
                updateStmt.setInt(1, bookId);
                updateStmt.executeUpdate();

                conn.commit();
            } catch (Exception e) {
                conn.rollback();
                throw new ServletException("Error during purchasing process.", e);
            }
        } catch (Exception e) {
            throw new ServletException("Database error during purchasing process.", e);
        }

        response.sendRedirect("viewBooks");
    }
}
