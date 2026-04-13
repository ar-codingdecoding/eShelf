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
import java.util.ArrayList;
import java.util.List;

@WebServlet("/myBooks")
public class MyBooksServlet extends HttpServlet {
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();
        Integer userId = (Integer) session.getAttribute("userId");
        if (userId == null) {
            response.sendRedirect("login.html");
            return;
        }

        List<BorrowInfo> borrows = new ArrayList<>();
        List<OrderInfo> orders = new ArrayList<>();

        try (Connection conn = DatabaseConnection.getConnection()) {
            // Fetch borrowings
            String borrowSql = "SELECT br.id, br.book_id, b.name AS bookName, br.start_date, br.finish_date " +
                               "FROM borrowings br JOIN books b ON br.book_id = b.id WHERE br.user_id = ?";
            try (PreparedStatement stmt = conn.prepareStatement(borrowSql)) {
                stmt.setInt(1, userId);
                ResultSet rs = stmt.executeQuery();
                while (rs.next()) {
                    BorrowInfo info = new BorrowInfo();
                    info.setBorrowId(rs.getInt("id"));
                    info.setBookId(rs.getInt("book_id"));
                    info.setBookName(rs.getString("bookName"));
                    info.setStartDate(rs.getDate("start_date"));
                    info.setFinishDate(rs.getDate("finish_date"));
                    borrows.add(info);
                }
            }

            // Fetch orders
            String orderSql = "SELECT o.id, b.name AS bookName, o.price, o.qty " +
                              "FROM orders o JOIN books b ON o.book_id = b.id WHERE o.user_id = ?";
            try (PreparedStatement stmt = conn.prepareStatement(orderSql)) {
                stmt.setInt(1, userId);
                ResultSet rs = stmt.executeQuery();
                while (rs.next()) {
                    OrderInfo info = new OrderInfo();
                    info.setOrderId(rs.getInt("id"));
                    info.setBookName(rs.getString("bookName"));
                    info.setPrice(rs.getDouble("price"));
                    info.setQty(rs.getInt("qty"));
                    orders.add(info);
                }
            }
        } catch (Exception e) {
            throw new ServletException("Database error fetching user books", e);
        }

        request.setAttribute("borrows", borrows);
        request.setAttribute("orders", orders);
        request.getRequestDispatcher("myBooks.jsp").forward(request, response);
    }
}
