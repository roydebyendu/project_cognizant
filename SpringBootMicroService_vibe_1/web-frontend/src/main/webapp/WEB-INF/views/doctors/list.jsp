<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>${title} - Patient Record Management System</title>
    <link rel="stylesheet" href="/css/style.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
</head>
<body>
    <!-- Header -->
    <header class="header">
        <div class="container">
            <a href="/" class="logo">
                <i class="fas fa-hospital-alt"></i>
                Patient Record Management System
            </a>
            <div class="header-info">
                <span class="current-time" id="currentTime"></span>
            </div>
        </div>
    </header>

    <!-- Navigation -->
    <nav class="navbar">
        <div class="container">
            <ul>
                <li><a href="/"><i class="fas fa-home"></i> Home</a></li>
                <li><a href="/dashboard"><i class="fas fa-tachometer-alt"></i> Dashboard</a></li>
                <li><a href="/patients"><i class="fas fa-user-injured"></i> Patients</a></li>
                <li><a href="/doctors" class="active"><i class="fas fa-user-md"></i> Doctors</a></li>
                <li><a href="/appointments"><i class="fas fa-calendar-alt"></i> Appointments</a></li>
            </ul>
        </div>
    </nav>

    <!-- Main Content -->
    <div class="container">
        <!-- Flash Messages -->
        <c:if test="${not empty success}">
            <div class="alert alert-success">
                <i class="fas fa-check-circle"></i> ${success}
            </div>
        </c:if>
       
        <c:if test="${not empty error}">
            <div class="alert alert-error">
                <i class="fas fa-exclamation-circle"></i> ${error}
            </div>
        </c:if>

        <main class="main-content">
            <div style="display: flex; justify-content: space-between; align-items: center; margin-bottom: 2rem;">
                <h1 class="page-title" style="margin-bottom: 0;">
                    <i class="fas fa-user-md"></i> Doctors Management
                </h1>
                <a href="/doctors/new" class="btn btn-primary">
                    <i class="fas fa-plus"></i> Add New Doctor
                </a>
            </div>

            <!-- Search Section -->
            <div class="card" style="margin-bottom: 2rem;">
                <div class="card-header">
                    <h3><i class="fas fa-search"></i> Search Doctors</h3>
                </div>
                <div class="card-body">
                    <form action="/doctors/search" method="get" class="search-form">
                        <div class="form-grid">
                            <div class="form-group">
                                <label for="firstName">First Name:</label>
                                <input type="text" id="firstName" name="firstName"
                                       value="${param.firstName}" placeholder="Enter first name">
                            </div>
                            <div class="form-group">
                                <label for="lastName">Last Name:</label>
                                <input type="text" id="lastName" name="lastName"
                                       value="${param.lastName}" placeholder="Enter last name">
                            </div>
                            <div class="form-group">
                                <label for="specialization">Specialization:</label>
                                <input type="text" id="specialization" name="specialization"
                                       value="${param.specialization}" placeholder="e.g., Cardiology">
                            </div>
                            <div class="form-group">
                                <label for="department">Department:</label>
                                <input type="text" id="department" name="department"
                                       value="${param.department}" placeholder="e.g., Internal Medicine">
                            </div>
                        </div>
                        <div class="form-actions">
                            <button type="submit" class="btn btn-primary">
                                <i class="fas fa-search"></i> Search
                            </button>
                            <a href="/doctors" class="btn btn-secondary">
                                <i class="fas fa-undo"></i> Clear
                            </a>
                        </div>
                    </form>
                </div>
            </div>

            <!-- Doctors Table -->
            <div class="card">
                <div class="card-header">
                    <h3>
                        <i class="fas fa-list"></i>
                        Doctors List
                        <c:if test="${not empty doctors}">
                            <span class="badge">${fn:length(doctors)} doctor(s)</span>
                        </c:if>
                    </h3>
                </div>
                <div class="card-body">
                    <c:choose>
                        <c:when test="${not empty doctors}">
                            <div class="table-responsive">
                                <table class="table">
                                    <thead>
                                        <tr>
                                            <th>ID</th>
                                            <th>Name</th>
                                            <th>Specialization</th>
                                            <th>Department</th>
                                            <th>Phone</th>
                                            <th>Email</th>
                                            <th>Experience</th>
                                            <th>Actions</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                        <c:forEach var="doctor" items="${doctors}">
                                            <tr>
                                                <td>${doctor.id}</td>
                                                <td>
                                                    <div class="user-info">
                                                        <div class="user-avatar">
                                                            <i class="fas fa-user-md"></i>
                                                        </div>
                                                        <div>
                                                            <strong>${doctor.firstName} ${doctor.lastName}</strong>
                                                            <small class="text-muted">Dr. ${doctor.lastName}</small>
                                                        </div>
                                                    </div>
                                                </td>
                                                <td>
                                                    <span class="badge badge-info">${doctor.specialization}</span>
                                                </td>
                                                <td>${doctor.department}</td>
                                                <td>
                                                    <c:if test="${not empty doctor.phoneNumber}">
                                                        <i class="fas fa-phone"></i> ${doctor.phoneNumber}
                                                    </c:if>
                                                </td>
                                                <td>
                                                    <c:if test="${not empty doctor.email}">
                                                        <i class="fas fa-envelope"></i> ${doctor.email}
                                                    </c:if>
                                                </td>
                                                <td>${doctor.experienceYears} years</td>
                                                <td>
                                                    <div class="action-buttons">
                                                        <a href="/doctors/${doctor.id}"
                                                           class="btn btn-small btn-info"
                                                           title="View Details">
                                                            <i class="fas fa-eye"></i>
                                                        </a>
                                                        <a href="/doctors/${doctor.id}/edit"
                                                           class="btn btn-small btn-warning"
                                                           title="Edit">
                                                            <i class="fas fa-edit"></i>
                                                        </a>
                                                        <a href="/appointments/doctor/${doctor.id}"
                                                           class="btn btn-small btn-success"
                                                           title="View Appointments">
                                                            <i class="fas fa-calendar"></i>
                                                        </a>
                                                        <button onclick="confirmDelete('${doctor.id}', 'Dr. ${fn:escapeXml(doctor.lastName)}')"
                                                                class="btn btn-small btn-danger"
                                                                title="Delete">
                                                            <i class="fas fa-trash"></i>
                                                        </button>
                                                    </div>
                                                </td>
                                            </tr>
                                        </c:forEach>
                                    </tbody>
                                </table>
                            </div>
                        </c:when>
                        <c:otherwise>
                            <div class="empty-state">
                                <div class="empty-icon">
                                    <i class="fas fa-user-md"></i>
                                </div>
                                <h3>No Doctors Found</h3>
                                <p>No doctors match your search criteria or no doctors have been added yet.</p>
                                <a href="/doctors/new" class="btn btn-primary">
                                    <i class="fas fa-plus"></i> Add First Doctor
                                </a>
                            </div>
                        </c:otherwise>
                    </c:choose>
                </div>
            </div>
        </main>
    </div>

    <!-- Delete Confirmation Modal -->
    <div id="deleteModal" class="modal">
        <div class="modal-content">
            <div class="modal-header">
                <h3><i class="fas fa-exclamation-triangle"></i> Confirm Delete</h3>
                <span class="close">&times;</span>
            </div>
            <div class="modal-body">
                <p>Are you sure you want to delete <strong id="doctorName"></strong>?</p>
                <p class="text-warning">
                    <i class="fas fa-warning"></i>
                    This action cannot be undone and may affect existing appointments.
                </p>
            </div>
            <div class="modal-footer">
                <form id="deleteForm" method="post" style="display: inline;">
                    <button type="button" class="btn btn-secondary close-modal">Cancel</button>
                    <button type="submit" class="btn btn-danger">
                        <i class="fas fa-trash"></i> Delete Doctor
                    </button>
                </form>
            </div>
        </div>
    </div>

    <!-- Scripts -->
    <script src="/js/main.js"></script>
    <script>
        function confirmDelete(doctorId, doctorName) {
            document.getElementById('doctorName').textContent = doctorName;
            document.getElementById('deleteForm').action = '/doctors/' + doctorId + '/delete';
            showModal('deleteModal');
        }

        // Initialize time display
        updateTime();
        setInterval(updateTime, 1000);
    </script>

</body>
</html>