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
import java.sql.Date;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import model.User;

@WebServlet(name = "UpdateProfileServlet", urlPatterns = {"/customer/updateProfile"})
public class UpdateProfileServlet extends HttpServlet {
    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        // Get parameters from form
        String fullName = request.getParameter("fullName");
        String email = request.getParameter("email");
        String phone = request.getParameter("phone");
        String address = request.getParameter("address");
        String birthDateStr = request.getParameter("birth");
        String gender = request.getParameter("gender");
        String userName = request.getParameter("userName");
        
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
        if (fullName == null || fullName.trim().isEmpty() ||
            email == null || email.trim().isEmpty() ||
            phone == null || phone.trim().isEmpty() ||
            userName == null || userName.trim().isEmpty()) {
            errorMessage = "Full name, email, phone, and username are required fields";
        } else if (!email.contains("@") || !email.contains(".")) {
            errorMessage = "Please enter a valid email address";
        }
        
        // If there are validation errors, redirect back with error message
        if (errorMessage != null) {
            request.getSession().setAttribute("profileError", errorMessage);
            response.sendRedirect(request.getContextPath() + "/customer/info");
            return;
        }
        
        try {
            // Parse birth date
            Date birthDate = null;
            if (birthDateStr != null && !birthDateStr.trim().isEmpty()) {
                try {
                    SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
                    java.util.Date parsed = dateFormat.parse(birthDateStr);
                    birthDate = new Date(parsed.getTime());
                } catch (ParseException e) {
                    errorMessage = "Invalid date format. Please use YYYY-MM-DD";
                    request.getSession().setAttribute("profileError", errorMessage);
                    response.sendRedirect(request.getContextPath() + "/customer/info");
                    return;
                }
            }
            
            // Connect to database
            DBContext dbContext = new DBContext();
            Connection conn = dbContext.getConnection();
            
            // Check if username already exists (and it's not the current user's username)
            if (!userName.equals(loggedInUser.getUserName())) {
                String checkSql = "SELECT COUNT(*) FROM Users WHERE user_name = ? AND id != ?";
                PreparedStatement checkStmt = conn.prepareStatement(checkSql);
                checkStmt.setString(1, userName);
                checkStmt.setInt(2, loggedInUser.getId());
                
                boolean usernameExists = false;
                var rs = checkStmt.executeQuery();
                if (rs.next()) {
                    usernameExists = rs.getInt(1) > 0;
                }
                
                if (usernameExists) {
                    errorMessage = "Username already exists. Please choose another one.";
                    request.getSession().setAttribute("profileError", errorMessage);
                    response.sendRedirect(request.getContextPath() + "/customer/info");
                    return;
                }
                
                checkStmt.close();
                rs.close();
            }
            
            // Update user profile in database
            String updateSql = "UPDATE Users SET user_name = ?, full_name = ?, birth = ?, gender = ?, email = ?, phone = ?, address = ? WHERE id = ?";
            PreparedStatement updateStmt = conn.prepareStatement(updateSql);
            updateStmt.setString(1, userName);
            updateStmt.setString(2, fullName);
            updateStmt.setDate(3, birthDate);
            updateStmt.setString(4, gender);
            updateStmt.setString(5, email);
            updateStmt.setString(6, phone);
            updateStmt.setString(7, address);
            updateStmt.setInt(8, loggedInUser.getId());
            
            int rowsAffected = updateStmt.executeUpdate();
            
            if (rowsAffected > 0) {
                // Profile updated successfully
                // Update session user
                loggedInUser.setUserName(userName);
                loggedInUser.setFullName(fullName);
                loggedInUser.setBirth(birthDate);
                loggedInUser.setGender(gender);
                loggedInUser.setEmail(email);
                loggedInUser.setPhone(phone);
                loggedInUser.setAddress(address);
                session.setAttribute("user", loggedInUser);
                
                // Set success message
                session.setAttribute("profileSuccess", "Profile updated successfully");
            } else {
                // Failed to update profile
                session.setAttribute("profileError", "Failed to update profile");
            }
            
            // Close resources
            updateStmt.close();
            conn.close();
            
        } catch (SQLException e) {
            // Database error
            session.setAttribute("profileError", "Database error: " + e.getMessage());
        }
        
        // Redirect back to profile page
        response.sendRedirect(request.getContextPath() + "/customer/info");
    }
}
