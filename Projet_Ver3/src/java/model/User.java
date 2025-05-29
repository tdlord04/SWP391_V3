/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;

/**
 *
 * @author ADMIN
 */
import java.util.Date; // Để sử dụng cho kiểu dữ liệu ngày sinh

public class User {
    private int id;
    private String userName;
    private String pass;
    private String fullName;
    private String password;  // Field for password
    private String gender;
    private String email;
    private String phone;
    private String address;
    private String role;
    private boolean isDeleted;
    private java.util.Date birth;  // Change birth to Date type

    // Constructor mặc định (có thể không cần nếu bạn luôn sử dụng constructor có đối số)
    public User() {
    }

    // Constructor đầy đủ đối số
    public User(int id, String userName, String pass, String fullName, java.util.Date birth, String gender,
                String email, String phone, String address, String role, boolean isDeleted) {
        this.id = id;
        this.userName = userName;
        this.pass = pass;
        this.fullName = fullName;
        this.birth = birth;
        this.gender = gender;
        this.email = email;
        this.phone = phone;
        this.address = address;
        this.role = role;
        this.isDeleted = isDeleted;
    }

    // --- Getters and Setters ---

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getUserName() {
        return userName;
    }

    public void setUserName(String userName) {
        this.userName = userName;
    }

    public String getPass() {
        return pass;
    }

    public void setPass(String pass) {
        this.pass = pass;
    }

    public String getFullName() {
        return fullName;
    }

    public void setFullName(String fullName) {
        this.fullName = fullName;
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    public java.util.Date getBirth() {
        return birth;
    }

    public void setBirth(java.util.Date birth) {
        this.birth = birth;
    }

    public String getGender() {
        return gender;
    }

    public void setGender(String gender) {
        this.gender = gender;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public String getPhone() {
        return phone;
    }

    public void setPhone(String phone) {
        this.phone = phone;
    }

    public String getAddress() {
        return address;
    }

    public void setAddress(String address) {
        this.address = address;
    }

    public String getRole() {
        return role;
    }

    public void setRole(String role) {
        this.role = role;
    }

    public boolean isDeleted() {
        return isDeleted;
    }

    public void setDeleted(boolean deleted) {
        isDeleted = deleted;
    }

    // Có thể thêm phương thức toString() để dễ dàng in ra đối tượng User
    @Override
    public String toString() {
        return "User{" +
               "id=" + id +
               ", userName='" + userName + '\'' +
               ", fullName='" + fullName + '\'' +
               ", birth=" + birth +
               ", gender='" + gender + '\'' +
               ", email='" + email + '\'' +
               ", phone='" + phone + '\'' +
               ", address='" + address + '\'' +
               ", role='" + role + '\'' +
               ", isDeleted=" + isDeleted +
               '}';
    }
}