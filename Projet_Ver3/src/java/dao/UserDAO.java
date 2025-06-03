package dao;

import dal.DBContext; // Import lớp DBContext
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Date; // Sử dụng java.sql.Date cho các thao tác với cơ sở dữ liệu
import java.sql.Statement;

import java.util.ArrayList;
import java.util.List;
import model.User;

public class UserDAO {

    private static final String SELECT_ALL_USERS = "SELECT TOP (1000) [id], [user_name], [pass], [full_name], [birth], [gender], [email], [phone], [address], [role], [isDeleted] FROM [dbo].[Users]";

    private Connection getConnection() throws SQLException {
        DBContext dbContext = new DBContext();
        if (dbContext.connection == null) {
            throw new SQLException("Failed to establish database connection through DBContext.");
        }
        return dbContext.connection;
    }

    // --- CRUD Operations ---
    /**
     * Thêm một người dùng mới vào cơ sở dữ liệu.
     *
     * @param user Đối tượng User cần thêm (id sẽ được tự động tạo bởi DB)
     * @return true nếu thêm thành công, false nếu ngược lại
     */
    public boolean addUser(User user) {
        String SQL_INSERT = "INSERT INTO Users (user_name, pass, full_name, birth, gender, email, phone, address, role, isDeleted) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";
        Connection conn; // Khai báo Connection bên ngoài try-with-resources để có thể đóng trong finally
        try {
            conn = getConnection(); // Lấy kết nối từ DBContext
            PreparedStatement pstmt = conn.prepareStatement(SQL_INSERT);

            pstmt.setString(1, user.getUserName());
            pstmt.setString(2, user.getPassword());
            pstmt.setNString(3, user.getFullName()); // Dùng setNString cho NVARCHAR
            pstmt.setDate(4, user.getBirth() != null ? new Date(user.getBirth().getTime()) : null); // Chuyển util.Date sang sql.Date
            pstmt.setNString(5, user.getGender());
            pstmt.setString(6, user.getEmail());
            pstmt.setString(7, user.getPhone());
            pstmt.setNString(8, user.getAddress()); // Dùng setNString cho NVARCHAR
            pstmt.setNString(9, user.getRole());
            pstmt.setBoolean(10, user.isDeleted());

            int rowsAffected = pstmt.executeUpdate();
            return rowsAffected > 0;

        } catch (SQLException e) {
            System.err.println("Error adding user: " + e.getMessage());
            e.printStackTrace();
        }
        return false;
    }

    /**
     * Lấy tất cả người dùng từ cơ sở dữ liệu.
     *
     * @return Danh sách các đối tượng User
     */
    public List<User> getAllUsers() {
        List<User> users = new ArrayList<>();
        Connection connection = null;
        Statement statement = null;
        ResultSet resultSet = null;

        try {
            connection = getConnection();
            statement = connection.createStatement();
            resultSet = statement.executeQuery(SELECT_ALL_USERS);

            while (resultSet.next()) {
                User user = new User();
                user.setId(resultSet.getInt("id"));
                user.setUserName(resultSet.getString("user_name"));
                user.setPassword(resultSet.getString("pass"));
                user.setFullName(resultSet.getString("full_name"));
                user.setBirth(resultSet.getDate("birth"));
                user.setGender(resultSet.getString("gender"));
                user.setEmail(resultSet.getString("email"));
                user.setPhone(resultSet.getString("phone"));
                user.setAddress(resultSet.getString("address"));
                user.setRole(resultSet.getString("role"));
                user.setDeleted(resultSet.getBoolean("isDeleted"));
                users.add(user);
            }
            System.out.println("UserDAO: Successfully fetched " + users.size() + " users from database.");
        } catch (SQLException e) {
            System.err.println("UserDAO Error: " + e.getMessage());
            e.printStackTrace();
        } finally {
            // Đảm bảo đóng tài nguyên theo thứ tự ngược lại
            try {
                if (resultSet != null) {
                    resultSet.close();
                }
                if (statement != null) {
                    statement.close();
                }
                if (connection != null) {
                    connection.close();
                }
            } catch (SQLException e) {
                System.err.println("Error closing database resources: " + e.getMessage());
            }
        }
        return users;
    }

