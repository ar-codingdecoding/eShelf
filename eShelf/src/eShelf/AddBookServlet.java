package eShelf;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;

@WebServlet("/addBook")
public class AddBookServlet extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Retrieve form parameters
        String name = request.getParameter("name");
        String author = request.getParameter("author");
        double price = Double.parseDouble(request.getParameter("price"));
        int qty = Integer.parseInt(request.getParameter("qty"));
        int brwcopies = Integer.parseInt(request.getParameter("brwcopies"));

        String sql = "INSERT INTO books (name, author, price, qty, brwcopies) VALUES (?, ?, ?, ?, ?)";

        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setString(1, name);
            stmt.setString(2, author);
            stmt.setDouble(3, price);
            stmt.setInt(4, qty);
            stmt.setInt(5, brwcopies);

            stmt.executeUpdate();

        } catch (Exception e) {
            
            throw new ServletException("Database error adding book", e);
        }
        response.sendRedirect("viewBooks");
    }
}
