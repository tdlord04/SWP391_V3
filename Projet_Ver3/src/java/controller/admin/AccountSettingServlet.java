package controller.admin;

import dao.UserDAO;
import model.User;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

public class AccountSettingServlet extends HttpServlet {
    private UserDAO userDAO;
    
    public void init() {
        userDAO = new UserDAO();
    }
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        User loggedInUser = (User) session.getAttribute("user");
        
        System.out.println("AccountSettingServlet: doGet method called");
        
        if (loggedInUser == null) {
            System.out.println("AccountSettingServlet: No user in session, redirecting to login");
            // Redirect to login if not logged in
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }
        
        // Get fresh user data from database based on the logged-in user's ID
        User user = userDAO.getUserById(loggedInUser.getId());
        
        if (user != null) {
            // Set the retrieved user as a request attribute to be used by the JSP
            request.setAttribute("userInfo", user);
            request.setAttribute("updateSuccess", session.getAttribute("updateSuccess"));
            session.removeAttribute("updateSuccess"); // Clear the message after use
        } else {
            // If user not found in database, redirect to login
            System.out.println("AccountSettingServlet: Failed to retrieve user from database");
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }
        
        request.getRequestDispatcher("/admin/accountsettings.jsp").forward(request, response);
    }
    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        User loggedInUser = (User) session.getAttribute("user");
        
        if (loggedInUser == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }
        
        // Get current user data from database
        User user = userDAO.getUserById(loggedInUser.getId());
        
        if (user != null) {
            // Get the action parameter to determine which form was submitted
            String action = request.getParameter("action");
            
            if ("updateProfile".equals(action)) {
                // Handle profile information update
                handleProfileUpdate(request, response, session, user);
            } else if ("changePassword".equals(action)) {
                // Handle password change
                handlePasswordChange(request, response, session, user);
            } else {
                // Invalid action
                response.sendRedirect(request.getContextPath() + "/admin/accountsetting");
            }
        } else {
            response.sendRedirect(request.getContextPath() + "/login");
        }
    }
    
    private void handleProfileUpdate(HttpServletRequest request, HttpServletResponse response, 
            HttpSession session, User user) throws IOException {
        // Get updated values from form
        String fullName = request.getParameter("fullName");
        String email = request.getParameter("email");
        String phone = request.getParameter("phone");
        String address = request.getParameter("address");
        
        // Update user information
        user.setFullName(fullName);
        user.setEmail(email);
        user.setPhone(phone);
        user.setAddress(address);
        
        // Save updated user to database
        boolean updated = userDAO.updateUser(user);
        
        if (updated) {
            // Update session user information
            session.setAttribute("user", user);
            session.setAttribute("updateSuccess", "Profile updated successfully");
        } else {
            session.setAttribute("updateError", "Failed to update profile");
        }
        
        response.sendRedirect(request.getContextPath() + "/admin/accountsetting");
    }
    
    private void handlePasswordChange(HttpServletRequest request, HttpServletResponse response, 
            HttpSession session, User user) throws IOException {
        // Current password check and new password handling
        String currentPassword = request.getParameter("currentPassword");
        String newPassword = request.getParameter("newPassword");
        String confirmPassword = request.getParameter("confirmPassword");
        
        // Validate passwords
        if (currentPassword == null || currentPassword.isEmpty()) {
            session.setAttribute("passwordError", "Current password is required");
            response.sendRedirect(request.getContextPath() + "/admin/accountsetting");
            return;
        }
        
        if (!currentPassword.equals(user.getPassword())) {
            session.setAttribute("passwordError", "Current password is incorrect");
            response.sendRedirect(request.getContextPath() + "/admin/accountsetting");
            return;
        }
        
        if (newPassword == null || newPassword.isEmpty()) {
            session.setAttribute("passwordError", "New password is required");
            response.sendRedirect(request.getContextPath() + "/admin/accountsetting");
            return;
        }
        
        if (!newPassword.equals(confirmPassword)) {
            session.setAttribute("passwordError", "New password and confirmation do not match");
            response.sendRedirect(request.getContextPath() + "/admin/accountsetting");
            return;
        }
        
        // Update password
        user.setPassword(newPassword);
        
        // Save updated user to database
        boolean updated = userDAO.updateUser(user);
        
        if (updated) {
            // Update session user information
            session.setAttribute("user", user);
            session.setAttribute("updateSuccess", "Password changed successfully");
            // Clear any previous password errors
            session.removeAttribute("passwordError");
        } else {
            session.setAttribute("passwordError", "Failed to change password");
        }
        
        response.sendRedirect(request.getContextPath() + "/admin/accountsetting");
    }
}
