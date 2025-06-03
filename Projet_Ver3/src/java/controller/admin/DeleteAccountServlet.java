package controller.admin;

import dao.UserDAO;
import model.User;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

/**
 * Servlet for handling account deletion
 */
public class DeleteAccountServlet extends HttpServlet {
    private UserDAO userDAO;
    
    public void init() {
        userDAO = new UserDAO();
    }
    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        User loggedInUser = (User) session.getAttribute("user");
        
        // Check if user is logged in
        if (loggedInUser == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }
        
        int userId = loggedInUser.getId();
        boolean deleted = userDAO.softDeleteUser(userId);
        
        if (deleted) {
            // Invalidate the session
            session.invalidate();
            // Send success response
            response.setContentType("application/json");
            response.getWriter().write("{\"success\": true, \"message\": \"Account deleted successfully\", \"redirect\": \"/admin/deleteaccount.jsp\"}");
        } else {
            // Send error response
            response.setContentType("application/json");
            response.getWriter().write("{\"success\": false, \"message\": \"Failed to delete account\"}");
        }
    }
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        // Redirect GET requests to POST
        response.sendRedirect(request.getContextPath() + "/admin/accountsetting");
    }
}
