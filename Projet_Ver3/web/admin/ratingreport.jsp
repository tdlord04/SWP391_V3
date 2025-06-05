<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>Rating Report - Hotel Management System</title>
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
        <jsp:param name="activePage" value="rating" />
      </jsp:include>

      <!-- Main Content -->
      <div id="page-content-wrapper" class="flex-fill">
        <!-- Top Navigation -->
        <nav class="navbar navbar-expand-lg navbar-light bg-white border-bottom shadow-sm">
          <div class="container-fluid">
            <button class="btn btn-outline-secondary" id="menu-toggle">
              <i class="fas fa-bars"></i>
            </button>
          </div>
        </nav>

        <div class="container-fluid py-4">
          <h2 class="mb-4">Rating Report</h2>

          <nav aria-label="breadcrumb" class="mb-4">
            <ol class="breadcrumb custom-breadcrumb">
              <li class="breadcrumb-item"><a href="dashboard.jsp">Home</a></li>
              <li class="breadcrumb-item active" aria-current="page">Rating Report</li>
            </ol>
          </nav>

          <!-- Top Performing Rooms Card -->
          <div class="card shadow-sm mb-4">
            <div class="card-header bg-white border-bottom py-3">
              <h5 class="mb-0">Top Performing Rooms</h5>
            </div>
            <div class="card-body">
              <div class="table-responsive">
                <table class="table table-striped table-hover align-middle">
                  <thead class="table-light">
                    <tr>
                      <th>Room Number</th>
                      <th>Room Type</th>
                      <th>Total Bookings</th>
                      <th>Revenue Generated</th>
                      <th>Occupancy Rate</th>
                      <th>Avg. Rating</th>
                    </tr>
                  </thead>
                  <tbody>
                    <tr>
                      <td><strong>301</strong></td>
                      <td>Presidential Suite</td>
                      <td>45</td>
                      <td>$33,750</td>
                      <td>89%</td>
                      <td>
                        <span class="text-warning">
                          <i class="fas fa-star"></i>
                          <i class="fas fa-star"></i>
                          <i class="fas fa-star"></i>
                          <i class="fas fa-star"></i>
                          <i class="fas fa-star"></i>
                          4.8
                        </span>
                      </td>
                    </tr>
                    <tr>
                      <td><strong>201</strong></td>
                      <td>Suite</td>
                      <td>67</td>
                      <td>$23,450</td>
                      <td>85%</td>
                      <td>
                        <span class="text-warning">
                          <i class="fas fa-star"></i>
                          <i class="fas fa-star"></i>
                          <i class="fas fa-star"></i>
                          <i class="fas fa-star"></i>
                          <i class="far fa-star"></i>
                          4.6
                        </span>
                      </td>
                    </tr>
                    <tr>
                      <td><strong>102</strong></td>
                      <td>Deluxe Room</td>
                      <td>89</td>
                      <td>$16,020</td>
                      <td>82%</td>
                      <td>
                        <span class="text-warning">
                          <i class="fas fa-star"></i>
                          <i class="fas fa-star"></i>
                          <i class="fas fa-star"></i>
                          <i class="fas fa-star"></i>
                          <i class="far fa-star"></i>
                          4.4
                        </span>
                      </td>
                    </tr>
                    <tr>
                      <td><strong>101</strong></td>
                      <td>Standard Room</td>
                      <td>112</td>
                      <td>$13,440</td>
                      <td>78%</td>
                      <td>
                        <span class="text-warning">
                          <i class="fas fa-star"></i>
                          <i class="fas fa-star"></i>
                          <i class="fas fa-star"></i>
                          <i class="fas fa-star"></i>
                          <i class="far fa-star"></i>
                          4.2
                        </span>
                      </td>
                    </tr>
                  </tbody>
                </table>
              </div>
            </div>
          </div>
        </div>
      </div>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
    <script>
      const menuToggle = document.getElementById('menu-toggle');
      const wrapper = document.getElementById('wrapper');
      if (menuToggle && wrapper) {
        menuToggle.addEventListener('click', () => {
          wrapper.classList.toggle('toggled');
        });
      }
    </script>
  </body>
</html>