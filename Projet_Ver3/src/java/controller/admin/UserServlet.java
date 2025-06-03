package controller.admin;

import dao.UserDAO;
import model.User;
import java.io.IOException;
import java.util.List;
import java.util.ArrayList;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

public class UserServlet extends HttpServlet {
    private UserDAO userDAO;
    
    public void init() {
        userDAO = new UserDAO();
    }
    
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        List<User> users = userDAO.getAllUsers();
        if (users != null) {
            System.out.println("Fetched " + users.size() + " users from database.");  // Debug log
            request.setAttribute("users", users);
        } else {
            System.out.println("No users fetched or error occurred.");  // Debug log for empty or null list
            request.setAttribute("users", new ArrayList<>());  // Set empty list to avoid null errors
        }
        request.getRequestDispatcher("/admin/users.jsp").forward(request, response);
    }
    
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        doGet(request, response);
    }
}
