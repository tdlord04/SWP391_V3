/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dao;

import dal.DBContext;
import java.sql.Connection;
import java.util.ArrayList;
import java.util.List;
import model.Room;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.LinkedList;

/**
 *
 * @author ADMIN
 */
public class RoomDAO {

    public List<Room> getAllRoom() {
        List<Room> list = new LinkedList<>();
        String SQL_SELECT_ALL = "SELECT * FROM Rooms WHERE isDelete = 0";
        DBContext dbcontext = new DBContext();
        PreparedStatement pstmt;
        ResultSet rs;
        try {
            Connection conn = dbcontext.getConnection();
            pstmt = conn.prepareStatement(SQL_SELECT_ALL);
            rs = pstmt.executeQuery();
            while (rs.next()) {
                Room room = new Room();
                room.setId(rs.getInt("id"));
                room.setRoomNumber(rs.getNString("room_number"));
                room.setRoomTypeId(rs.getInt("room_type_id"));
                room.setRoomPrice(rs.getDouble("room_price"));
                room.setRoomStatus(rs.getNString("room_status"));
                room.setCapacity(rs.getInt("capacity"));
                room.setDescription(rs.getNString("description"));
                room.setImageUrl(rs.getNString("image_url"));
                room.setIsDelete(rs.getBoolean("isDelete"));
                list.add(room);
            }
        } catch (SQLException e) {
            System.err.println("Error get all room type: " + e.getMessage());
            e.printStackTrace();
        }
        return list;
    }

    public Room getRoomById(int id) {
        String SQL_SELECT = "SELECT * FROM Rooms WHERE id = ?";
        DBContext dbcontext = new DBContext();
        PreparedStatement pstmt;
        ResultSet rs;
        Room room = new Room();
        try {
            Connection conn = dbcontext.getConnection();
            pstmt = conn.prepareStatement(SQL_SELECT);
            pstmt.setInt(1, id);
            rs = pstmt.executeQuery();
            while (rs.next()) {
                room.setId(rs.getInt("id"));
                room.setRoomNumber(rs.getNString("room_number"));
                room.setRoomTypeId(rs.getInt("room_type_id"));
                room.setRoomPrice(rs.getDouble("room_price"));
                room.setRoomStatus(rs.getNString("room_status"));
                room.setCapacity(rs.getInt("capacity"));
                room.setDescription(rs.getNString("description"));
                room.setImageUrl(rs.getNString("image_url"));
                room.setIsDelete(rs.getBoolean("isDelete"));
            }
        } catch (SQLException e) {
            System.err.println("Error get all room type: " + e.getMessage());
            e.printStackTrace();
        }
        return room;
    }

    /**
     * Soft deletes a room by setting its isDelete flag to true
     * @param roomId the ID of the room to delete
     * @return true if the deletion was successful, false otherwise
     */
    public boolean deleteRoom(int roomId) {
        String SQL_UPDATE = "UPDATE Rooms SET isDelete = 1 WHERE id = ?";
        DBContext dbcontext = new DBContext();
        PreparedStatement pstmt;
        int rowsAffected = 0;
        
        try {
            Connection conn = dbcontext.getConnection();
            pstmt = conn.prepareStatement(SQL_UPDATE);
            pstmt.setInt(1, roomId);
            rowsAffected = pstmt.executeUpdate();
            
            // Close resources
            pstmt.close();
            conn.close();
        } catch (SQLException e) {
            System.err.println("Error deleting room: " + e.getMessage());
            e.printStackTrace();
            return false;
        }
        
        return rowsAffected > 0;
    }
    
    /**
     * Adds a new room to the database
     * @param room The Room object containing all room data
     * @return true if the room was added successfully, false otherwise
     */
    public boolean addRoom(Room room) {
        String SQL_INSERT = "INSERT INTO Rooms (room_number, room_type_id, room_price, room_status, capacity, description, image_url, isDelete) "
                          + "VALUES (?, ?, ?, ?, ?, ?, ?, ?)";
        DBContext dbcontext = new DBContext();
        PreparedStatement pstmt;
        int rowsAffected = 0;
        
        try {
            Connection conn = dbcontext.getConnection();
            pstmt = conn.prepareStatement(SQL_INSERT);
            pstmt.setString(1, room.getRoomNumber());
            pstmt.setInt(2, room.getRoomTypeId());
            pstmt.setDouble(3, room.getRoomPrice());
            pstmt.setString(4, room.getRoomStatus());
            pstmt.setInt(5, room.getCapacity());
            pstmt.setString(6, room.getDescription());
            pstmt.setString(7, room.getImageUrl());
            pstmt.setBoolean(8, room.isIsDelete());
            
            rowsAffected = pstmt.executeUpdate();
            
            // Close resources
            pstmt.close();
            conn.close();
        } catch (SQLException e) {
            System.err.println("Error adding room: " + e.getMessage());
            e.printStackTrace();
            return false;
        }
        
        return rowsAffected > 0;
    }
    
