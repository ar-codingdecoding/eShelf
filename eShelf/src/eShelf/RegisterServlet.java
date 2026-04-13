package eShelf;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;

@WebServlet("/register")
public class RegisterServlet extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String name = request.getParameter("name");
        String email = request.getParameter("email");
        String phonenumber = request.getParameter("phonenumber");
        String password = request.getParameter("password");
        String role = "User"; // Default newly joined patron to User

        String sql = "INSERT INTO users (name, email, phonenumber, password, role) VALUES (?, ?, ?, ?, ?)";

        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            
            stmt.setString(1, name);
            stmt.setString(2, email);
            stmt.setString(3, phonenumber);
            stmt.setString(4, password);
            stmt.setString(5, role);
            
            stmt.executeUpdate();

        } catch (Exception e) {
            throw new ServletException("Database error during registration.", e);
        }

        // Successfully registered! Let's redirect them to login.
        response.sendRedirect("login.html");
    }
}
