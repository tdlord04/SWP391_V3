<%@ page language="java" contentType="text/html; charset=UTF-8"
pageEncoding="UTF-8" %> <%@ taglib uri="http://java.sun.com/jsp/jstl/core"
prefix="c" %>

<c:set
  var="isReportActive"
  value="${param.activePage == 'purchasereport' || param.activePage == 'stockreport' || param.activePage == 'bookingreport'}"
/>
<style>
.sidebar-menu .list-group {
  display: flex;
  flex-direction: column;
  gap: 8px; /* Khoảng cách đều nhau giữa từng mục */
}

.sidebar-menu h6.menu-heading {
  margin: 20px 15px 10px 15px;
  font-weight: 600;
}

</style>

<div class="sidebar-wrapper" id="sidebar-wrapper">
  <div class="sidebar-menu">
    <div class="list-group list-group-flush">
      <a
        href="dashboard.jsp"
        class="list-group-item list-group-item-action py-3 ${param.activePage == 'dashboard' ? 'active' : ''}"
      >
        <i class="fas fa-tachometer-alt me-2"></i> Dashboard
      </a>
      <a
        href="customerList.jsp"
        class="list-group-item list-group-item-action py-3 ${param.activePage == 'users' ? 'active' : ''}"
      >
        <i class="fas fa-hotel me-2"></i> Manage Customer
      </a>
      <a
        href="bookingsList.jsp"
        class="list-group-item list-group-item-action py-3 ${param.activePage == 'bookings' ? 'active' : ''}"
      >
        <i class="fas fa-calendar-check me-2"></i> Manage Bookings
      </a>
       <a
        href="promotionsList.jsp"
        class="list-group-item list-group-item-action py-3 ${param.activePage == 'promotion' ? 'active' : ''}"
      >
        <i class="fas fa-calendar-check me-2"></i> Manage Promotion      
       </a>


    </div>

    <div class="list-group list-group-flush">
      <a
        href="roomlist.jsp"
        class="list-group-item list-group-item-action py-3 ${param.activePage == 'roomlist' ? 'active' : ''}"
      >
        <i class="fas fa-list me-2"></i> Room List
      </a>
    </div>

    <!-- Account & System Section -->
    <div class="list-group list-group-flush">
      <a
        href="account-settings.jsp"
        class="list-group-item list-group-item-action py-3 ${param.activePage == 'account-settings' ? 'active' : ''}"
      >
        <i class="fas fa-user-cog me-2"></i> Account Settings
      </a>
      <a
        href="${pageContext.request.contextPath}/admin/logout"
        class="list-group-item list-group-item-action py-3 text-danger"
        onclick="return confirm('Are you sure you want to logout?')"
      >
        <i class="fas fa-sign-out-alt me-2"></i> Logout
      </a>
    </div>
  </div>
</div>