    /**
     * Updates an existing room in the database
     * @param room The Room object containing updated room data
     * @return true if the room was updated successfully, false otherwise
     */
    public boolean updateRoom(Room room) {
        String SQL_UPDATE = "UPDATE Rooms SET room_number=?, room_type_id=?, room_price=?, "
                          + "room_status=?, capacity=?, description=?, image_url=? WHERE id=?";
        DBContext dbcontext = new DBContext();
        PreparedStatement pstmt;
        int rowsAffected = 0;
        
        try {
            Connection conn = dbcontext.getConnection();
            pstmt = conn.prepareStatement(SQL_UPDATE);
            pstmt.setString(1, room.getRoomNumber());
            pstmt.setInt(2, room.getRoomTypeId());
            pstmt.setDouble(3, room.getRoomPrice());
            pstmt.setString(4, room.getRoomStatus());
            pstmt.setInt(5, room.getCapacity());
            pstmt.setString(6, room.getDescription());
            pstmt.setString(7, room.getImageUrl());
            pstmt.setInt(8, room.getId());
            
            rowsAffected = pstmt.executeUpdate();
            
            // Close resources
            pstmt.close();
            conn.close();
        } catch (SQLException e) {
            System.err.println("Error updating room: " + e.getMessage());
            e.printStackTrace();
            return false;
        }
        
        return rowsAffected > 0;
    }
    
    /**
     * Get filtered rooms based on search parameters with optional sorting and pagination
     * @param searchQuery Text to search in room number and description
     * @param roomTypeId Filter by specific room type ID (null for all types)
     * @param statusFilter Filter by room status (null or empty for all statuses)
     * @param capacityFilter Filter by room capacity (null for all capacities)
     * @param sortBy Field to sort by (roomNumber, price, capacity, status)
     * @param page Current page number (1-based)
     * @param pageSize Number of items per page
     * @return List of rooms matching the filter criteria for the specified page
     */
    public List<Room> getFilteredRooms(String searchQuery, Integer roomTypeId, String statusFilter, Integer capacityFilter, String sortBy, int page, int pageSize) {
        List<Room> filteredRooms = new ArrayList<>();
        StringBuilder sqlBuilder = new StringBuilder("SELECT * FROM Rooms WHERE isDelete = 0");
        List<Object> parameters = new ArrayList<>();
        
        // Add search query condition
        if (searchQuery != null && !searchQuery.trim().isEmpty()) {
            sqlBuilder.append(" AND (room_number LIKE ? OR description LIKE ?)");
            String searchPattern = "%" + searchQuery.trim() + "%";
            parameters.add(searchPattern);
            parameters.add(searchPattern);
        }
        
        // Add room type filter
        if (roomTypeId != null) {
            sqlBuilder.append(" AND room_type_id = ?");
            parameters.add(roomTypeId);
        }
        
        // Add status filter
        if (statusFilter != null && !statusFilter.trim().isEmpty() && !statusFilter.equals("all")) {
            sqlBuilder.append(" AND room_status = ?");
            parameters.add(statusFilter);
        }
        
        // Add capacity filter
        if (capacityFilter != null) {
            sqlBuilder.append(" AND capacity = ?");
            parameters.add(capacityFilter);
        }
        
        // Add sorting
        if (sortBy != null && !sortBy.trim().isEmpty()) {
            switch(sortBy) {
                case "roomNumber":
                    sqlBuilder.append(" ORDER BY room_number ASC");
                    break;
                case "price":
                    sqlBuilder.append(" ORDER BY room_price ASC");
                    break;
                case "capacity":
                    sqlBuilder.append(" ORDER BY capacity ASC");
                    break;
                case "status":
                    sqlBuilder.append(" ORDER BY room_status ASC");
                    break;
                default:
                    // Default sort by room number
                    sqlBuilder.append(" ORDER BY room_number ASC");
            }
        } else {
            // Default sort by id
            sqlBuilder.append(" ORDER BY id ASC");
        }
        
        // Add pagination
        int offset = (page - 1) * pageSize;
        sqlBuilder.append(" OFFSET ? ROWS FETCH NEXT ? ROWS ONLY");
        parameters.add(offset);
        parameters.add(pageSize);
        
        DBContext dbcontext = new DBContext();
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        
        try {
            Connection conn = dbcontext.getConnection();
            pstmt = conn.prepareStatement(sqlBuilder.toString());
            
            // Set prepared statement parameters
            for (int i = 0; i < parameters.size(); i++) {
                Object param = parameters.get(i);
                if (param instanceof String) {
                    pstmt.setString(i + 1, (String) param);
                } else if (param instanceof Integer) {
                    pstmt.setInt(i + 1, (Integer) param);
                }
            }
            
            rs = pstmt.executeQuery();
            
            while (rs.next()) {
                Room room = new Room();
                room.setId(rs.getInt("id"));
                room.setRoomNumber(rs.getNString("room_number"));
                room.setRoomTypeId(rs.getInt("room_type_id"));
                room.setRoomPrice(rs.getDouble("room_price"));
                room.setRoomStatus(rs.getNString("room_status"));
                room.setCapacity(rs.getInt("capacity"));
                room.setDescription(rs.getNString("description"));
                room.setImageUrl(rs.getNString("image_url"));
                room.setIsDelete(rs.getBoolean("isDelete"));
                filteredRooms.add(room);
            }
            
            // Close resources
            rs.close();
            pstmt.close();
            conn.close();
        } catch (SQLException e) {
            System.err.println("Error getting filtered rooms: " + e.getMessage());
            e.printStackTrace();
        }
        
        return filteredRooms;
    }
    
