/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */

package controller.admin;

import dao.PromotionDao;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.logging.Level;
import java.util.logging.Logger;
import model.Promotion;

/**
 *
 * @author Phạm Quốc Tuấn
 */
@WebServlet(name="updatePromotion", urlPatterns={"/updatePromotion"})
public class updatePromotion extends HttpServlet {
   
    /** 
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code> methods.
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
            out.println("<title>Servlet updatePromotion</title>");  
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet updatePromotion at " + request.getContextPath () + "</h1>");
            out.println("</body>");
            out.println("</html>");
        }
    } 

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /** 
     * Handles the HTTP <code>GET</code> method.
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException {
        processRequest(request, response);
    } 

    /** 
     * Handles the HTTP <code>POST</code> method.
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException {
        PromotionDao dao = new PromotionDao();
        request.setCharacterEncoding("UTF-8"); // đảm bảo nhận đúng ký tự Unicode

        String idStr = request.getParameter("id");
        String title = request.getParameter("title");
        String percentageStr = request.getParameter("percentage");
        String startAtStr = request.getParameter("start_at");
        String endAtStr = request.getParameter("end_at");
        String description = request.getParameter("description");

        try {
            int id = Integer.parseInt(idStr);
            double percentage = Double.parseDouble(percentageStr);

            SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
            Date startAt = sdf.parse(startAtStr);
            Date endAt = sdf.parse(endAtStr);

            Promotion promotion = new Promotion();
            promotion.setId(id);
            promotion.setTitle(title);
            promotion.setPercentage(percentage);
            promotion.setStartAt(startAt);
            promotion.setEndAt(endAt);
            promotion.setDescription(description);

            boolean success = dao.updatePromotion(promotion);

            if (success) {
                // Cập nhật thành công, chuyển về trang danh sách promotions
                response.sendRedirect(request.getContextPath() + "/promotionList");
            } else {
                request.setAttribute("error", "Failed to update promotion.");
                request.getRequestDispatcher("/admin/promotionsList.jsp").forward(request, response);
            }

        } catch (NumberFormatException | ParseException e) {
            e.printStackTrace();
            request.setAttribute("error", "Invalid input format.");
            request.getRequestDispatcher("/admin/promotionsList.jsp").forward(request, response);
        }
    }
    

    /** 
     * Returns a short description of the servlet.
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
