<%-- 
    Document   : roomDetail
    Created on : May 28, 2025, 8:00:30 PM
    Author     : ADMIN
--%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Room detail</title>
        <link rel="stylesheet" href="customer/customer.css" />
        <link rel="stylesheet" href="components/component.css" />
    </head>
    <body>
        <jsp:include page="components/header.jsp"/>
        <div class="room-detail-container">
            <div class="room-image">
                <img src="${room.imageUrl}" alt="Hình ảnh phòng ${room.roomNumber}" />
            </div>

            <div class="room-info">
                <h2>Phòng số: ${room.getRoomNumber()}</h2>
                <p><strong>Loại phòng:</strong> ${roomtype.getRoomtype()}</p>
                <p><strong>Giá phòng:</strong> ${room.getRoomPrice()} VND</p>
                <p><strong>Trạng thái:</strong> ${room.getRoomStatus()}</p>
                <p><strong>Sức chứa:</strong> ${room.getCapacity()} người</p>
                <p><strong>Mô tả:</strong> ${room.getDescription()}</p>
            </div>
        </div>
    </body>
</html>
