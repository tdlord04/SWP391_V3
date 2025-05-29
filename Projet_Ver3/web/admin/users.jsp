<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>User List - Hotel Management System</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <link href="${pageContext.request.contextPath}/css/style.css" rel="stylesheet">
    <style>
        .kpi-card {
            transition: transform 0.2s ease-in-out, box-shadow 0.2s ease-in-out;
            border: none;
            border-radius: 12px;
        }
        .kpi-card:hover {
            transform: translateY(-5px);
            box-shadow: 0 8px 25px rgba(0, 0, 0, 0.15) !important;
        }
        .stat-icon {
            width: 60px;
            height: 60px;
            border-radius: 12px;
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 1.5rem;
        }
        .chart-container {
            position: relative;
            height: 350px;
        }
        .table-actions .btn {
            padding: 0.25rem 0.5rem;
            font-size: 0.875rem;
        }
        .status-badge {
            font-size: 0.75rem;
            padding: 0.35rem 0.65rem;
        }
        .quick-action-btn {
            border-radius: 8px;
            padding: 0.75rem 1rem;
            transition: all 0.2s ease;
        }
        .quick-action-btn:hover {
            transform: translateY(-2px);
            box-shadow: 0 4px 12px rgba(0, 0, 0, 0.15);
        }
        .page-header {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            color: white;
            border-radius: 12px;
            padding: 2rem;
            margin-bottom: 2rem;
        }
        .breadcrumb {
            background: rgba(255, 255, 255, 0.1);
            border-radius: 8px;
            padding: 0.5rem 1rem;
        }
        .breadcrumb-item a {
            color: rgba(255, 255, 255, 0.8);
            text-decoration: none;
        }
        .breadcrumb-item.active {
            color: white;
        }
        .sidebar-wrapper {
            width: 250px;
            transition: margin-left 0.3s ease-in-out;
        }
        .sidebar-wrapper.toggled {
            margin-left: -250px;
        }
        #wrapper {
            overflow-x: hidden;
        }
        #page-content-wrapper {
            min-width: 0;
            width: 100%;
        }
    </style>
</head>
<body>
    <div class="d-flex" id="wrapper">
        <jsp:include page="includes/sidebar.jsp">
            <jsp:param name="activePage" value="users" />
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
                <!-- Page Header -->
                <div class="page-header">
                    <div class="d-flex justify-content-between align-items-center">
                        <div>
                            <h1 class="h2 mb-2">User List</h1>
                            <nav aria-label="breadcrumb">
                                <ol class="breadcrumb mb-0">
                                    <li class="breadcrumb-item">
                                        <a href="#"><i class="fas fa-home me-1"></i>Home</a>
                                    </li>
                                    <li class="breadcrumb-item active">User List</li>
                                </ol>
                            </nav>
                        </div>
                        <div>
                            <button class="btn btn-danger" onclick="exportToPDF()">
                                <i class="fas fa-file-pdf me-2"></i>Export PDF
                            </button>
                        </div>
                    </div>
                </div>

                <!-- Main Content -->
                <div class="row">
                    <div class="col-12">
                        <div class="card shadow-sm">
                            <div class="card-body">
                                <div class="table-responsive">
                                    <table class="table table-striped table-hover">
                                        <thead class="table-dark">
                                            <tr>
                                                <th>ID</th>
                                                <th>Username</th>
                                                <th>Full Name</th>
                                                <th>Birth</th>
                                                <th>Gender</th>
                                                <th>Email</th>
                                                <th>Phone</th>
                                                <th>Address</th>
                                                <th>Role</th>
                                                <th>Status</th>
                                            </tr>
                                        </thead>
                                        <tbody>
                                            <c:choose>
                                                <c:when test="${empty users}">
                                                    <tr>
                                                        <td colspan="10" class="text-center text-muted py-4">No users found or data not loaded.</td>
                                                    </tr>
                                                </c:when>
                                                <c:otherwise>
                                                    <c:forEach var="user" items="${users}">
                                                        <tr>
                                                            <td><c:out value="${user.id}"/></td>
                                                            <td><c:out value="${user.userName}"/></td>
                                                            <td><c:out value="${user.fullName}"/></td>
                                                            <td><c:out value="${user.birth}"/></td>
                                                            <td><c:out value="${user.gender}"/></td>
                                                            <td><c:out value="${user.email}"/></td>
                                                            <td><c:out value="${user.phone}"/></td>
                                                            <td><c:out value="${user.address}"/></td>
                                                            <td>
                                                                <span class="badge bg-primary"><c:out value="${user.role}"/></span>
                                                            </td>
                                                            <td>
                                                                <c:choose>
                                                                    <c:when test="${user.deleted}">
                                                                        <span class="badge bg-danger">Deleted</span>
                                                                    </c:when>
                                                                    <c:otherwise>
                                                                        <span class="badge bg-success">Active</span>
                                                                    </c:otherwise>
                                                                </c:choose>
                                                            </td>
                                                        </tr>
                                                    </c:forEach>
                                                </c:otherwise>
                                            </c:choose>
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
    <script src="https://cdnjs.cloudflare.com/ajax/libs/jspdf/2.5.1/jspdf.umd.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/jspdf-autotable/3.5.15/jspdf.plugin.autotable.min.js"></script>
    <script>
        document.getElementById('menu-toggle').addEventListener('click', function() {
            document.getElementById('wrapper').classList.toggle('toggled');
        });

        function exportToPDF() {
            const { jsPDF } = window.jspdf;
            const doc = new jsPDF();
            
            // Add title
            doc.setFontSize(18);
            doc.text('User List', 14, 22);
            
            // Prepare table data
            const tableRows = [];
            const headers = ['ID', 'Username', 'Full Name', 'Birth', 'Gender', 'Email', 'Phone', 'Address', 'Role', 'Status'];
            
            const tableBody = document.querySelector('.table tbody');
            const rows = tableBody.querySelectorAll('tr');
            
            rows.forEach(row => {
                const cells = row.querySelectorAll('td');
                if (cells.length > 0) {
                    const rowData = Array.from(cells).map(cell => cell.textContent.trim());
                    tableRows.push(rowData);
                }
            });
            
            // Generate table
            doc.autoTable({
                startY: 30,
                head: [headers],
                body: tableRows,
                theme: 'striped'
            });
            
            // Save the PDF
            doc.save('user_list.pdf');
        }
    </script>
</body>
</html> 