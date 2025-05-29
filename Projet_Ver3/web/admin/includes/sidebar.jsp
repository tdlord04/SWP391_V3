<%@ page language="java" contentType="text/html; charset=UTF-8"
pageEncoding="UTF-8" %> <%@ taglib uri="http://java.sun.com/jsp/jstl/core"
prefix="c" %>

<c:set
  var="isReportActive"
  value="${param.activePage == 'purchasereport' || param.activePage == 'stockreport' || param.activePage == 'bookingreport'}"
/>

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
        href="${pageContext.request.contextPath}/users"
        class="list-group-item list-group-item-action py-3 ${param.activePage == 'users' ? 'active' : ''}"
      >
        <i class="fas fa-hotel me-2"></i> Users
      </a>
      <a
        href="bookings.jsp"
        class="list-group-item list-group-item-action py-3 ${param.activePage == 'bookings' ? 'active' : ''}"
      >
        <i class="fas fa-calendar-check me-2"></i> Manage Bookings
      </a>
      <a
        href="#"
        class="list-group-item list-group-item-action py-3 ${isReportActive ? 'active' : ''}"
        data-bs-toggle="collapse"
        data-bs-target="#roomBookSubmenu"
        aria-expanded="${isReportActive ? 'true' : 'false'}"
      >
        <i class="fas fa-book me-2"></i> Reports & Analytics
        <i class="fas fa-chevron-down ms-auto"></i>
      </a>
      <div
        class="collapse ${isReportActive ? 'show' : ''}"
        id="roomBookSubmenu"
      >
        <div class="list-group list-group-flush ps-4">
          <a
            href="purchasereport.jsp"
            class="list-group-item list-group-item-action py-2 ${param.activePage == 'purchasereport' ? 'active' : ''}"
          >
            <i class="fas fa-shopping-cart me-2"></i> Purchase Reports
          </a>
          <a
            href="stockreport.jsp"
            class="list-group-item list-group-item-action py-2 ${param.activePage == 'stockreport' ? 'active' : ''}"
          >
            <i class="fas fa-boxes me-2"></i> Stock Reports
          </a>
          <a
            href="bookingreport.jsp"
            class="list-group-item list-group-item-action py-2 ${param.activePage == 'bookingreport' ? 'active' : ''}"
          >
            <i class="fas fa-chart-line me-2"></i> Booking Reports
          </a>
        </div>
      </div>
    </div>

    <h6 class="menu-heading text-uppercase text-white-50 mt-4 px-3">
      ROOMS SETTINGS
    </h6>
    <div class="list-group list-group-flush">
      <a
        href="roomlist.jsp"
        class="list-group-item list-group-item-action py-3 ${param.activePage == 'roomlist' ? 'active' : ''}"
      >
        <i class="fas fa-list me-2"></i> Room List
      </a>
      <a
        href="roomstatus.jsp"
        class="list-group-item list-group-item-action py-3 ${param.activePage == 'roomstatus' ? 'active' : ''}"
      >
        <i class="fas fa-clipboard-list me-2"></i> Room Status
      </a>
    </div>

    <!-- Account & System Section -->
    <h6 class="menu-heading text-uppercase text-white-50 mt-4 px-3">
      ACCOUNT & SYSTEM
    </h6>
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

<script>
  function confirmLogout() {
    if (confirm("Are you sure you want to logout?")) {
      // Invalidate session and redirect
      fetch("${pageContext.request.contextPath}/logout", {
        method: "POST",
      }).then(() => {
        window.location.href =
          "${pageContext.request.contextPath}/login.jsp?logout=true";
      });
    }
    return false;
  }
</script>
