<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Customer Information</title>
    <!-- Bootstrap CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <!-- Font Awesome -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
</head>
<body class="bg-light">
    <div class="d-flex">
        <!-- Include the sidebar -->
        <div class="position-fixed h-100" style="width: 250px; z-index: 1000;">
            <jsp:include page="includes/sidebar.jsp">
                <jsp:param name="activePage" value="customerinfo" />
            </jsp:include>
        </div>

        <!-- Main Content -->
        <div class="ms-auto p-4" style="width: calc(100% - 250px);">
            <div class="container-fluid">
            <h2 class="mb-4">Customer Information</h2>
            
            <!-- Password success message -->
            <c:if test="${not empty sessionScope.passwordSuccess}">
                <div class="alert alert-success alert-dismissible fade show" role="alert">
                    ${sessionScope.passwordSuccess}
                    <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
                </div>
                <c:remove var="passwordSuccess" scope="session" />
            </c:if>
            
            <!-- Password error message -->
            <c:if test="${not empty sessionScope.passwordError}">
                <div class="alert alert-danger alert-dismissible fade show" role="alert">
                    ${sessionScope.passwordError}
                    <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
                </div>
                <c:remove var="passwordError" scope="session" />
            </c:if>
            
            <!-- Profile update success message -->
            <c:if test="${not empty sessionScope.profileSuccess}">
                <div class="alert alert-success alert-dismissible fade show" role="alert">
                    ${sessionScope.profileSuccess}
                    <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
                </div>
                <c:remove var="profileSuccess" scope="session" />
            </c:if>
            
            <!-- Profile update error message -->
            <c:if test="${not empty sessionScope.profileError}">
                <div class="alert alert-danger alert-dismissible fade show" role="alert">
                    ${sessionScope.profileError}
                    <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
                </div>
                <c:remove var="profileError" scope="session" />
            </c:if>
            
            <div class="row">
                <div class="col-lg-4">
                    <div class="card shadow-sm rounded text-center p-4 mb-4">
                        <img src="../img/user-profile.png" alt="Profile Picture" class="rounded-circle mx-auto border border-3 border-primary" style="width: 150px; height: 150px; object-fit: cover;">
                        <h4 class="mt-3">${user.fullName}</h4>
                        <p class="text-muted">User ID: ${user.id}</p>
                        <p><i class="fas fa-user me-2"></i>${user.userName}</p>
                        <p><i class="fas fa-envelope me-2"></i>${user.email}</p>
                        <p><i class="fas fa-phone me-2"></i>${user.phone}</p>
                        <p><i class="fas fa-venus-mars me-2"></i>${user.gender}</p>
                        <div class="d-flex justify-content-center gap-2 mt-3">
                            <button class="btn btn-primary" data-bs-toggle="modal" data-bs-target="#editProfileModal">
                                <i class="fas fa-edit me-2"></i>Edit Info
                            </button>
                            <button class="btn btn-secondary" data-bs-toggle="modal" data-bs-target="#changePasswordModal">
                                <i class="fas fa-key me-2"></i>Change Password
                            </button>
                        </div>
                    </div>
                </div>
                
                <div class="col-lg-8">
                    <div class="card shadow-sm rounded p-4 mb-4">
                        <h4 class="mb-3">Personal Details</h4>
                        <div class="row mb-2">
                            <div class="col-md-4 fw-bold">Full Name:</div>
                            <div class="col-md-8">${user.fullName}</div>
                        </div>
                        <div class="row mb-2">
                            <div class="col-md-4 fw-bold">Email Address:</div>
                            <div class="col-md-8">${user.email}</div>
                        </div>
                        <div class="row mb-2">
                            <div class="col-md-4 fw-bold">Phone Number:</div>
                            <div class="col-md-8">${user.phone}</div>
                        </div>
                        <div class="row mb-2">
                            <div class="col-md-4 fw-bold">Address:</div>
                            <div class="col-md-8">${user.address}</div>
                        </div>
                        <div class="row mb-2">
                            <div class="col-md-4 fw-bold">Date of Birth:</div>
                            <div class="col-md-8">${user.birth}</div>
                        </div>
                        <div class="row mb-2">
                            <div class="col-md-4 fw-bold">Gender:</div>
                            <div class="col-md-8">${user.gender}</div>
                        </div>
                        <div class="row mb-2">
                            <div class="col-md-4 fw-bold">Username:</div>
                            <div class="col-md-8">${user.userName}</div>
                        </div>
                        <div class="row mb-2">
                            <div class="col-md-4 fw-bold">Role:</div>
                            <div class="col-md-8">
                                <span class="badge bg-${user.role == 'admin' ? 'danger' : user.role == 'staff' ? 'warning' : 'primary'}">
                                    ${user.role}
                                </span>
                            </div>
                        </div>
                        <div class="row mb-2">
                            <div class="col-md-4 fw-bold">User ID:</div>
                            <div class="col-md-8">${user.id}</div>
                        </div>
                    </div>
                    
                    <div class="card shadow-sm rounded p-4 mb-4">
                        <h4 class="mb-3">Recent Bookings</h4>
                        <c:choose>
                            <c:when test="${not empty recentBookings}">
                                <div class="table-responsive">
                                    <table class="table table-hover">
                                        <thead>
                                            <tr>
                                                <th>Booking ID</th>
                                                <th>Room</th>
                                                <th>Check-In</th>
                                                <th>Check-Out</th>
                                                <th>Status</th>
                                                <th>Action</th>
                                            </tr>
                                        </thead>
                                        <tbody>
                                            <c:forEach items="${recentBookings}" var="booking">
                                                <tr>
                                                    <td>${booking.id}</td>
                                                    <td>${booking.roomName}</td>
                                                    <td>${booking.checkInDate}</td>
                                                    <td>${booking.checkOutDate}</td>
                                                    <td>
                                                        <span class="badge bg-${booking.status == 'Confirmed' ? 'success' : booking.status == 'Pending' ? 'warning' : 'danger'}">
                                                            ${booking.status}
                                                        </span>
                                                    </td>
                                                    <td>
                                                        <a href="bookingDetails?id=${booking.id}" class="btn btn-sm btn-outline-primary">
                                                            <i class="fas fa-eye"></i>
                                                        </a>
                                                    </td>
                                                </tr>
                                            </c:forEach>
                                        </tbody>
                                    </table>
                                </div>
                            </c:when>
                            <c:otherwise>
                                <p class="text-muted">No recent bookings found.</p>
                            </c:otherwise>
                        </c:choose>
                        <a href="bookingHistory" class="btn btn-outline-primary mt-2">View All Bookings</a>
                    </div>
                </div>
            </div>
        </div>
    </div>
    
    <!-- Edit Profile Modal -->
    <div class="modal fade" id="editProfileModal" tabindex="-1" aria-labelledby="editProfileModalLabel" aria-hidden="true">
        <div class="modal-dialog modal-lg">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id="editProfileModalLabel">Edit Profile</h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                </div>
                <form action="${pageContext.request.contextPath}/customer/updateProfile" method="post">
                    <div class="modal-body">
                        <input type="hidden" name="id" value="${user.id}">
                        <div class="mb-3">
                            <label for="userName" class="form-label">Username</label>
                            <input type="text" class="form-control" id="userName" name="userName" value="${user.userName}" required>
                            <small class="text-muted">Choose a unique username</small>
                        </div>
                        <div class="mb-3">
                            <label for="fullName" class="form-label">Full Name</label>
                            <input type="text" class="form-control" id="fullName" name="fullName" value="${user.fullName}" required>
                        </div>
                        <div class="mb-3">
                            <label for="email" class="form-label">Email Address</label>
                            <input type="email" class="form-control" id="email" name="email" value="${user.email}" required>
                        </div>
                        <div class="mb-3">
                            <label for="phone" class="form-label">Phone Number</label>
                            <input type="tel" class="form-control" id="phone" name="phone" value="${user.phone}" required>
                        </div>
                        <div class="mb-3">
                            <label for="address" class="form-label">Address</label>
                            <textarea class="form-control" id="address" name="address" rows="2">${user.address}</textarea>
                        </div>
                        <div class="mb-3">
                            <label for="birth" class="form-label">Date of Birth</label>
                            <input type="date" class="form-control" id="birth" name="birth" value="${user.birth}">
                        </div>
                        <div class="mb-3">
                            <label for="gender" class="form-label">Gender</label>
                            <select class="form-select" id="gender" name="gender">
                                <option value="Nam" ${user.gender == 'Nam' ? 'selected' : ''}>Nam</option>
                                <option value="Nữ" ${user.gender == 'Nữ' ? 'selected' : ''}>Nữ</option>
                                <option value="Khác" ${user.gender == 'Khác' ? 'selected' : ''}>Khác</option>
                            </select>
                        </div>
                        <!-- Password fields removed and moved to separate modal -->
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cancel</button>
                        <button type="submit" class="btn btn-primary">Save Changes</button>
                    </div>
                </form>
            </div>
        </div>
    </div>

    <!-- Change Password Modal -->
    <div class="modal fade" id="changePasswordModal" tabindex="-1" aria-labelledby="changePasswordModalLabel" aria-hidden="true">
        <div class="modal-dialog">
            <div class="modal-content">
                <form action="${pageContext.request.contextPath}/customer/changePassword" method="post">
                    <div class="modal-header">
                        <h5 class="modal-title" id="changePasswordModalLabel">Change Password</h5>
                        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                    </div>
                    <div class="modal-body">
                        <input type="hidden" name="userId" value="${user.id}">
                        <div class="mb-3">
                            <label for="currentPassword" class="form-label">Current Password</label>
                            <input type="password" class="form-control" id="currentPassword" name="currentPassword" required>
                        </div>
                        <div class="mb-3">
                            <label for="newPassword" class="form-label">New Password</label>
                            <input type="password" class="form-control" id="newPassword" name="newPassword" required>
                        </div>
                        <div class="mb-3">
                            <label for="confirmNewPassword" class="form-label">Confirm New Password</label>
                            <input type="password" class="form-control" id="confirmNewPassword" name="confirmNewPassword" required>
                        </div>
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cancel</button>
                        <button type="submit" class="btn btn-primary">Change Password</button>
                    </div>
                </form>
            </div>
        </div>
    </div>

    <!-- Bootstrap JS and dependencies -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
