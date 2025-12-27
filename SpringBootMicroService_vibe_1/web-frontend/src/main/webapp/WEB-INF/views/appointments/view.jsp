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
                    <i class="fas fa-calendar-alt"></i> Appointment Details
                </h1>
                <div>
                    <a href="/appointments" class="btn btn-secondary">
                        <i class="fas fa-arrow-left"></i> Back to Appointments
                    </a>
                    <c:if test="${appointment.status != 'COMPLETED' && appointment.status != 'CANCELLED'}">
                        <a href="/appointments/${appointment.id}/edit" class="btn btn-warning">
                            <i class="fas fa-edit"></i> Edit
                        </a>
                    </c:if>
                </div>
            </div>

            <!-- Appointment Status Card -->
            <div class="card" style="margin-bottom: 2rem;">
                <div class="card-header">
                    <h3>
                        <i class="fas fa-info-circle"></i>
                        Appointment Overview
                    </h3>
                </div>
                <div class="card-body">
                    <div class="appointment-overview">
                        <div class="appointment-status">
                            <c:choose>
                                <c:when test="${appointment.status == 'SCHEDULED'}">
                                    <span class="status-badge status-scheduled">
                                        <i class="fas fa-clock"></i> Scheduled
                                    </span>
                                </c:when>
                                <c:when test="${appointment.status == 'CONFIRMED'}">
                                    <span class="status-badge status-confirmed">
                                        <i class="fas fa-check-circle"></i> Confirmed
                                    </span>
                                </c:when>
                                <c:when test="${appointment.status == 'IN_PROGRESS'}">
                                    <span class="status-badge status-in-progress">
                                        <i class="fas fa-play-circle"></i> In Progress
                                    </span>
                                </c:when>
                                <c:when test="${appointment.status == 'COMPLETED'}">
                                    <span class="status-badge status-completed">
                                        <i class="fas fa-check"></i> Completed
                                    </span>
                                </c:when>
                                <c:when test="${appointment.status == 'CANCELLED'}">
                                    <span class="status-badge status-cancelled">
                                        <i class="fas fa-times"></i> Cancelled
                                    </span>
                                </c:when>
                                <c:otherwise>
                                    <span class="status-badge status-default">${appointment.status}</span>
                                </c:otherwise>
                            </c:choose>
                        </div>
                       
                        <div class="appointment-datetime">
                            <div class="datetime-item">
                                <i class="fas fa-calendar"></i>
                                <span class="datetime-label">Date:</span>
                                <span class="datetime-value">
                                    <fmt:formatDate value="${appointment.appointmentDateTime}" pattern="EEEE, MMMM dd, yyyy"/>
                                </span>
                            </div>
                            <div class="datetime-item">
                                <i class="fas fa-clock"></i>
                                <span class="datetime-label">Time:</span>
                                <span class="datetime-value">
                                    <fmt:formatDate value="${appointment.appointmentDateTime}" pattern="hh:mm a"/>
                                </span>
                            </div>
                            <c:if test="${not empty appointment.duration}">
                                <div class="datetime-item">
                                    <i class="fas fa-hourglass-half"></i>
                                    <span class="datetime-label">Duration:</span>
                                    <span class="datetime-value">${appointment.duration} minutes</span>
                                </div>
                            </c:if>
                        </div>
                    </div>
                </div>
            </div>

            <div class="grid-container">
                <!-- Patient Information -->
                <div class="card">
                    <div class="card-header">
                        <h3><i class="fas fa-user-injured"></i> Patient Information</h3>
                    </div>
                    <div class="card-body">
                        <c:choose>
                            <c:when test="${not empty patient}">
                                <div class="patient-card">
                                    <div class="patient-avatar">
                                        <i class="fas fa-user-injured"></i>
                                    </div>
                                    <div class="patient-info">
                                        <h4>${patient.firstName} ${patient.lastName}</h4>
                                        <p class="patient-id">Patient ID: ${patient.id}</p>
                                        <c:if test="${not empty patient.dateOfBirth}">
                                            <p><i class="fas fa-birthday-cake"></i>
                                               <fmt:formatDate value="${patient.dateOfBirth}" pattern="MMM dd, yyyy"/>
                                            </p>
                                        </c:if>
                                        <c:if test="${not empty patient.phone}">
                                            <p><i class="fas fa-phone"></i>
                                               <a href="tel:${patient.phone}">${patient.phone}</a>
                                            </p>
                                        </c:if>
                                        <c:if test="${not empty patient.email}">
                                            <p><i class="fas fa-envelope"></i>
                                               <a href="mailto:${patient.email}">${patient.email}</a>
                                            </p>
                                        </c:if>
                                    </div>
                                </div>
                                <div class="card-actions">
                                    <a href="/patients/${patient.id}" class="btn btn-small btn-info">
                                        <i class="fas fa-eye"></i> View Patient
                                    </a>
                                    <a href="/appointments/patient/${patient.id}" class="btn btn-small btn-secondary">
                                        <i class="fas fa-calendar"></i> All Appointments
                                    </a>
                                </div>
                            </c:when>
                            <c:otherwise>
                                <div class="error-message">
                                    <i class="fas fa-exclamation-triangle"></i>
                                    <p>Patient information could not be loaded.</p>
                                    <small>Patient ID: ${appointment.patientId}</small>
                                </div>
                            </c:otherwise>
                        </c:choose>
                    </div>
                </div>

                <!-- Doctor Information -->
                <div class="card">
                    <div class="card-header">
                        <h3><i class="fas fa-user-md"></i> Doctor Information</h3>
                    </div>
                    <div class="card-body">
                        <c:choose>
                            <c:when test="${not empty doctor}">
                                <div class="doctor-card">
                                    <div class="doctor-avatar">
                                        <i class="fas fa-user-md"></i>
                                    </div>
                                    <div class="doctor-info">
                                        <h4>Dr. ${doctor.firstName} ${doctor.lastName}</h4>
                                        <p class="doctor-id">Doctor ID: ${doctor.id}</p>
                                        <p class="specialization">
                                            <i class="fas fa-stethoscope"></i> ${doctor.specialization}
                                        </p>
                                        <p class="department">
                                            <i class="fas fa-building"></i> ${doctor.department}
                                        </p>
                                        <c:if test="${not empty doctor.phone}">
                                            <p><i class="fas fa-phone"></i>
                                               <a href="tel:${doctor.phone}">${doctor.phone}</a>
                                            </p>
                                        </c:if>
                                    </div>
                                </div>
                                <div class="card-actions">
                                    <a href="/doctors/${doctor.id}" class="btn btn-small btn-info">
                                        <i class="fas fa-eye"></i> View Doctor
                                    </a>
                                    <a href="/appointments/doctor/${doctor.id}" class="btn btn-small btn-secondary">
                                        <i class="fas fa-calendar"></i> All Appointments
                                    </a>
                                </div>
                            </c:when>
                            <c:otherwise>
                                <div class="error-message">
                                    <i class="fas fa-exclamation-triangle"></i>
                                    <p>Doctor information could not be loaded.</p>
                                    <small>Doctor ID: ${appointment.doctorId}</small>
                                </div>
                            </c:otherwise>
                        </c:choose>
                    </div>
                </div>

                <!-- Appointment Details -->
                <div class="card">
                    <div class="card-header">
                        <h3><i class="fas fa-clipboard"></i> Appointment Details</h3>
                    </div>
                    <div class="card-body">
                        <div class="detail-grid">
                            <div class="detail-item">
                                <label>Appointment ID:</label>
                                <span>${appointment.id}</span>
                            </div>
                            <c:if test="${not empty appointment.appointmentType}">
                                <div class="detail-item">
                                    <label>Type:</label>
                                    <span class="badge badge-info">${appointment.appointmentType}</span>
                                </div>
                            </c:if>
                            <c:if test="${not empty appointment.priority}">
                                <div class="detail-item">
                                    <label>Priority:</label>
                                    <c:choose>
                                        <c:when test="${appointment.priority == 'URGENT'}">
                                            <span class="badge badge-danger">${appointment.priority}</span>
                                        </c:when>
                                        <c:when test="${appointment.priority == 'HIGH'}">
                                            <span class="badge badge-warning">${appointment.priority}</span>
                                        </c:when>
                                        <c:otherwise>
                                            <span class="badge badge-secondary">${appointment.priority}</span>
                                        </c:otherwise>
                                    </c:choose>
                                </div>
                            </c:if>
                            <c:if test="${not empty appointment.reason}">
                                <div class="detail-item full-width">
                                    <label>Reason for Visit:</label>
                                    <span>${appointment.reason}</span>
                                </div>
                            </c:if>
                            <c:if test="${not empty appointment.notes}">
                                <div class="detail-item full-width">
                                    <label>Notes:</label>
                                    <span>${appointment.notes}</span>
                                </div>
                            </c:if>
                        </div>
                    </div>
                </div>
            </div>

            <!-- Status Update Actions -->
            <c:if test="${appointment.status == 'SCHEDULED' || appointment.status == 'CONFIRMED'}">
                <div class="card" style="margin-top: 2rem;">
                    <div class="card-header">
                        <h3><i class="fas fa-tasks"></i> Quick Actions</h3>
                    </div>
                    <div class="card-body" style="text-align: center;">
                        <div class="action-buttons">
                            <c:if test="${appointment.status == 'SCHEDULED'}">
                                <button onclick="updateStatus('${appointment.id}', 'CONFIRMED')"
                                        class="btn btn-success">
                                    <i class="fas fa-check-circle"></i> Confirm Appointment
                                </button>
                                <button onclick="updateStatus('${appointment.id}', 'IN_PROGRESS')"
                                        class="btn btn-info">
                                    <i class="fas fa-play"></i> Start Appointment
                                </button>
                            </c:if>
                            <c:if test="${appointment.status == 'CONFIRMED' || appointment.status == 'SCHEDULED'}">
                                <button onclick="updateStatus('${appointment.id}', 'COMPLETED')"
                                        class="btn btn-primary">
                                    <i class="fas fa-check"></i> Mark as Completed
                                </button>
                                <button onclick="updateStatus('${appointment.id}', 'CANCELLED')"
                                        class="btn btn-warning">
                                    <i class="fas fa-times"></i> Cancel Appointment
                                </button>
                            </c:if>
                            <a href="/appointments/${appointment.id}/edit" class="btn btn-secondary">
                                <i class="fas fa-edit"></i> Edit Details
                            </a>
                            <button onclick="confirmDelete('${appointment.id}')"
                                    class="btn btn-danger">
                                <i class="fas fa-trash"></i> Delete Appointment
                            </button>
                        </div>
                    </div>
                </div>
            </c:if>
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
            let confirmMessage = 'Are you sure you want to update the appointment status to ' + status + '?';
            if (status === 'CANCELLED') {
                confirmMessage = 'Are you sure you want to cancel this appointment?';
            } else if (status === 'COMPLETED') {
                confirmMessage = 'Are you sure you want to mark this appointment as completed?';
            }
           
            if (confirm(confirmMessage)) {
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