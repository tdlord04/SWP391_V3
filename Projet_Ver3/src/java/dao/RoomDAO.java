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

    public static void main(String[] args) {
        RoomDAO dao = new RoomDAO();
        List<Room> list = dao.getAllRoom();
        for (Room room : list) {
            System.out.println(room);
        }
        
        System.out.println(dao.getRoomById(1));
    }
}
