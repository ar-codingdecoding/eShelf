package eShelf;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

@WebServlet("/viewOrders")
public class ViewOrdersServlet extends HttpServlet {
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        List<OrderInfo> orderList = new ArrayList<>();
        
        try (Connection conn = DatabaseConnection.getConnection()) {
            String sql = "SELECT o.id, b.name AS bookName, u.name AS userName, o.price, o.qty " +
                         "FROM orders o " +
                         "JOIN books b ON o.book_id = b.id " +
                         "JOIN users u ON o.user_id = u.id " +
                         "ORDER BY o.id DESC";
            PreparedStatement stmt = conn.prepareStatement(sql);
            ResultSet rs = stmt.executeQuery();
            
            while (rs.next()) {
                OrderInfo info = new OrderInfo();
                info.setOrderId(rs.getInt("id"));
                info.setBookName(rs.getString("bookName"));
                info.setUserName(rs.getString("userName"));
                info.setPrice(rs.getDouble("price"));
                info.setQty(rs.getInt("qty"));
                orderList.add(info);
            }
        } catch (Exception e) {
            throw new ServletException("Database error fetching orders", e);
        }
        
        request.setAttribute("orderList", orderList);
        request.getRequestDispatcher("viewOrders.jsp").forward(request, response);
    }
}
