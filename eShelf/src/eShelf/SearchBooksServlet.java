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

@WebServlet("/searchBooks")
public class SearchBooksServlet extends HttpServlet {
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String query = request.getParameter("query");
        List<Book> searchResults = new ArrayList<>();
        
        if (query != null && !query.trim().isEmpty()) {
            try (Connection conn = DatabaseConnection.getConnection()) {
                String sql = "SELECT * FROM books WHERE name LIKE ? OR author LIKE ?";
                PreparedStatement stmt = conn.prepareStatement(sql);
                String pattern = "%" + query.trim() + "%";
                stmt.setString(1, pattern);
                stmt.setString(2, pattern);
                
                ResultSet rs = stmt.executeQuery();
                while (rs.next()) {
                    Book book = new Book();
                    book.setId(rs.getInt("id"));
                    book.setName(rs.getString("name"));
                    book.setAuthor(rs.getString("author"));
                    book.setPrice(rs.getDouble("price"));
                    book.setQty(rs.getInt("qty"));
                    book.setBrwcopies(rs.getInt("brwcopies"));
                    searchResults.add(book);
                }
            } catch (Exception e) {
                throw new ServletException("Database error searching books", e);
            }
        }
        
        request.setAttribute("searchResults", searchResults);
        request.getRequestDispatcher("searchBooks.jsp").forward(request, response);
    }
}
