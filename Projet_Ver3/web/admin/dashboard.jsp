<%@ page language="java" contentType="text/html; charset=UTF-8"
pageEncoding="UTF-8" %> <%@ taglib uri="http://java.sun.com/jsp/jstl/core"
prefix="c" %> <%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>Admin Dashboard - Hotel Management System</title>
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
    <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
    <style>
      a {
        color: rgb(255 255 255);
        text-decoration: underline;
      }
    </style>
  </head>
  <body>
    <div class="d-flex" id="wrapper">
      <jsp:include page="includes/sidebar.jsp">
        <jsp:param name="activePage" value="dashboard" />
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
          <!-- Page Header -->
          <div class="bg-primary bg-gradient text-white p-4 mb-4 rounded-3">
            <div class="d-flex justify-content-between align-items-center">
              <div>
                <h1 class="h2 mb-2">Dashboard Overview</h1>
                <nav aria-label="breadcrumb">
                  <ol class="breadcrumb mb-0">
                    <li class="breadcrumb-item">
                      <a href="#"><i class="fas fa-home me-1"></i>Home</a>
                    </li>
                    <li class="breadcrumb-item active">Dashboard</li>
                  </ol>
                </nav>
              </div>
              <div class="btn-group">
                <button class="btn btn-light" onclick="exportReport()">
                  <i class="fas fa-download me-2"></i>Export Report
                </button>
                <button class="btn btn-light" onclick="refreshData()">
                  <i class="fas fa-sync-alt me-2"></i>Refresh
                </button>
              </div>
            </div>
          </div>

          <!-- Summary Cards -->
          <div class="row g-4 mb-4">
            <div class="col-xl-3 col-md-6">
              <div class="card shadow-sm h-100 mb-4">
                <div class="card-body">
                  <div class="d-flex justify-content-between align-items-start">
                    <div>
                      <h6 class="card-subtitle text-muted mb-2">
                        Total Revenue
                      </h6>
                      <h2 class="display-6 fw-bold mb-1">$125,000</h2>
                      <p class="text-success mb-0">
                        <i class="fas fa-arrow-up me-1"></i>15.3%
                        <span class="text-muted ms-1">vs last month</span>
                      </p>
                    </div>
                    <div class="stat-icon bg-primary bg-opacity-10">
                      <i class="fas fa-dollar-sign text-primary"></i>
                    </div>
                  </div>
                </div>
              </div>
            </div>
            <div class="col-xl-3 col-md-6">
              <div class="card shadow-sm h-100 mb-4">
                <div class="card-body">
                  <div class="d-flex justify-content-between align-items-start">
                    <div>
                      <h6 class="card-subtitle text-muted mb-2">
                        Room Occupancy
                      </h6>
                      <h2 class="display-6 fw-bold mb-1">80%</h2>
                      <p class="text-success mb-0">
                        <i class="fas fa-arrow-up me-1"></i>5.2%
                        <span class="text-muted ms-1">vs last week</span>
                      </p>
                    </div>
                    <div class="stat-icon bg-success bg-opacity-10">
                      <i class="fas fa-bed text-success"></i>
                    </div>
                  </div>
                </div>
              </div>
            </div>
            <div class="col-xl-3 col-md-6">
              <div class="card shadow-sm h-100 mb-4">
                <div class="card-body">
                  <div class="d-flex justify-content-between align-items-start">
                    <div>
                      <h6 class="card-subtitle text-muted mb-2">
                        New Bookings
                      </h6>
                      <h2 class="display-6 fw-bold mb-1">385</h2>
                      <p class="text-success mb-0">
                        <i class="fas fa-arrow-up me-1"></i>8.1%
                        <span class="text-muted ms-1">vs yesterday</span>
                      </p>
                    </div>
                    <div class="stat-icon bg-info bg-opacity-10">
                      <i class="fas fa-calendar-check text-info"></i>
                    </div>
                  </div>
                </div>
              </div>
            </div>
            <div class="col-xl-3 col-md-6">
              <div class="card shadow-sm h-100 mb-4">
                <div class="card-body">
                  <div class="d-flex justify-content-between align-items-start">
                    <div>
                      <h6 class="card-subtitle text-muted mb-2">
                        Customer Rating
                      </h6>
                      <h2 class="display-6 fw-bold mb-1">4.8/5</h2>
                      <p class="text-success mb-0">
                        <i class="fas fa-arrow-up me-1"></i>0.3
                        <span class="text-muted ms-1">vs last month</span>
                      </p>
                    </div>
                    <div class="stat-icon bg-warning bg-opacity-10">
                      <i class="fas fa-star text-warning"></i>
                    </div>
                  </div>
                </div>
              </div>
            </div>
          </div>

          <!-- Charts Row -->
          <div class="row g-4 mb-4">
            <div class="col-lg-8">
              <div class="card shadow-sm h-100">
                <div class="card-header bg-white border-bottom py-3">
                  <div class="d-flex justify-content-between align-items-center">
                    <h5 class="mb-0">
                      <i class="fas fa-chart-line me-2 text-primary"></i>Revenue Analytics
                    </h5>
                    <div class="btn-group btn-group-sm">
                      <button class="btn btn-outline-secondary" onclick="updateChart('weekly')">
                        Weekly
                      </button>
                      <button class="btn btn-outline-secondary active" onclick="updateChart('monthly')">
                        Monthly
                      </button>
                      <button class="btn btn-outline-secondary" onclick="updateChart('yearly')">
                        Yearly
                      </button>
                    </div>
                  </div>
                </div>
                <div class="card-body">
                  <div class="chart-container">
                    <canvas id="revenueChart"></canvas>
                  </div>
                </div>
              </div>
            </div>
            <div class="col-lg-4">
              <div class="card shadow-sm h-100">
                <div class="card-header bg-white border-bottom py-3">
                  <h5 class="mb-0">
                    <i class="fas fa-bolt me-2 text-warning"></i>Quick Actions
                  </h5>
                </div>
                <div class="card-body">
                  <div class="d-grid gap-3">
                    <a href="bookings.jsp" class="btn btn-outline-primary quick-action-btn">
                      <i class="fas fa-calendar-plus me-2"></i>New Booking
                    </a>
                    <a href="roomstatus.jsp" class="btn btn-outline-info quick-action-btn">
                      <i class="fas fa-door-open me-2"></i>Room Management
                    </a>
                    <a href="users.jsp" class="btn btn-outline-success quick-action-btn">
                      <i class="fas fa-users-cog me-2"></i>Staff Management
                    </a>
                    <a href="purchasereport.jsp" class="btn btn-outline-warning quick-action-btn">
                      <i class="fas fa-chart-bar me-2"></i>Reports & Analytics
                    </a>
                    <a href="stockreport.jsp" class="btn btn-outline-secondary quick-action-btn">
                      <i class="fas fa-box me-2"></i>Inventory Check
                    </a>
                  </div>
                </div>
              </div>
            </div>
          </div>

          <!-- Recent Bookings and Quick Actions -->
          <div class="row g-4">
            <div class="col-lg-8">
              <div class="card shadow-sm">
                <div class="card-header bg-white border-bottom py-3">
                  <div
                    class="d-flex justify-content-between align-items-center"
                  >
                    <h5 class="mb-0">
                      <i class="fas fa-calendar-alt me-2 text-info"></i>Recent
                      Bookings
                    </h5>
                    <a href="bookings.jsp" class="btn btn-sm btn-primary">
                      <i class="fas fa-eye me-1"></i>View All
                    </a>
                  </div>
                </div>
                <div class="card-body">
                  <div class="table-responsive">
                    <table class="table table-hover align-middle mb-0">
                      <thead class="table-light">
                        <tr>
                          <th>Guest</th>
                          <th>Room Type</th>
                          <th>Check In</th>
                          <th>Check Out</th>
                          <th>Status</th>
                          <th>Actions</th>
                        </tr>
                      </thead>
                      <tbody>
                        <tr>
                          <td>
                            <div class="d-flex align-items-center">
                              <div
                                class="bg-primary bg-opacity-10 rounded-circle p-2 me-3"
                              >
                                <i class="fas fa-user text-primary"></i>
                              </div>
                              <div>
                                <h6 class="mb-0">John Smith</h6>
                                <small class="text-muted">ID: #12345</small>
                              </div>
                            </div>
                          </td>
                          <td>
                            <span class="badge bg-light text-dark"
                              >Deluxe Room</span
                            >
                          </td>
                          <td>May 25, 2025</td>
                          <td>May 28, 2025</td>
                          <td>
                            <span class="badge bg-success status-badge"
                              >Confirmed</span
                            >
                          </td>
                          <td>
                            <div class="table-actions">
                              <button
                                class="btn btn-sm btn-outline-primary me-1"
                                title="View Details"
                              >
                                <i class="fas fa-eye"></i>
                              </button>
                              <button
                                class="btn btn-sm btn-outline-warning me-1"
                                title="Edit"
                              >
                                <i class="fas fa-edit"></i>
                              </button>
                              <button
                                class="btn btn-sm btn-outline-danger"
                                title="Cancel"
                              >
                                <i class="fas fa-times"></i>
                              </button>
                            </div>
                          </td>
                        </tr>
                        <tr>
                          <td>
                            <div class="d-flex align-items-center">
                              <div
                                class="bg-primary bg-opacity-10 rounded-circle p-2 me-3"
                              >
                                <i class="fas fa-user text-primary"></i>
                              </div>
                              <div>
                                <h6 class="mb-0">Maria Garcia</h6>
                                <small class="text-muted">ID: #12346</small>
                              </div>
                            </div>
                          </td>
                          <td>
                            <span class="badge bg-light text-dark">Suite</span>
                          </td>
                          <td>May 26, 2025</td>
                          <td>May 30, 2025</td>
                          <td>
                            <span class="badge bg-warning status-badge"
                              >Pending</span
                            >
                          </td>
                          <td>
                            <div class="table-actions">
                              <button
                                class="btn btn-sm btn-outline-primary me-1"
                                title="View Details"
                              >
                                <i class="fas fa-eye"></i>
                              </button>
                              <button
                                class="btn btn-sm btn-outline-warning me-1"
                                title="Edit"
                              >
                                <i class="fas fa-edit"></i>
                              </button>
                              <button
                                class="btn btn-sm btn-outline-danger"
                                title="Cancel"
                              >
                                <i class="fas fa-times"></i>
                              </button>
                            </div>
                          </td>
                        </tr>
                        <tr>
                          <td>
                            <div class="d-flex align-items-center">
                              <div
                                class="bg-primary bg-opacity-10 rounded-circle p-2 me-3"
                              >
                                <i class="fas fa-user text-primary"></i>
                              </div>
                              <div>
                                <h6 class="mb-0">David Johnson</h6>
                                <small class="text-muted">ID: #12347</small>
                              </div>
                            </div>
                          </td>
                          <td>
                            <span class="badge bg-light text-dark"
                              >Standard Room</span
                            >
                          </td>
                          <td>May 27, 2025</td>
                          <td>May 29, 2025</td>
                          <td>
                            <span class="badge bg-success status-badge"
                              >Confirmed</span
                            >
                          </td>
                          <td>
                            <div class="table-actions">
                              <button
                                class="btn btn-sm btn-outline-primary me-1"
                                title="View Details"
                              >
                                <i class="fas fa-eye"></i>
                              </button>
                              <button
                                class="btn btn-sm btn-outline-warning me-1"
                                title="Edit"
                              >
                                <i class="fas fa-edit"></i>
                              </button>
                              <button
                                class="btn btn-sm btn-outline-danger"
                                title="Cancel"
                              >
                                <i class="fas fa-times"></i>
                              </button>
                            </div>
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
      </div>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
    <script>
      document.addEventListener('DOMContentLoaded', function() {
        const menuToggle = document.getElementById('menu-toggle');
        const sidebarWrapper = document.getElementById('sidebar-wrapper');
        
        if (menuToggle && sidebarWrapper) {
          menuToggle.addEventListener('click', function () {
            sidebarWrapper.classList.toggle('toggled');
            console.log('Sidebar toggle clicked');  // For debugging
          });
        } else {
          console.error('Elements not found: menu-toggle or sidebar-wrapper');
        }
      });

      // Chart data
      const chartData = {
        weekly: {
          labels: ["Mon", "Tue", "Wed", "Thu", "Fri", "Sat", "Sun"],
          data: [15000, 18000, 22000, 19000, 25000, 28000, 24000],
        },
        monthly: {
          labels: [
            "Jan",
            "Feb",
            "Mar",
            "Apr",
            "May",
            "Jun",
            "Jul",
            "Aug",
            "Sep",
            "Oct",
            "Nov",
            "Dec",
          ],
          data: [
            65000, 75000, 88000, 85000, 92000, 95000, 98000, 105000, 115000,
            118000, 120000, 125000,
          ],
        },
        yearly: {
          labels: ["2020", "2021", "2022", "2023", "2024", "2025"],
          data: [850000, 920000, 1050000, 1180000, 1350000, 1500000],
        },
      };

      // Revenue Chart
      const revenueCtx = document
        .getElementById("revenueChart")
        .getContext("2d");
      let revenueChart = new Chart(revenueCtx, {
        type: "line",
        data: {
          labels: chartData.monthly.labels,
          datasets: [
            {
              label: "Revenue ($)",
              data: chartData.monthly.data,
              borderColor: "rgb(54, 162, 235)",
              backgroundColor: "rgba(54, 162, 235, 0.1)",
              tension: 0.4,
              fill: true,
              pointBackgroundColor: "rgb(54, 162, 235)",
              pointBorderColor: "#fff",
              pointBorderWidth: 2,
              pointRadius: 5,
            },
          ],
        },
        options: {
          responsive: true,
          maintainAspectRatio: false,
          plugins: {
            legend: { display: false },
            tooltip: {
              backgroundColor: "rgba(0,0,0,0.8)",
              titleColor: "white",
              bodyColor: "white",
              borderColor: "rgba(54, 162, 235, 1)",
              borderWidth: 1,
            },
          },
          scales: {
            y: {
              beginAtZero: true,
              grid: {
                color: "rgba(0,0,0,0.1)",
              },
              ticks: {
                callback: function (value) {
                  return "$" + value.toLocaleString();
                },
              },
            },
            x: {
              grid: {
                color: "rgba(0,0,0,0.1)",
              },
            },
          },
        },
      });

      // Functions
      function updateChart(period) {
        // Update active button
        document
          .querySelectorAll(".btn-group .btn")
          .forEach((btn) => btn.classList.remove("active"));
        event.target.classList.add("active");

        // Update chart data
        revenueChart.data.labels = chartData[period].labels;
        revenueChart.data.datasets[0].data = chartData[period].data;
        revenueChart.update();
      }

      function exportReport() {
        // Show loading state
        const btn = event.target;
        const originalText = btn.innerHTML;
        btn.innerHTML =
          '<i class="fas fa-spinner fa-spin me-2"></i>Generating...';
        btn.disabled = true;

        setTimeout(() => {
          btn.innerHTML = originalText;
          btn.disabled = false;
          alert("Dashboard report has been generated and downloaded!");
        }, 2000);
      }

      function refreshData() {
        // Show loading state
        const btn = event.target;
        const originalText = btn.innerHTML;
        btn.innerHTML =
          '<i class="fas fa-spinner fa-spin me-2"></i>Refreshing...';
        btn.disabled = true;

        setTimeout(() => {
          btn.innerHTML = originalText;
          btn.disabled = false;
          location.reload();
        }, 1500);
      }

      // Auto-refresh data every 5 minutes
      setInterval(() => {
        console.log("Auto-refreshing dashboard data...");
        // Add actual data refresh logic here
      }, 300000);

      // Initialize tooltips
      var tooltipTriggerList = [].slice.call(
        document.querySelectorAll('[data-bs-toggle="tooltip"]')
      );
      var tooltipList = tooltipTriggerList.map(function (tooltipTriggerEl) {
        return new bootstrap.Tooltip(tooltipTriggerEl);
      });
    </script>
  </body>
</html>
