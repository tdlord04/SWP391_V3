<%@ page language="java" contentType="text/html; charset=UTF-8"
pageEncoding="UTF-8" %> <%@ taglib uri="http://java.sun.com/jsp/jstl/core"
prefix="c" %>

<div class="sidebar-wrapper" id="sidebar-wrapper">
  <div class="sidebar-menu">
    <div class="list-group list-group-flush">
      <a
        href="${pageContext.request.contextPath}/home"
        class="list-group-item list-group-item-action py-3 ${param.activePage == 'home' ? 'active' : ''}"
      >
        <i class="fas fa-home me-2"></i> Home
      </a>
      <a
        href="${pageContext.request.contextPath}/customer/bookingHistory"
        class="list-group-item list-group-item-action py-3 ${param.activePage == 'bookinghistory' ? 'active' : ''}"
      >
        <i class="fas fa-history me-2"></i> Booking History
      </a>
    </div>

    <!-- Account & System Section -->
    <h6 class="menu-heading text-uppercase text-dark mt-4 px-3">
      ACCOUNT & SYSTEM
    </h6>
    <div class="list-group list-group-flush">
      <a
        href="${pageContext.request.contextPath}/customer/info"
        class="list-group-item list-group-item-action py-3 ${param.activePage == 'customerinfo' ? 'active' : ''}"
      >
        <i class="fas fa-user me-2"></i> Customer Information
      </a>
      <a
        href="${pageContext.request.contextPath}/logout"
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
      fetch("${pageContext.request.contextPath}/admin/logout", {
        method: "POST",
      }).then(() => {
        window.location.href =
          "${pageContext.request.contextPath}/login.jsp?logout=true";
      });
    }
    return false;
  }
</script>
