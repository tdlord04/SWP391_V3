/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dao;

import dal.DBContext;
import java.sql.Connection;
import java.util.ArrayList;
import java.util.List;
import model.RoomType;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

/**
 *
 * @author ADMIN
 */
public class RoomTypeDAO {

    private Connection getConnection() throws SQLException {
        DBContext dbContext = new DBContext();
        // Kiểm tra xem kết nối có null không trước khi trả về
        if (dbContext.connection == null) {
            throw new SQLException("Failed to establish database connection through DBContext.");
        }
        return dbContext.connection;
    }

    public List<RoomType> getAll() {
        List<RoomType> list = new ArrayList<>();
        String SQL_SELECT_ALL = "SELECT id,room_type FROM RoomTypes";
        Connection conn;
        PreparedStatement pstmt;
        ResultSet rs;
        try {
            conn = getConnection();
            pstmt = conn.prepareStatement(SQL_SELECT_ALL);
            rs = pstmt.executeQuery();
            while(rs.next()){
                RoomType roomtype = new RoomType();
                roomtype.setId(rs.getInt("id"));
                roomtype.setRoomType(rs.getNString("room_type"));
                list.add(roomtype);
            }
        } catch (SQLException e) {
            System.err.println("Error get all room type: " + e.getMessage());
            e.printStackTrace();
        }
        return list;
    }
    
    public RoomType getRoomTypeById(int id){
        String SQL_SELECT = "SELECT id,room_type FROM RoomTypes WHERE id = ?";
        Connection conn;
        PreparedStatement pstmt;
        ResultSet rs;
        RoomType roomtype = new RoomType();
        try {
            conn = getConnection();
            pstmt = conn.prepareStatement(SQL_SELECT);
            pstmt.setInt(1, id);
            rs = pstmt.executeQuery();
            while(rs.next()){
                roomtype.setId(rs.getInt("id"));
                roomtype.setRoomType(rs.getNString("room_type"));
            }
        } catch (SQLException e) {
            System.err.println("Error get all room type: " + e.getMessage());
            e.printStackTrace();
        }
        return roomtype;
    }
    
    public static void main(String[] args) {
        RoomTypeDAO dao = new RoomTypeDAO();
        List<RoomType> list = dao.getAll();
        for (RoomType roomType : list) {
            System.out.println(roomType);
        }
        
        System.out.println(dao.getRoomTypeById(1));
    }
}