    /**
     * Tìm người dùng theo ID.
     *
     * @param id ID của người dùng
     * @return Đối tượng User nếu tìm thấy, null nếu không
     */
    public User getUserById(int id) {
        String SQL_SELECT_BY_ID = "SELECT id, user_name, pass, full_name, birth, gender, email, phone, address, role, isDeleted FROM Users WHERE id = ?";
        Connection conn;
        PreparedStatement pstmt;
        ResultSet rs;
        try {
            conn = getConnection();
            pstmt = conn.prepareStatement(SQL_SELECT_BY_ID);
            pstmt.setInt(1, id);
            rs = pstmt.executeQuery();

            if (rs.next()) {
                User user = new User();
                user.setId(rs.getInt("id"));
                user.setUserName(rs.getString("user_name"));
                user.setPassword(rs.getString("pass"));
                user.setFullName(rs.getNString("full_name"));
                user.setBirth(rs.getDate("birth"));
                user.setGender(rs.getNString("gender"));
                user.setEmail(rs.getString("email"));
                user.setPhone(rs.getString("phone"));
                user.setAddress(rs.getNString("address"));
                user.setRole(rs.getNString("role"));
                user.setDeleted(rs.getBoolean("isDeleted"));
                return user;
            }
        } catch (SQLException e) {
            System.err.println("Error getting user by ID: " + e.getMessage());
            e.printStackTrace();
        }
        return null;
    }

    public User getUserByUsername(String username) {
        String SQL_SELECT_BY_ID = "SELECT id, user_name, pass, full_name, birth, gender, email, phone, address, role, isDeleted FROM Users WHERE user_name = ?";
        Connection conn;
        PreparedStatement pstmt;
        ResultSet rs;
        try {
            conn = getConnection();
            pstmt = conn.prepareStatement(SQL_SELECT_BY_ID);
            pstmt.setString(1, username);
            rs = pstmt.executeQuery();

            if (rs.next()) {
                User user = new User();
                user.setId(rs.getInt("id"));
                user.setUserName(rs.getString("user_name"));
                user.setPassword(rs.getString("pass"));
                user.setFullName(rs.getNString("full_name"));
                user.setBirth(rs.getDate("birth"));
                user.setGender(rs.getNString("gender"));
                user.setEmail(rs.getString("email"));
                user.setPhone(rs.getString("phone"));
                user.setAddress(rs.getNString("address"));
                user.setRole(rs.getNString("role"));
                user.setDeleted(rs.getBoolean("isDeleted"));
                return user;
            }
        } catch (SQLException e) {
            System.err.println("Error getting user by ID: " + e.getMessage());
            e.printStackTrace();
        }
        return null;
    }

    /**
     * Cập nhật thông tin người dùng.
     *
     * @param user Đối tượng User chứa thông tin mới (cần có ID để xác định)
     * @return true nếu cập nhật thành công, false nếu ngược lại
     */
    public boolean updateUser(User user) {
        String SQL_UPDATE = "UPDATE Users SET user_name = ?, pass = ?, full_name = ?, birth = ?, gender = ?, email = ?, phone = ?, address = ?, role = ?, isDeleted = ? WHERE id = ?";
        Connection conn;
        PreparedStatement pstmt;
        try {
            conn = getConnection();
            pstmt = conn.prepareStatement(SQL_UPDATE);

            pstmt.setString(1, user.getUserName());
            pstmt.setString(2, user.getPassword());
            pstmt.setNString(3, user.getFullName());
            pstmt.setDate(4, user.getBirth() != null ? new Date(user.getBirth().getTime()) : null);
            pstmt.setNString(5, user.getGender());
            pstmt.setString(6, user.getEmail());
            pstmt.setString(7, user.getPhone());
            pstmt.setNString(8, user.getAddress());
            pstmt.setNString(9, user.getRole());
            pstmt.setBoolean(10, user.isDeleted());
            pstmt.setInt(11, user.getId()); // Điều kiện WHERE

            int rowsAffected = pstmt.executeUpdate();
            return rowsAffected > 0;

        } catch (SQLException e) {
            System.err.println("Error updating user: " + e.getMessage());
            e.printStackTrace();
        }
        return false;
    }

    /**
     * Xóa một người dùng khỏi cơ sở dữ liệu (xóa mềm).
     *
     * @param id ID của người dùng cần xóa
     * @return true nếu xóa thành công, false nếu ngược lại
     */
    public boolean softDeleteUser(int id) {
        String SQL_SOFT_DELETE = "UPDATE Users SET isDeleted = 1 WHERE id = ?";
        Connection conn;
        PreparedStatement pstmt;
        try {
            conn = getConnection();
            pstmt = conn.prepareStatement(SQL_SOFT_DELETE);

            pstmt.setInt(1, id);
            int rowsAffected = pstmt.executeUpdate();
            return rowsAffected > 0;

        } catch (SQLException e) {
            System.err.println("Error soft deleting user: " + e.getMessage());
            e.printStackTrace();
        }
        return false;
    }

