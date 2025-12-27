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
                <li><a href="/doctors"><i class="fas fa-user-md"></i> Doctors</a></li>
                <li><a href="/appointments" class="active"><i class="fas fa-calendar-alt"></i> Appointments</a></li>
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
                    <i class="fas fa-calendar-alt"></i> Appointments Management
                </h1>
                <a href="/appointments/new" class="btn btn-primary">
                    <i class="fas fa-plus"></i> Schedule New Appointment
                </a>
            </div>

            <!-- Quick Stats -->
            <div class="stats-grid" style="margin-bottom: 2rem;">
                <c:if test="${not empty appointments}">
                    <div class="stat-card">
                        <div class="stat-icon">
                            <i class="fas fa-calendar"></i>
                        </div>
                        <div class="stat-content">
                            <h3>${fn:length(appointments)}</h3>
                            <p>Total Appointments</p>
                        </div>
                    </div>
                   
                    <c:set var="scheduledCount" value="0"/>
                    <c:set var="completedCount" value="0"/>
                    <c:set var="cancelledCount" value="0"/>
                    <c:forEach var="appointment" items="${appointments}">
                        <c:choose>
                            <c:when test="${appointment.status == 'SCHEDULED'}">
                                <c:set var="scheduledCount" value="${scheduledCount + 1}"/>
                            </c:when>
                            <c:when test="${appointment.status == 'COMPLETED'}">
                                <c:set var="completedCount" value="${completedCount + 1}"/>
                            </c:when>
                            <c:when test="${appointment.status == 'CANCELLED'}">
                                <c:set var="cancelledCount" value="${cancelledCount + 1}"/>
                            </c:when>
                        </c:choose>
                    </c:forEach>
                   
                    <div class="stat-card stat-scheduled">
                        <div class="stat-icon">
                            <i class="fas fa-clock"></i>
                        </div>
                        <div class="stat-content">
                            <h3>${scheduledCount}</h3>
                            <p>Scheduled</p>
                        </div>
                    </div>
                   
                    <div class="stat-card stat-completed">
                        <div class="stat-icon">
                            <i class="fas fa-check-circle"></i>
                        </div>
                        <div class="stat-content">
                            <h3>${completedCount}</h3>
                            <p>Completed</p>
                        </div>
                    </div>
                   
                    <div class="stat-card stat-cancelled">
                        <div class="stat-icon">
                            <i class="fas fa-times-circle"></i>
                        </div>
                        <div class="stat-content">
                            <h3>${cancelledCount}</h3>
                            <p>Cancelled</p>
                        </div>
                    </div>
                </c:if>
            </div>

            <!-- Appointments Table -->
            <div class="card">
                <div class="card-header">
                    <h3>
                        <i class="fas fa-list"></i>
                        Appointments List
                        <c:if test="${not empty appointments}">
                            <span class="badge">${fn:length(appointments)} appointment(s)</span>
                        </c:if>
                    </h3>
                </div>
                <div class="card-body">
                    <c:choose>
                        <c:when test="${not empty appointments}">
                            <div class="table-responsive">
                                <table class="table">
                                    <thead>
                                        <tr>
                                            <th>ID</th>
                                            <th>Date & Time</th>
                                            <th>Patient</th>
                                            <th>Doctor</th>
                                            <th>Type</th>
                                            <th>Status</th>
                                            <th>Notes</th>
                                            <th>Actions</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                        <c:forEach var="appointment" items="${appointments}">
                                            <tr>
                                                <td>${appointment.id}</td>
                                                <td>
                                                    <div class="appointment-datetime">
                                                        <div class="date">
                                                            <i class="fas fa-calendar"></i>
                                                            <fmt:formatDate value="${appointment.appointmentDateTime}" pattern="MMM dd, yyyy"/>
                                                        </div>
                                                        <div class="time">
                                                            <i class="fas fa-clock"></i>
                                                            <fmt:formatDate value="${appointment.appointmentDateTime}" pattern="HH:mm"/>
                                                        </div>
                                                    </div>
                                                </td>
                                                <td>
                                                    <div class="user-info">
                                                        <div class="user-avatar">
                                                            <i class="fas fa-user-injured"></i>
                                                        </div>
                                                        <div>
                                                            <strong>
                                                                <c:choose>
                                                                    <c:when test="${not empty appointment.patientName}">
                                                                        ${appointment.patientName}
                                                                    </c:when>
                                                                    <c:otherwise>
                                                                        Patient ID: ${appointment.patientId}
                                                                    </c:otherwise>
                                                                </c:choose>
                                                            </strong>
                                                            <small class="text-muted">ID: ${appointment.patientId}</small>
                                                        </div>
                                                    </div>
                                                </td>
                                                <td>
                                                    <div class="user-info">
                                                        <div class="user-avatar">
                                                            <i class="fas fa-user-md"></i>
                                                        </div>
                                                        <div>
                                                            <strong>
                                                                <c:choose>
                                                                    <c:when test="${not empty appointment.doctorName}">
                                                                        Dr. ${appointment.doctorName}
                                                                    </c:when>
                                                                    <c:otherwise>
                                                                        Doctor ID: ${appointment.doctorId}
                                                                    </c:otherwise>
                                                                </c:choose>
                                                            </strong>
                                                            <small class="text-muted">ID: ${appointment.doctorId}</small>
                                                        </div>
                                                    </div>
                                                </td>
                                                <td>
                                                    <c:if test="${not empty appointment.appointmentType}">
                                                        <span class="badge badge-info">${appointment.appointmentType}</span>
                                                    </c:if>
                                                </td>
                                                <td>
                                                    <c:choose>
                                                        <c:when test="${appointment.status == 'SCHEDULED'}">
                                                            <span class="badge badge-warning">
                                                                <i class="fas fa-clock"></i> Scheduled
                                                            </span>
                                                        </c:when>
                                                        <c:when test="${appointment.status == 'COMPLETED'}">
                                                            <span class="badge badge-success">
                                                                <i class="fas fa-check"></i> Completed
                                                            </span>
                                                        </c:when>
                                                        <c:when test="${appointment.status == 'CANCELLED'}">
                                                            <span class="badge badge-danger">
                                                                <i class="fas fa-times"></i> Cancelled
                                                            </span>
                                                        </c:when>
                                                        <c:otherwise>
                                                            <span class="badge badge-secondary">${appointment.status}</span>
                                                        </c:otherwise>
                                                    </c:choose>
                                                </td>
                                                <td>
                                                    <c:choose>
                                                        <c:when test="${not empty appointment.notes && fn:length(appointment.notes) > 50}">
                                                            ${fn:substring(appointment.notes, 0, 50)}...
                                                        </c:when>
                                                        <c:otherwise>
                                                            ${appointment.notes}
                                                        </c:otherwise>
                                                    </c:choose>
                                                </td>
                                                <td>
                                                    <div class="action-buttons">
                                                        <a href="/appointments/${appointment.id}"
                                                           class="btn btn-small btn-info"
                                                           title="View Details">
                                                            <i class="fas fa-eye"></i>
                                                        </a>
                                                        <c:if test="${appointment.status != 'COMPLETED' && appointment.status != 'CANCELLED'}">
                                                            <a href="/appointments/${appointment.id}/edit"
                                                               class="btn btn-small btn-warning"
                                                               title="Edit">
                                                                <i class="fas fa-edit"></i>
                                                            </a>
                                                        </c:if>
                                                        <c:if test="${appointment.status == 'SCHEDULED'}">
                                                            <button onclick="updateStatus('${appointment.id}', 'COMPLETED')"
                                                                    class="btn btn-small btn-success"
                                                                    title="Mark as Completed">
                                                                <i class="fas fa-check"></i>
                                                            </button>
                                                            <button onclick="updateStatus('${appointment.id}', 'CANCELLED')"
                                                                    class="btn btn-small btn-danger"
                                                                    title="Cancel">
                                                                <i class="fas fa-times"></i>
                                                            </button>
                                                        </c:if>
                                                        <button onclick="confirmDelete('${appointment.id}')"
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
                                    <i class="fas fa-calendar-alt"></i>
                                </div>
                                <h3>No Appointments Found</h3>
                                <p>No appointments have been scheduled yet.</p>
                                <a href="/appointments/new" class="btn btn-primary">
                                    <i class="fas fa-plus"></i> Schedule First Appointment
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
                <p>Are you sure you want to delete this appointment?</p>
                <p class="text-warning">
                    <i class="fas fa-warning"></i>
                    This action cannot be undone.
                </p>
            </div>
            <div class="modal-footer">
                <form id="deleteForm" method="post" style="display: inline;">
                    <button type="button" class="btn btn-secondary close-modal">Cancel</button>
                    <button type="submit" class="btn btn-danger">
                        <i class="fas fa-trash"></i> Delete Appointment
                    </button>
                </form>
            </div>
        </div>
    </div>

    <!-- Scripts -->
    <script src="/js/main.js"></script>
    <script>
        function confirmDelete(appointmentId) {
            document.getElementById('deleteForm').action = '/appointments/' + appointmentId + '/delete';
            showModal('deleteModal');
        }

        function updateStatus(appointmentId, status) {
            if (confirm('Are you sure you want to update the appointment status to ' + status + '?')) {
                // Create and submit form
                const form = document.createElement('form');
                form.method = 'post';
                form.action = '/appointments/' + appointmentId + '/status/' + status;
                document.body.appendChild(form);
                form.submit();
            }
        }

        // Initialize time display
        updateTime();
        setInterval(updateTime, 1000);
    </script>

</body>
</html>