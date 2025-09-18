package eShelf;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class DatabaseConnection {
    private static final String URL = "jdbc:mysql://localhost:3306/library_management";

    // Your MySQL username (default is often 'root')
    private static final String USER = "root";

    // The password you set for your MySQL user
    private static final String PASSWORD = "122057@Ar";

    public static Connection getConnection() throws SQLException {
        try {
            // This line loads the MySQL JDBC driver
            Class.forName("com.mysql.cj.jdbc.Driver");
            return DriverManager.getConnection(URL, USER, PASSWORD);
        } catch (ClassNotFoundException e) {
            throw new SQLException("MySQL JDBC Driver not found.", e);
        }
    }
}