    /**
     * Count total number of rooms matching filter criteria for pagination
     * @param searchQuery Text to search in room number and description
     * @param roomTypeId Filter by specific room type ID (null for all types)
     * @param statusFilter Filter by room status (null or empty for all statuses)
     * @param capacityFilter Filter by room capacity (null for all capacities)
     * @return Total count of rooms matching the criteria
     */
    public int countFilteredRooms(String searchQuery, Integer roomTypeId, String statusFilter, Integer capacityFilter) {
        StringBuilder sqlBuilder = new StringBuilder("SELECT COUNT(*) FROM Rooms WHERE isDelete = 0");
        List<Object> parameters = new ArrayList<>();
        
        // Add search query condition
        if (searchQuery != null && !searchQuery.trim().isEmpty()) {
            sqlBuilder.append(" AND (room_number LIKE ? OR description LIKE ?)");
            String searchPattern = "%" + searchQuery.trim() + "%";
            parameters.add(searchPattern);
            parameters.add(searchPattern);
        }
        
        // Add room type filter
        if (roomTypeId != null) {
            sqlBuilder.append(" AND room_type_id = ?");
            parameters.add(roomTypeId);
        }
        
        // Add status filter
        if (statusFilter != null && !statusFilter.trim().isEmpty() && !statusFilter.equals("all")) {
            sqlBuilder.append(" AND room_status = ?");
            parameters.add(statusFilter);
        }
        
        // Add capacity filter
        if (capacityFilter != null) {
            sqlBuilder.append(" AND capacity = ?");
            parameters.add(capacityFilter);
        }
        
        DBContext dbcontext = new DBContext();
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        int count = 0;
        
        try {
            Connection conn = dbcontext.getConnection();
            pstmt = conn.prepareStatement(sqlBuilder.toString());
            
            // Set prepared statement parameters
            for (int i = 0; i < parameters.size(); i++) {
                Object param = parameters.get(i);
                if (param instanceof String) {
                    pstmt.setString(i + 1, (String) param);
                } else if (param instanceof Integer) {
                    pstmt.setInt(i + 1, (Integer) param);
                }
            }
            
            rs = pstmt.executeQuery();
            
            if (rs.next()) {
                count = rs.getInt(1);
            }
            
            // Close resources
            rs.close();
            pstmt.close();
            conn.close();
        } catch (SQLException e) {
            System.err.println("Error counting filtered rooms: " + e.getMessage());
            e.printStackTrace();
        }
        
        return count;
    }
    
    /**
     * Get a specific page of rooms without filters (helper method)
     * @param page Current page number (1-based)
     * @param pageSize Number of items per page
     * @return List of rooms for the specified page
     */
    public List<Room> getRoomsPage(int page, int pageSize) {
        return getFilteredRooms(null, null, null, null, null, page, pageSize);
    }
    
    public static void main(String[] args) {
        RoomDAO dao = new RoomDAO();
        List<Room> list = dao.getAllRoom();
        for (Room x : list) {
            System.out.println(x);
        }
        
        System.out.println(dao.getRoomById(1));
    }
}
