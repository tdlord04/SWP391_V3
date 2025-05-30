<%-- 
    Document   : home
    Created on : May 22, 2025, 3:28:03 PM
    Author     : ADMIN
--%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Home</title>
        <link rel="stylesheet" href="customer/customer.css" />
        <link rel="stylesheet" href="components/component.css" />
    </head>
    <body>
        <jsp:include page="components/header.jsp"/>
        
        
        <main>
            <div class="room-list">
                <c:forEach var="room" items="${roomlist}">
                    <div class="room-card">
                        <img src="${room.getImageUrl()}" alt="Room Image">
                        <h5>Phòng ${room.getRoomNumber()}</h5>
                        <h5>
                            Loại phòng:
                            <c:forEach var="type" items="${requestScope.roomtypes}">
                                <c:if test="${type.getId() == room.getRoomType()}">${type.getRoomType()}</c:if>
                            </c:forEach>
                        </h5>
                        <p style="color: red"><strong>Giá:</strong> ${room.getRoomPrice()} VND</p>
                        <p><strong>Sức chứa:</strong> ${room.getCapacity()} người</p>
                        <c:choose>
                            <c:when test="${fn:length(room.getDescription()) > 50}">
                                <p>${fn:substring(room.getDescription(), 0, 50)}...</p>
                            </c:when>
                            <c:otherwise>
                                <p>${room.getDescription()}</p>
                            </c:otherwise>
                        </c:choose>

                        <a href="roomdetail?id=${room.getId()}" class="view-detail-btn">Xem chi tiết</a>
                    </div>
                </c:forEach>
            </div>
        </main>
    </body>
</html>
