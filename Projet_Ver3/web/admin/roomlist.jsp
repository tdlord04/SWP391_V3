<%@ page language="java" contentType="text/html; charset=UTF-8"
pageEncoding="UTF-8"%> 
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>Room List - Hotel Management System</title>
    <link
      href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css"
      rel="stylesheet"
    />
    <link
      rel="stylesheet"
      href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css"
    />
    <link
      href="${pageContext.request.contextPath}/css/style.css"
      rel="stylesheet"
    />
  </head>
  <body>
    <div class="d-flex" id="wrapper">
      <jsp:include page="includes/sidebar.jsp">
        <jsp:param name="activePage" value="roomlist" />
      </jsp:include>

      <!-- Main Content -->
      <div id="page-content-wrapper" class="flex-fill">
        <!-- Top Navigation -->
        <nav
          class="navbar navbar-expand-lg navbar-light bg-white border-bottom shadow-sm"
        >
          <div class="container-fluid">
            <button class="btn btn-outline-secondary" id="menu-toggle">
              <i class="fas fa-bars"></i>
            </button>
          </div>
        </nav>

        <div class="container-fluid py-4">
          <h2 class="mb-4">Room Management</h2>
          
          <!-- Alert Messages -->
          <c:if test="${not empty sessionScope.message}">
            <div class="alert alert-${sessionScope.messageType} alert-dismissible fade show" role="alert">
              ${sessionScope.message}
              <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
            </div>
            <c:remove var="message" scope="session" />
            <c:remove var="messageType" scope="session" />
          </c:if>

          <nav aria-label="breadcrumb" class="mb-4">
            <ol class="breadcrumb custom-breadcrumb">
              <li class="breadcrumb-item"><a href="dashboard.jsp">Home</a></li>
              <li class="breadcrumb-item active" aria-current="page">
                Room List
              </li>
            </ol>
          </nav>

          <!-- Search and Filter Form -->
          <div class="card shadow mb-4">
            <div class="card-header py-3">
              <h6 class="m-0 font-weight-bold text-primary">Search & Filter Rooms</h6>
            </div>
            <div class="card-body">
              <form action="${pageContext.request.contextPath}/admin/roomlist" method="GET" class="mb-0">
                <div class="row g-3 align-items-center">
                  <!-- Search input -->
                  <div class="col-md-4 mb-3">
                    <label for="search" class="form-label">Search:</label>
                    <input type="text" class="form-control" id="search" name="search" 
                           placeholder="Room number or description" value="${searchQuery}"/>
                  </div>
                  
                  <!-- Room Type filter -->
                  <div class="col-md-3 mb-3">
                    <label for="roomType" class="form-label">Room Type:</label>
                    <select class="form-control" id="roomType" name="roomType">
                      <option value="all" ${roomTypeFilter == null || roomTypeFilter == 'all' ? 'selected' : ''}>All Types</option>
                      <c:forEach items="${roomTypes}" var="type">
                        <option value="${type.id}" ${roomTypeFilter == type.id ? 'selected' : ''}>
                          ${type.name}
                        </option>
                      </c:forEach>
                    </select>
                  </div>
                  
                  <!-- Status filter -->
                  <div class="col-md-3 mb-3">
                    <label for="status" class="form-label">Status:</label>
                    <select class="form-control" id="status" name="status">
                      <option value="all" ${statusFilter == null || statusFilter == 'all' ? 'selected' : ''}>All Statuses</option>
                      <option value="Available" ${statusFilter == 'Available' ? 'selected' : ''}>Available</option>
                      <option value="Occupied" ${statusFilter == 'Occupied' ? 'selected' : ''}>Occupied</option>
                      <option value="Maintenance" ${statusFilter == 'Maintenance' ? 'selected' : ''}>Maintenance</option>
                    </select>
                  </div>
                  
                  <!-- Submit button -->
                  <div class="col-md-2 mb-3 d-flex align-items-end">
                    <button type="submit" class="btn btn-primary w-100">Apply Filters</button>
                  </div>
                </div>
              </form>
            </div>
          </div>

          <!-- Page Header -->
          <div class="d-flex justify-content-between align-items-center mb-4">
            <h1 class="h3 mb-0">Room Management</h1>
            <button
              class="btn btn-primary"
              data-bs-toggle="modal"
              data-bs-target="#addRoomModal"
            >
              <i class="fas fa-plus me-2"></i>Add New Room
            </button>
          </div>

          <!-- Room Statistics Cards -->
          <div class="row g-4 mb-4">
            <div class="col-xl-3 col-md-6">
              <div class="card kpi-card shadow-sm">
                <div class="card-body">
                  <h6 class="card-subtitle mb-2 text-muted">Total Rooms</h6>
                  <h2 class="card-title display-6 fw-bold mb-1">${totalRoomCount}</h2>
                  <p class="card-text text-info">
                    <i class="fas fa-bed me-1"></i> All room types
                  </p>
                </div>
              </div>
            </div>
            <div class="col-xl-3 col-md-6">
              <div class="card kpi-card shadow-sm">
                <div class="card-body">
                  <h6 class="card-subtitle mb-2 text-muted">Available</h6>
                  <h2 class="card-title display-6 fw-bold mb-1">${availableRooms}</h2>
                  <p class="card-text text-success">
                    <i class="fas fa-check-circle me-1"></i> Ready for booking
                  </p>
                </div>
              </div>
            </div>
            <div class="col-xl-3 col-md-6">
              <div class="card kpi-card shadow-sm">
                <div class="card-body">
                  <h6 class="card-subtitle mb-2 text-muted">Occupied</h6>
                  <h2 class="card-title display-6 fw-bold mb-1">${occupiedRooms}</h2>
                  <p class="card-text text-warning">
                    <i class="fas fa-user me-1"></i> Currently booked
                  </p>
                </div>
              </div>
            </div>
            <div class="col-xl-3 col-md-6">
              <div class="card kpi-card shadow-sm">
                <div class="card-body">
                  <h6 class="card-subtitle mb-2 text-muted">Maintenance</h6>
                  <h2 class="card-title display-6 fw-bold mb-1">${maintenanceRooms}</h2>
                  <p class="card-text text-danger">
                    <i class="fas fa-tools me-1"></i> Under maintenance
                  </p>
                </div>
              </div>
            </div>
          </div>

          <!-- Filter Section -->
          <div class="card shadow-sm mb-4">
            <div class="card-body">
              <div class="row g-3">
                <div class="col-md-3">
                  <label class="form-label">Room Type</label>
                  <select class="form-select" id="roomTypeFilter">
                    <option value="">All Types</option>
                    <c:forEach var="type" items="${roomTypes}">
                      <option value="${type.id}">${type.roomType}</option>
                    </c:forEach>
                  </select>
                </div>
                <div class="col-md-3">
                  <label class="form-label">Status</label>
                  <select class="form-select">
                    <option value="">All Status</option>
                    <option value="available">Available</option>
                    <option value="occupied">Occupied</option>
                    <option value="maintenance">Maintenance</option>
                    <option value="cleaning">Cleaning</option>
                  </select>
                </div>
                <div class="col-md-3">
                  <label class="form-label">Floor</label>
                  <select class="form-select">
                    <option value="">All Floors</option>
                    <option value="1">1st Floor</option>
                    <option value="2">2nd Floor</option>
                    <option value="3">3rd Floor</option>
                    <option value="4">4th Floor</option>
                    <option value="5">5th Floor</option>
                  </select>
                </div>
                <div class="col-md-3">
                  <label class="form-label">&nbsp;</label>
                  <div class="d-grid">
                    <button class="btn btn-outline-primary">
                      <i class="fas fa-search me-2"></i>Filter
                    </button>
                  </div>
                </div>
              </div>
            </div>
          </div>

          <!-- Rooms Table -->
          <div class="card shadow-sm">
            <div class="card-header bg-white border-bottom py-3">
              <h5 class="mb-0">All Rooms</h5>
            </div>
            <div class="card-body">
              <div
                class="d-flex justify-content-between align-items-center mb-3 flex-wrap"
              >
                <div class="d-flex align-items-center mb-2 mb-md-0">
                  <span class="me-2 text-muted">Show</span>
                  <select
                    class="form-select form-select-sm"
                    style="width: auto"
                  >
                    <option value="10">10</option>
                    <option value="25">25</option>
                    <option value="50">50</option>
                    <option value="100">100</option>
                  </select>
                  <span class="ms-2 text-muted">entries</span>
                </div>
                <div
                  class="input-group search-table-input"
                  style="width: 250px"
                >
                  <span class="input-group-text"
                    ><i class="fas fa-search"></i
                  ></span>
                  <input
                    type="text"
                    class="form-control"
                    placeholder="Search rooms..."
                  />
                </div>
              </div>

              <div class="table-responsive">
                <table class="table table-striped table-hover align-middle">
                  <thead>
                    <tr>
                      <th>#</th>
                      <th>
                        <a href="${pageContext.request.contextPath}/admin/roomlist?sortBy=roomNumber${not empty searchQuery ? '&search='.concat(searchQuery) : ''}${not empty roomTypeFilter ? '&roomType='.concat(roomTypeFilter) : ''}${not empty statusFilter ? '&status='.concat(statusFilter) : ''}" class="text-dark">
                          Room Number
                          <c:if test="${sortBy == 'roomNumber'}"><i class="fas fa-sort-down ml-1"></i></c:if>
                        </a>
                      </th>
                      <th>Type</th>
                      <th>
                        <a href="${pageContext.request.contextPath}/admin/roomlist?sortBy=capacity${not empty searchQuery ? '&search='.concat(searchQuery) : ''}${not empty roomTypeFilter ? '&roomType='.concat(roomTypeFilter) : ''}${not empty statusFilter ? '&status='.concat(statusFilter) : ''}" class="text-dark">
                          Capacity
                          <c:if test="${sortBy == 'capacity'}"><i class="fas fa-sort-down ml-1"></i></c:if>
                        </a>
                      </th>
                      <th>
                        <a href="${pageContext.request.contextPath}/admin/roomlist?sortBy=price${not empty searchQuery ? '&search='.concat(searchQuery) : ''}${not empty roomTypeFilter ? '&roomType='.concat(roomTypeFilter) : ''}${not empty statusFilter ? '&status='.concat(statusFilter) : ''}" class="text-dark">
                          Price
                          <c:if test="${sortBy == 'price'}"><i class="fas fa-sort-down ml-1"></i></c:if>
                        </a>
                      </th>
                      <th>
                        <a href="${pageContext.request.contextPath}/admin/roomlist?sortBy=status${not empty searchQuery ? '&search='.concat(searchQuery) : ''}${not empty roomTypeFilter ? '&roomType='.concat(roomTypeFilter) : ''}${not empty statusFilter ? '&status='.concat(statusFilter) : ''}" class="text-dark">
                          Status
                          <c:if test="${sortBy == 'status'}"><i class="fas fa-sort-down ml-1"></i></c:if>
                        </a>
                      </th>
                      <th>Actions</th>
                    </tr>
                  </thead>
                  <tbody>
                    <c:choose>
                      <c:when test="${empty rooms}">
                        <tr>
                          <td colspan="8" class="text-center">No rooms found</td>
                        </tr>
                      </c:when>
                      <c:otherwise>
                        <c:forEach var="room" items="${rooms}">
                          <tr>
                            <td>${room.id}</td>
                            <td><strong>${room.roomNumber}</strong></td>
                            <td>
                              <c:forEach var="type" items="${roomTypes}">
                                <c:if test="${type.id eq room.roomTypeId}">${type.roomType}</c:if>
                              </c:forEach>
                            </td>
                            <td>${room.capacity} Guests</td>
                            <td><fmt:formatNumber value="${room.roomPrice}" type="currency" currencySymbol="" /> VNĐ</td>
                            <td>
                              <c:choose>
                                <c:when test="${room.roomStatus eq 'Khả dụng' || room.roomStatus eq 'Available'}">
                                  <span class="badge bg-success text-white px-3 py-2"><i class="fas fa-check-circle me-1"></i> Available</span>
                                </c:when>
                                <c:when test="${room.roomStatus eq 'Đang sử sụng' || room.roomStatus eq 'Occupied'}">
                                  <span class="badge bg-danger text-white px-3 py-2"><i class="fas fa-user me-1"></i> Occupied</span>
                                </c:when>
                                <c:when test="${room.roomStatus eq 'Bảo trì' || room.roomStatus eq 'Maintenance'}">
                                  <span class="badge bg-warning text-dark px-3 py-2"><i class="fas fa-tools me-1"></i> Maintenance</span>
                                </c:when>
                                <c:otherwise>
                                  <span class="badge bg-primary text-white px-3 py-2">${room.roomStatus}</span>
                                </c:otherwise>
                              </c:choose>
                            </td>
                            <td>
                              <c:choose>
                                <c:when test="${fn:length(room.description) > 20}">
                                  ${fn:substring(room.description, 0, 20)}...
                                </c:when>
                                <c:otherwise>
                                  ${room.description}
                                </c:otherwise>
                              </c:choose>
                            </td>
                            <td>
                              <div class="d-flex gap-2">
                                <button class="btn btn-sm btn-primary edit-room-btn" 
                                  data-bs-toggle="modal" 
                                  data-bs-target="#editRoomModal" 
                                  data-room-id="${room.id}"
                                  data-room-number="${room.roomNumber}"
                                  data-room-type-id="${room.roomTypeId}"
                                  data-room-price="${room.roomPrice}"
                                  data-room-status="${room.roomStatus}"
                                  data-capacity="${room.capacity}"
                                  data-description="${room.description}"
                                  data-image-url="${room.imageUrl}">
                                  <i class="fas fa-edit"></i>
                                </button>
                                <a href="${pageContext.request.contextPath}/room?id=${room.id}" class="btn btn-sm btn-info">
                                  <i class="fas fa-eye"></i>
                                </a>
                                <button class="btn btn-sm btn-danger" onclick="confirmDelete('${room.id}')">
                                  <i class="fas fa-trash"></i>
                                </button>
                              </div>
                            </td>
                          </tr>
                        </c:forEach>
                      </c:otherwise>
                    </c:choose>
                  </tbody>
                </table>
                
                <!-- Pagination Controls -->
                <c:if test="${totalPages > 1}">
                  <div class="d-flex justify-content-between align-items-center mt-4">
                    <div class="text-muted">
                      Showing ${(currentPage-1) * pageSize + 1} to ${(currentPage-1) * pageSize + displayedRooms} of ${totalRoomCount} rooms
                    </div>
                    <nav aria-label="Page navigation">
                      <ul class="pagination">
                        <!-- Previous Page Button -->
                        <li class="page-item ${currentPage == 1 ? 'disabled' : ''}">
                          <a class="page-link" href="${pageContext.request.contextPath}/admin/roomlist?page=${currentPage - 1}${not empty searchQuery ? '&search='.concat(searchQuery) : ''}${not empty roomTypeFilter ? '&roomType='.concat(roomTypeFilter) : ''}${not empty statusFilter ? '&status='.concat(statusFilter) : ''}${not empty sortBy ? '&sortBy='.concat(sortBy) : ''}" aria-label="Previous">
                            <span aria-hidden="true">&laquo;</span>
                          </a>
                        </li>
                        
                        <!-- Page Number Buttons -->
                        <c:forEach begin="${Math.max(1, currentPage - 2)}" end="${Math.min(totalPages, currentPage + 2)}" var="pageNum">
                          <li class="page-item ${pageNum == currentPage ? 'active' : ''}">
                            <a class="page-link" href="${pageContext.request.contextPath}/admin/roomlist?page=${pageNum}${not empty searchQuery ? '&search='.concat(searchQuery) : ''}${not empty roomTypeFilter ? '&roomType='.concat(roomTypeFilter) : ''}${not empty statusFilter ? '&status='.concat(statusFilter) : ''}${not empty sortBy ? '&sortBy='.concat(sortBy) : ''}">
                              ${pageNum}
                            </a>
                          </li>
                        </c:forEach>
                        
                        <!-- Next Page Button -->
                        <li class="page-item ${currentPage == totalPages ? 'disabled' : ''}">
                          <a class="page-link" href="${pageContext.request.contextPath}/admin/roomlist?page=${currentPage + 1}${not empty searchQuery ? '&search='.concat(searchQuery) : ''}${not empty roomTypeFilter ? '&roomType='.concat(roomTypeFilter) : ''}${not empty statusFilter ? '&status='.concat(statusFilter) : ''}${not empty sortBy ? '&sortBy='.concat(sortBy) : ''}" aria-label="Next">
                            <span aria-hidden="true">&raquo;</span>
                          </a>
                        </li>
                      </ul>
                    </nav>
                  </div>
                </c:if>
              </div>

              <div
                class="d-flex justify-content-between align-items-center mt-3 flex-wrap"
              >
                <small class="text-muted mb-2 mb-md-0"
                  >Showing 1 to 4 of 150 entries</small
                >
                <nav aria-label="Page navigation">
                  <ul class="pagination pagination-sm mb-0">
                    <li class="page-item disabled">
                      <a class="page-link" href="#">Previous</a>
                    </li>
                    <li class="page-item active">
                      <a class="page-link" href="#">1</a>
                    </li>
                    <li class="page-item">
                      <a class="page-link" href="#">2</a>
                    </li>
                    <li class="page-item">
                      <a class="page-link" href="#">3</a>
                    </li>
                    <li class="page-item">
                      <a class="page-link" href="#">Next</a>
                    </li>
                  </ul>
                </nav>
              </div>
            </div>
          </div>
        </div>
      </div>
    </div>

    <!-- Add Room Modal -->
    <div class="modal fade" id="addRoomModal" tabindex="-1">
      <div class="modal-dialog modal-lg">
        <div class="modal-content">
          <div class="modal-header">
            <h5 class="modal-title">Add New Room</h5>
            <button
              type="button"
              class="btn-close"
              data-bs-dismiss="modal"
            ></button>
          </div>
          <div class="modal-body">
            <form id="addRoomForm" action="${pageContext.request.contextPath}/admin/addroom" method="POST">
              <div class="row g-3">
                <div class="col-md-6">
                  <label for="roomNumber" class="form-label">Room Number*</label>
                  <input type="text" class="form-control" id="roomNumber" name="roomNumber" required />
                </div>
                <div class="col-md-6">
                  <label for="roomTypeId" class="form-label">Room Type*</label>
                  <select class="form-select" id="roomTypeId" name="roomTypeId" required>
                    <option value="">Select Room Type</option>
                    <c:forEach items="${roomTypes}" var="type">
                      <option value="${type.id}">${type.roomType}</option>
                    </c:forEach>
                  </select>
                </div>
                <div class="col-md-6">
                  <label for="capacity" class="form-label">Capacity*</label>
                  <select class="form-select" id="capacity" name="capacity" required>
                    <option value="">Select Capacity</option>
                    <option value="1">1 Guest</option>
                    <option value="2">2 Guests</option>
                    <option value="3">3 Guests</option>
                    <option value="4">4 Guests</option>
                    <option value="6">6 Guests</option>
                    <option value="8">8 Guests</option>
                  </select>
                </div>
                <div class="col-md-6">
                  <label for="roomPrice" class="form-label">Price per Night*</label>
                  <div class="input-group">
                    <span class="input-group-text">$</span>
                    <input
                      type="number"
                      class="form-control"
                      id="roomPrice"
                      name="roomPrice"
                      step="0.01"
                      min="0"
                      required
                    />
                  </div>
                </div>
                <div class="col-md-6">
                  <label for="roomStatus" class="form-label">Status*</label>
                  <select class="form-select" id="roomStatus" name="roomStatus" required>
                    <option value="Available">Available</option>
                    <option value="Occupied">Occupied</option>
                    <option value="Maintenance">Maintenance</option>
                    <option value="Cleaning">Cleaning</option>
                  </select>
                </div>
                <div class="col-md-6">
                  <label for="imageUrl" class="form-label">Image URL</label>
                  <input type="text" class="form-control" id="imageUrl" name="imageUrl" placeholder="https://example.com/image.jpg" />
                </div>
                <div class="col-12">
                  <label for="description" class="form-label">Room Description</label>
                  <textarea
                    class="form-control"
                    id="description"
                    name="description"
                    rows="3"
                    placeholder="Enter room features and amenities..."
                  ></textarea>
                </div>
                <div class="col-12">
                  <p class="form-label mb-2">Amenities (will be added to description)</p>
                  <div class="row">
                    <div class="col-md-4">
                      <div class="form-check">
                        <input
                          class="form-check-input amenity-checkbox"
                          type="checkbox"
                          id="wifi"
                          value="WiFi"
                        />
                        <label class="form-check-label" for="wifi">WiFi</label>
                      </div>
                      <div class="form-check">
                        <input
                          class="form-check-input amenity-checkbox"
                          type="checkbox"
                          id="ac"
                          value="Air Conditioning"
                        />
                        <label class="form-check-label" for="ac"
                          >Air Conditioning</label
                        >
                      </div>
                      <div class="form-check">
                        <input
                          class="form-check-input amenity-checkbox"
                          type="checkbox"
                          id="tv"
                          value="TV"
                        />
                        <label class="form-check-label" for="tv">TV</label>
                      </div>
                    </div>
                    <div class="col-md-4">
                      <div class="form-check">
                        <input
                          class="form-check-input amenity-checkbox"
                          type="checkbox"
                          id="minibar"
                          value="Mini Bar"
                        />
                        <label class="form-check-label" for="minibar"
                          >Mini Bar</label
                        >
                      </div>
                      <div class="form-check">
                        <input
                          class="form-check-input amenity-checkbox"
                          type="checkbox"
                          id="balcony"
                          value="Balcony"
                        />
                        <label class="form-check-label" for="balcony"
                          >Balcony</label
                        >
                      </div>
                      <div class="form-check">
                        <input
                          class="form-check-input amenity-checkbox"
                          type="checkbox"
                          id="safe"
                          value="Safe"
                        />
                        <label class="form-check-label" for="safe">Safe</label>
                      </div>
                    </div>
                    <div class="col-md-4">
                      <div class="form-check">
                        <input
                          class="form-check-input amenity-checkbox"
                          type="checkbox"
                          id="jacuzzi"
                          value="Jacuzzi"
                        />
                        <label class="form-check-label" for="jacuzzi"
                          >Jacuzzi</label
                        >
                      </div>
                      <div class="form-check">
                        <input
                          class="form-check-input amenity-checkbox"
                          type="checkbox"
                          id="kitchenette"
                          value="Kitchenette"
                        />
                        <label class="form-check-label" for="kitchenette"
                          >Kitchenette</label
                        >
                      </div>
                      <div class="form-check">
                        <input
                          class="form-check-input amenity-checkbox"
                          type="checkbox"
                          id="workspace"
                          value="Work Space"
                        />
                        <label class="form-check-label" for="workspace"
                          >Work Space</label
                        >
                      </div>
                    </div>
                  </div>
                </div>
              </div>
            </form>
          </div>
          <div class="modal-footer">
            <button
              type="button"
              class="btn btn-secondary"
              data-bs-dismiss="modal"
            >
              Cancel
            </button>
            <button type="button" class="btn btn-primary" id="submitAddRoom">Add Room</button>
          </div>
        </div>
      </div>
    </div>
    
    <!-- Edit Room Modal -->
    <div class="modal fade" id="editRoomModal" tabindex="-1">
      <div class="modal-dialog modal-lg">
        <div class="modal-content">
          <div class="modal-header">
            <h5 class="modal-title">Edit Room</h5>
            <button
              type="button"
              class="btn-close"
              data-bs-dismiss="modal"
            ></button>
          </div>
          <div class="modal-body">
            <form id="editRoomForm" action="${pageContext.request.contextPath}/admin/editroom" method="POST">
              <input type="hidden" id="edit-roomId" name="roomId">
              <div class="row g-3">
                <div class="col-md-6">
                  <label for="edit-roomNumber" class="form-label">Room Number*</label>
                  <input type="text" class="form-control" id="edit-roomNumber" name="roomNumber" required />
                </div>
                <div class="col-md-6">
                  <label for="edit-roomTypeId" class="form-label">Room Type*</label>
                  <select class="form-select" id="edit-roomTypeId" name="roomTypeId" required>
                    <option value="">Select Room Type</option>
                    <c:forEach items="${roomTypes}" var="type">
                      <option value="${type.id}">${type.roomType}</option>
                    </c:forEach>
                  </select>
                </div>
                <div class="col-md-6">
                  <label for="edit-capacity" class="form-label">Capacity*</label>
                  <select class="form-select" id="edit-capacity" name="capacity" required>
                    <option value="">Select Capacity</option>
                    <option value="1">1 Guest</option>
                    <option value="2">2 Guests</option>
                    <option value="3">3 Guests</option>
                    <option value="4">4 Guests</option>
                    <option value="6">6 Guests</option>
                    <option value="8">8 Guests</option>
                  </select>
                </div>
                <div class="col-md-6">
                  <label for="edit-roomPrice" class="form-label">Price per Night*</label>
                  <div class="input-group">
                    <span class="input-group-text">$</span>
                    <input
                      type="number"
                      class="form-control"
                      id="edit-roomPrice"
                      name="roomPrice"
                      step="0.01"
                      min="0"
                      required
                    />
                  </div>
                </div>
                <div class="col-md-6">
                  <label for="edit-roomStatus" class="form-label">Status*</label>
                  <select class="form-select" id="edit-roomStatus" name="roomStatus" required>
                    <option value="Available">Available</option>
                    <option value="Occupied">Occupied</option>
                    <option value="Maintenance">Maintenance</option>
                    <option value="Cleaning">Cleaning</option>
                  </select>
                </div>
                <div class="col-md-6">
                  <label for="edit-imageUrl" class="form-label">Image URL</label>
                  <input type="text" class="form-control" id="edit-imageUrl" name="imageUrl" placeholder="https://example.com/image.jpg" />
                </div>
                <div class="col-12">
                  <label for="edit-description" class="form-label">Room Description</label>
                  <textarea
                    class="form-control"
                    id="edit-description"
                    name="description"
                    rows="3"
                    placeholder="Enter room features and amenities..."
                  ></textarea>
                </div>
              </div>
            </form>
          </div>
          <div class="modal-footer">
            <button
              type="button"
              class="btn btn-secondary"
              data-bs-dismiss="modal"
            >
              Cancel
            </button>
            <button type="button" class="btn btn-primary" id="submitEditRoom">Save Changes</button>
          </div>
        </div>
      </div>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
    <script>
      // Sidebar toggle functionality
      document
        .getElementById("menu-toggle")
        .addEventListener("click", function () {
          document
            .getElementById("sidebar-wrapper")
            .classList.toggle("toggled");
        });
    </script>
    <script>
      // Function to handle room deletion confirmation
      function confirmDelete(roomId) {
        if (confirm('Are you sure you want to delete this room?')) {
          // If confirmed, redirect to a delete endpoint
          window.location.href = '${pageContext.request.contextPath}/admin/deleteroom?id=' + roomId;
        }
      }
      
      // Add Room form submission handling
      document.addEventListener('DOMContentLoaded', function() {
        const submitAddRoomBtn = document.getElementById('submitAddRoom');
        const addRoomForm = document.getElementById('addRoomForm');
        const descriptionField = document.getElementById('description');
        const amenityCheckboxes = document.querySelectorAll('.amenity-checkbox');
        
        // Handle Add Room form submission
        if (submitAddRoomBtn) {
          submitAddRoomBtn.addEventListener('click', function() {
            // Validate form
            if (!addRoomForm.checkValidity()) {
              addRoomForm.reportValidity();
              return;
            }
            
            // Process amenities and add to description if checked
            let amenities = [];
            amenityCheckboxes.forEach(function(checkbox) {
              if (checkbox.checked) {
                amenities.push(checkbox.value);
              }
            });
            
            if (amenities.length > 0) {
              let currentDesc = descriptionField.value.trim();
              if (currentDesc) {
                currentDesc += '\n\n';
              }
              currentDesc += 'Amenities: ' + amenities.join(', ');
              descriptionField.value = currentDesc;
            }
            
            // Submit the form
            addRoomForm.submit();
          });
        }
        
        // Handle Edit Room modal population
        const editRoomBtns = document.querySelectorAll('.edit-room-btn');
        const editRoomForm = document.getElementById('editRoomForm');
        const submitEditRoomBtn = document.getElementById('submitEditRoom');
        
        // When edit button is clicked, populate the form with room data
        editRoomBtns.forEach(function(btn) {
          btn.addEventListener('click', function() {
            const roomId = this.getAttribute('data-room-id');
            const roomNumber = this.getAttribute('data-room-number');
            const roomTypeId = this.getAttribute('data-room-type-id');
            const roomPrice = this.getAttribute('data-room-price');
            const roomStatus = this.getAttribute('data-room-status');
            const capacity = this.getAttribute('data-capacity');
            const description = this.getAttribute('data-description');
            const imageUrl = this.getAttribute('data-image-url');
            
            // Set values in the edit form
            document.getElementById('edit-roomId').value = roomId;
            document.getElementById('edit-roomNumber').value = roomNumber;
            document.getElementById('edit-roomTypeId').value = roomTypeId;
            document.getElementById('edit-roomPrice').value = roomPrice;
            document.getElementById('edit-roomStatus').value = roomStatus;
            document.getElementById('edit-capacity').value = capacity;
            document.getElementById('edit-description').value = description || '';
            document.getElementById('edit-imageUrl').value = imageUrl || '';
          });
        });
        
        // Handle Edit Room form submission
        if (submitEditRoomBtn) {
          submitEditRoomBtn.addEventListener('click', function() {
            // Validate form
            if (!editRoomForm.checkValidity()) {
              editRoomForm.reportValidity();
              return;
            }
            
            // Submit the form
            editRoomForm.submit();
          });
        }
      });
    </script>
  </body>
</html>
