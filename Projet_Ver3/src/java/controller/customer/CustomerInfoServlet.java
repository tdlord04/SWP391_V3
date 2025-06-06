package controller.customer;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import dal.DBContext;
import model.User;

@WebServlet(name = "CustomerInfoServlet", urlPatterns = {"/customer/info"})
public class CustomerInfoServlet extends HttpServlet {
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        HttpSession session = request.getSession();
        User loggedInUser = (User) session.getAttribute("user");
        
        if (loggedInUser == null) {
            // User not logged in, redirect to login
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }
        
        // Get user details from database using the logged in user ID
        try {
            DBContext dbContext = new DBContext();
            Connection conn = dbContext.getConnection();
            String sql = "SELECT * FROM Users WHERE id = ?";
            PreparedStatement statement = conn.prepareStatement(sql);
            statement.setInt(1, loggedInUser.getId());
            
            ResultSet rs = statement.executeQuery();
            
            if (rs.next()) {
                // Create user object with all details
                User user = new User();
                user.setId(rs.getInt("id"));
                user.setUserName(rs.getString("user_name"));
                user.setPassword(rs.getString("pass"));
                user.setFullName(rs.getString("full_name"));
                user.setBirth(rs.getDate("birth"));
                user.setGender(rs.getString("gender"));
                user.setEmail(rs.getString("email"));
                user.setPhone(rs.getString("phone"));
                user.setAddress(rs.getString("address"));
                user.setRole(rs.getString("role"));
                user.setDeleted(rs.getInt("isDeleted") == 1);
                
                // Set user as request attribute
                request.setAttribute("user", user);
                
                // Forward to customer info page
                request.getRequestDispatcher("/customer/customerInfor.jsp").forward(request, response);
            } else {
                // User not found in database
                response.sendRedirect(request.getContextPath() + "/login");
            }
            
            rs.close();
            statement.close();
            conn.close();
            
        } catch (SQLException e) {
            e.printStackTrace();
            response.sendRedirect(request.getContextPath() + "/error.jsp");
        }
    }
    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        doGet(request, response);
    }
}
