package controller.customer;

import dal.DBContext;
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
import model.User;

@WebServlet(name = "ChangePasswordServlet", urlPatterns = {"/customer/changePassword"})
public class ChangePasswordServlet extends HttpServlet {
    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // Get parameters
        String currentPassword = request.getParameter("currentPassword");
        String newPassword = request.getParameter("newPassword");
        String confirmNewPassword = request.getParameter("confirmNewPassword");
        
        // Get user from session
        HttpSession session = request.getSession();
        User loggedInUser = (User) session.getAttribute("user");
        
        if (loggedInUser == null) {
            // User not logged in, redirect to login
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }
        
        // Initialize error messages
        String errorMessage = null;
        
        // Validate inputs
        if (currentPassword == null || currentPassword.trim().isEmpty() ||
            newPassword == null || newPassword.trim().isEmpty() ||
            confirmNewPassword == null || confirmNewPassword.trim().isEmpty()) {
            errorMessage = "All fields are required";
        } else if (!newPassword.equals(confirmNewPassword)) {
            errorMessage = "New password and confirmation do not match";
        } else if (newPassword.length() < 6) {
            errorMessage = "New password must be at least 6 characters long";
        }
        
        // If there are validation errors, redirect back with error message
        if (errorMessage != null) {
            request.getSession().setAttribute("passwordError", errorMessage);
            response.sendRedirect(request.getContextPath() + "/customer/info");
            return;
        }
        
        try {
            // Connect to database
            DBContext dbContext = new DBContext();
            Connection conn = dbContext.getConnection();
            
            // First, verify the current password
            String checkSql = "SELECT * FROM Users WHERE id = ? AND pass = ?";
            PreparedStatement checkStmt = conn.prepareStatement(checkSql);
            checkStmt.setInt(1, loggedInUser.getId());
            checkStmt.setString(2, currentPassword);
            
            ResultSet rs = checkStmt.executeQuery();
            
            if (!rs.next()) {
                // Current password is incorrect
                request.getSession().setAttribute("passwordError", "Current password is incorrect");
                response.sendRedirect(request.getContextPath() + "/customer/info");
                return;
            }
            
            // Update the password
            String updateSql = "UPDATE Users SET pass = ? WHERE id = ?";
            PreparedStatement updateStmt = conn.prepareStatement(updateSql);
            updateStmt.setString(1, newPassword);
            updateStmt.setInt(2, loggedInUser.getId());
            
            int rowsAffected = updateStmt.executeUpdate();
            
            if (rowsAffected > 0) {
                // Password updated successfully
                // Update session user
                loggedInUser.setPassword(newPassword);
                session.setAttribute("user", loggedInUser);
                
                // Set success message
                session.setAttribute("passwordSuccess", "Password changed successfully");
            } else {
                // Failed to update password
                session.setAttribute("passwordError", "Failed to update password");
            }
            
            // Close resources
            updateStmt.close();
            checkStmt.close();
            rs.close();
            conn.close();
            
        } catch (SQLException e) {
            // Database error
            session.setAttribute("passwordError", "Database error: " + e.getMessage());
        }
        
        // Redirect back to profile page
        response.sendRedirect(request.getContextPath() + "/customer/info");
    }
}
