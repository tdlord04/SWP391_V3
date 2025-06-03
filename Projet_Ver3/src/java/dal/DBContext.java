package dal;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;
import java.util.logging.Level;
import java.util.logging.Logger;

/**
 *
 * @author ADMIN
 */
public class DBContext {

    public Connection connection;

    public DBContext() {
        try {
            // Change the username, password, and URL to match your database settings
            String username = "sa";
            String password = "123";
            String url = "jdbc:sqlserver://LAPTOP-1FTTSJ3D\\TUAN2004:1433;databaseName=BookingHotel_Local;encrypt=true;trustServerCertificate=true";
            Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver");
            connection = DriverManager.getConnection(url, username, password);
        } catch (ClassNotFoundException | SQLException ex) {
            Logger.getLogger(DBContext.class.getName()).log(Level.SEVERE, null, ex);
        }
    }

    public Connection getConnection() throws SQLException {
        DBContext dbContext = new DBContext();
        // Kiểm tra xem kết nối có null không trước khi trả về
        if (dbContext.connection == null) {
            throw new SQLException("Failed to establish database connection through DBContext.");
        }
        return dbContext.connection;
    }

    public boolean isConnected() {
        try {
            return connection != null && !connection.isClosed();
        } catch (SQLException ex) {
            Logger.getLogger(DBContext.class.getName()).log(Level.SEVERE, null, ex);
            return false;
        }
    }

    public static void main(String[] args) {
        DBContext dbContext = new DBContext();
        if (dbContext.isConnected()) {
            System.out.println("Đã kết nối đến cơ sở dữ liệu.");
        } else {
            System.out.println("Chưa kết nối được đến cơ sở dữ liệu.");
        }
    }

}