    // Phương thức kiểm tra đăng nhập (ví dụ đơn giản)
    public User loginByUsername(String username, String password) {
        String SQL_LOGIN = "SELECT id, user_name, pass, full_name, birth, gender, email, phone, address, role, isDeleted FROM Users WHERE user_name = ? AND pass = ? AND isDeleted = 0";
        Connection conn;
        PreparedStatement pstmt;
        ResultSet rs;
        try {
            conn = getConnection();
            pstmt = conn.prepareStatement(SQL_LOGIN);

            pstmt.setString(1, username);
            pstmt.setString(2, password);

            rs = pstmt.executeQuery();
            if (rs.next()) {
                User user = new User();
                user.setId(rs.getInt("id"));
                user.setUserName(rs.getString("user_name"));
                user.setPassword(rs.getString("pass"));
                user.setFullName(rs.getNString("full_name"));
                user.setBirth(rs.getDate("birth"));
                user.setGender(rs.getNString("gender"));
                user.setEmail(rs.getString("email"));
                user.setPhone(rs.getString("phone"));
                user.setAddress(rs.getNString("address"));
                user.setRole(rs.getNString("role"));
                user.setDeleted(rs.getBoolean("isDeleted"));
                return user;
            }
        } catch (SQLException e) {
            System.err.println("Error during login: " + e.getMessage());
            e.printStackTrace();
        }
        return null;
    }

    public User loginByEmail(String email, String password) {
        String SQL_LOGIN = "SELECT id, user_name, pass, full_name, birth, gender, email, phone, address, role, isDeleted FROM Users WHERE email = ? AND pass = ? AND isDeleted = 0";
        Connection conn;
        PreparedStatement pstmt;
        ResultSet rs;
        try {
            conn = getConnection();
            pstmt = conn.prepareStatement(SQL_LOGIN);

            pstmt.setString(1, email);
            pstmt.setString(2, password);

            rs = pstmt.executeQuery();
            if (rs.next()) {
                User user = new User();
                user.setId(rs.getInt("id"));
                user.setUserName(rs.getString("user_name"));
                user.setPassword(rs.getString("pass"));
                user.setFullName(rs.getNString("full_name"));
                user.setBirth(rs.getDate("birth"));
                user.setGender(rs.getNString("gender"));
                user.setEmail(rs.getString("email"));
                user.setPhone(rs.getString("phone"));
                user.setAddress(rs.getNString("address"));
                user.setRole(rs.getNString("role"));
                user.setDeleted(rs.getBoolean("isDeleted"));
                return user;
            }
        } catch (SQLException e) {
            System.err.println("Error during login: " + e.getMessage());
            e.printStackTrace();
        }
        return null;
    }

    public User loginByPhone(String phone, String password) {
        String SQL_LOGIN = "SELECT id, user_name, pass, full_name, birth, gender, email, phone, address, role, isDeleted FROM Users WHERE phone = ? AND pass = ? AND isDeleted = 0";
        Connection conn;
        PreparedStatement pstmt;
        ResultSet rs;
        try {
            conn = getConnection();
            pstmt = conn.prepareStatement(SQL_LOGIN);

            pstmt.setString(1, phone);
            pstmt.setString(2, password);

            rs = pstmt.executeQuery();
            if (rs.next()) {
                User user = new User();
                user.setId(rs.getInt("id"));
                user.setUserName(rs.getString("user_name"));
                user.setPassword(rs.getString("pass"));
                user.setFullName(rs.getNString("full_name"));
                user.setBirth(rs.getDate("birth"));
                user.setGender(rs.getNString("gender"));
                user.setEmail(rs.getString("email"));
                user.setPhone(rs.getString("phone"));
                user.setAddress(rs.getNString("address"));
                user.setRole(rs.getNString("role"));
                user.setDeleted(rs.getBoolean("isDeleted"));
                return user;
            }
        } catch (SQLException e) {
            System.err.println("Error during login: " + e.getMessage());
            e.printStackTrace();
        }
        return null;
    }

    // Kiểm tra tên người dùng đã tồn tại chưa
    public boolean isUsernameExists(String username) {
        String SQL_CHECK_USERNAME = "SELECT COUNT(*) FROM Users WHERE user_name = ?";
        Connection conn;
        PreparedStatement pstmt;
        ResultSet rs;
        try {
            conn = getConnection();
            pstmt = conn.prepareStatement(SQL_CHECK_USERNAME);
            pstmt.setString(1, username);
            rs = pstmt.executeQuery();
            if (rs.next()) {
                if (rs.getInt(1) > 0) {
                    return true;
                }
            }
        } catch (SQLException e) {
            System.err.println("Error checking username existence: " + e.getMessage());
            e.printStackTrace();
        }
        return false;
    }

    public static void main(String[] args) {
        Date birthDate = new Date(2000 - 1900, 1 - 1, 15); 

        // Tạo user mới
        User newUser = new User(
                "Customer123", // userName
                "Customer123", // pass
                "Nguyễn Văn A", // fullName
                birthDate, // birth
                "Nam", // gender
                "customer123@gmail.com", // email
                "0123456789", // phone
                "Hà Nội, Việt Nam", // address
                "customer", // role
                false // isDeleted
        );

        System.out.println(newUser);
    }
}
