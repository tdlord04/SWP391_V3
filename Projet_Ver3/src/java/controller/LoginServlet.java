/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller;

import dao.UserDAO;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.Cookie;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import model.User;

/**
 *
 * @author ADMIN
 */
public class LoginServlet extends HttpServlet {

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            /* TODO output your page here. You may use following sample code. */
            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Servlet LoginServlet</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet LoginServlet at " + request.getContextPath() + "</h1>");
            out.println("</body>");
            out.println("</html>");
        }
    }

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

    }

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String stringlog = request.getParameter("stringlog");
        String password = request.getParameter("password");

        UserDAO userdao = new UserDAO();
        User user;
<<<<<<< Updated upstream
        if (method.equalsIgnoreCase("1")) {
            String remenberMe = request.getParameter("rememberMe");
            if (stringlog != null && !stringlog.trim().isEmpty()) {
                stringlog = stringlog.trim();
                if (stringlog.contains("@")) {
                    user = userdao.loginByEmail(stringlog, password);
                } else {
                    user = userdao.loginByUsername(stringlog, password);
                }
                if (user != null) {
                    HttpSession session = request.getSession();
                    Cookie username = new Cookie("username", user.getUserName());
                    Cookie pass = new Cookie("pass", user.getPassword());
                    if (remenberMe != null) {
                        username.setMaxAge(60 * 60 * 24 * 3);
                        pass.setMaxAge(60 * 60 * 24 * 3);
                        response.addCookie(username);
                        response.addCookie(pass);
                    } else {
                        username.setMaxAge(-1);
                    }
                    session.setAttribute("user", user);
                    response.sendRedirect("home");
                } else {
                    String mess = "Sai mail/tên đăng nhập hoặc mật khẩu!";
                    request.setAttribute("mess", mess);
                    request.getRequestDispatcher("login.jsp").forward(request, response);
                }

=======
        if (!stringlog.isEmpty()) {
            String mess = "";
            if (stringlog.contains("@")) {
                mess = "Sai email đăng nhập";
                user = userdao.loginByEmail(stringlog, password);
            } else if (stringlog.matches("\\d+")) {
                mess = "Sai số điện thoại";
                user = userdao.loginByPhone(stringlog, password);
            } else {
                mess = "Sai tên đăng nhập";
                user = userdao.loginByUsername(stringlog, password);
            }

            if (user != null) {
                HttpSession session = request.getSession();
                session.setAttribute("user", user);
                response.sendRedirect("home");
>>>>>>> Stashed changes
            } else {
                request.setAttribute("mess", mess);
                request.getRequestDispatcher("login.jsp").forward(request, response);
            }
        } else {
<<<<<<< Updated upstream
            String remenberMe = request.getParameter("rememberMe");
            if (stringlog != null && !stringlog.trim().isEmpty()) {
                stringlog = stringlog.trim();
                if (stringlog.matches("\\d+")) {
                    user = userdao.loginByPhone(stringlog, password);
                    if (user != null) {
                        HttpSession session = request.getSession();
                        Cookie username = new Cookie("username", user.getUserName());
                        Cookie pass = new Cookie("pass", user.getPassword());
                        if (remenberMe != null) {
                            username.setMaxAge(60 * 60 * 24 * 3);
                            pass.setMaxAge(60 * 60 * 24 * 3);
                            response.addCookie(username);
                            response.addCookie(pass);
                        } else {
                            username.setMaxAge(-1);
                        }
                        session.setAttribute("user", user);
                        response.sendRedirect("home");
                    } else {
                        String mess = "Sai số điện thoại hoặc mật khẩu!";
                        request.setAttribute("mess2", mess);
                        request.getRequestDispatcher("login.jsp").forward(request, response);
                    }
                } else {
                    String mess = "Sai số điện thoại!";
                    request.setAttribute("mess2", mess);
                    request.getRequestDispatcher("login.jsp").forward(request, response);
                }
            } else {
                String mess = "Không được để trống số điện thoại và mật khẩu!";
                request.setAttribute("mess2", mess);
                request.getRequestDispatcher("login.jsp").forward(request, response);
                return;
            }
=======
            String mess = "Không được để trống số điện thoại và mật khẩu!";
            request.setAttribute("mess2", mess);
            request.getRequestDispatcher("login.jsp").forward(request, response);
>>>>>>> Stashed changes
        }
    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
