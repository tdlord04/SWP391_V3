package controller.admin;

import dao.RoomDAO;
import dao.RoomTypeDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;
import model.Room;
import model.RoomType;

@WebServlet(name = "RoomListServlet", urlPatterns = {"/admin/roomlist"})
public class RoomListServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        // Get search and filter parameters
        String searchQuery = request.getParameter("search");
        String roomTypeFilter = request.getParameter("roomType");
        String statusFilter = request.getParameter("status");
        String sortBy = request.getParameter("sortBy"); // For sorting functionality
        String capacityParam = request.getParameter("capacity");
        Integer capacityFilter = null;
        if (capacityParam != null && !capacityParam.trim().isEmpty() && !capacityParam.equals("all")) {
            try {
                capacityFilter = Integer.parseInt(capacityParam);
            } catch (NumberFormatException e) {
                // ignore invalid
            }
        }
        
        // Get pagination parameters
        int pageSize = 10; // Default page size
        int currentPage = 1; // Default to first page
        
        // Parse page parameter if provided
        String pageParam = request.getParameter("page");
        if (pageParam != null && !pageParam.trim().isEmpty()) {
            try {
                currentPage = Integer.parseInt(pageParam);
                if (currentPage < 1) {
                    currentPage = 1; // Ensure page is at least 1
                }
            } catch (NumberFormatException e) {
                // Invalid page number, use default
                currentPage = 1;
            }
        }
        
        // Get all rooms and room types
        RoomDAO roomDAO = new RoomDAO();
        RoomTypeDAO roomTypeDAO = new RoomTypeDAO();
        
        List<Room> allRooms;
        List<RoomType> roomTypes = roomTypeDAO.getAll();
        
        // Convert roomTypeFilter to integer if provided
        Integer roomTypeId = null;
        if (roomTypeFilter != null && !roomTypeFilter.trim().isEmpty() && !roomTypeFilter.equals("all")) {
            try {
                roomTypeId = Integer.parseInt(roomTypeFilter);
            } catch (NumberFormatException e) {
                // Invalid room type ID format, ignore the filter
            }
        }
        
        // Get total room count for pagination
        int totalRooms = roomDAO.countFilteredRooms(searchQuery, roomTypeId, statusFilter, capacityFilter);
        int totalPages = (int) Math.ceil((double) totalRooms / pageSize);
        
        // Ensure current page is within valid range
        if (currentPage > totalPages && totalPages > 0) {
            currentPage = totalPages;
        }
        
        // Apply filters and pagination
        if (searchQuery != null && !searchQuery.trim().isEmpty() ||
            roomTypeId != null ||
            statusFilter != null && !statusFilter.trim().isEmpty() && !statusFilter.equals("all") ||
            capacityFilter != null) {
            // Get filtered and paginated rooms
            allRooms = roomDAO.getFilteredRooms(searchQuery, roomTypeId, statusFilter, capacityFilter, sortBy, currentPage, pageSize);
        } else {
            // Get all rooms with pagination if no filters
            allRooms = roomDAO.getRoomsPage(currentPage, pageSize);
        }
        
        // Apply sorting if requested
        if (sortBy != null && !sortBy.trim().isEmpty()) {
            switch (sortBy) {
                case "roomNumber":  // Can implement various sort options
                case "price":  
                case "capacity":
                case "status":
                    // We would implement sorting here or in the DAO
                    // For now, we'll just set the sort parameter
                    request.setAttribute("sortBy", sortBy);
                    break;
            }
        }
        
        // Calculate room statistics for current page
        int displayedRooms = allRooms.size();
        int availableRooms = 0;
        int occupiedRooms = 0;
        int maintenanceRooms = 0;
        
        // Count status statistics from current page rooms
        for (Room room : allRooms) {
            String status = room.getRoomStatus();
            if (status != null) {
                if (status.equalsIgnoreCase("Khả dụng") || status.equalsIgnoreCase("Available")) {
                    availableRooms++;
                } else if (status.equalsIgnoreCase("Đang sử sụng") || status.equalsIgnoreCase("Occupied")) {
                    occupiedRooms++;
                } else if (status.equalsIgnoreCase("Bảo trì") || status.equalsIgnoreCase("Maintenance")) {
                    maintenanceRooms++;
                }
            }
        }
        
        // Set attributes for JSP
        request.setAttribute("rooms", allRooms);
        request.setAttribute("roomTypes", roomTypes);
        request.setAttribute("totalRoomCount", totalRooms); // Total count of all matching rooms
        request.setAttribute("displayedRooms", displayedRooms); // Count of rooms on current page
        request.setAttribute("availableRooms", availableRooms);
        request.setAttribute("occupiedRooms", occupiedRooms);
        request.setAttribute("maintenanceRooms", maintenanceRooms);
        
        // Set pagination attributes
        request.setAttribute("currentPage", currentPage);
        request.setAttribute("totalPages", totalPages);
        request.setAttribute("pageSize", pageSize);
        
        // Set search parameters for form persistence
        request.setAttribute("searchQuery", searchQuery);
        request.setAttribute("roomTypeFilter", roomTypeFilter);
        request.setAttribute("statusFilter", statusFilter);
        request.setAttribute("capacityFilter", capacityParam);
        request.setAttribute("sortBy", sortBy);
        
        // Check for messages from other servlets (like delete confirmation)
        HttpSession session = request.getSession();
        String message = (String) session.getAttribute("message");
        String messageType = (String) session.getAttribute("messageType");
        
        if (message != null && !message.isEmpty()) {
            request.setAttribute("message", message);
            request.setAttribute("messageType", messageType);
            // Clear the session attributes after retrieving them
            session.removeAttribute("message");
            session.removeAttribute("messageType");
        }
        
        // Forward to the JSP page
        request.getRequestDispatcher("/admin/roomlist.jsp").forward(request, response);
    }
    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // Handle POST requests (for search/filter form submission)
        doGet(request, response);
    }
}
