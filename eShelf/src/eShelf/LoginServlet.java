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
import javax.servlet.http.HttpSession;

// This annotation turns the class into a servlet and maps it to the "/login" URL
@WebServlet("/login")
// This makes the class a servlet by inheriting from HttpServlet
public class LoginServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String email = request.getParameter("email");
        String phonenumber = request.getParameter("phonenumber");

        try (Connection conn = DatabaseConnection.getConnection()) {
            String sql = "SELECT * FROM users WHERE email = ? AND phonenumber = ?";
            PreparedStatement stmt = conn.prepareStatement(sql);
            stmt.setString(1, email);
            stmt.setString(2, phonenumber);

            ResultSet rs = stmt.executeQuery();

            if (rs.next()) {
                // User found, login successful
                String name = rs.getString("name");
                String role = rs.getString("role");

                // Create a new session
                HttpSession session = request.getSession();

                // Store user's name and role in the session
                session.setAttribute("username", name);
                session.setAttribute("role", role);

                // Redirect to the new dashboard.jsp
                response.sendRedirect("dashboard.jsp");

            } else {
                // Login failed
                response.sendRedirect("login.html");
            }

        } catch (Exception e) {
            throw new ServletException("Database error during login", e);
        }
    }
}