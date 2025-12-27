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
                    <i class="fas fa-calendar-user"></i> ${title}
                </h1>
                <div>
                    <a href="/appointments" class="btn btn-secondary">
                        <i class="fas fa-arrow-left"></i> All Appointments
                    </a>
                    <a href="/appointments/new?doctorId=${doctor.id}" class="btn btn-primary">
                        <i class="fas fa-plus"></i> Schedule New Appointment
                    </a>
                </div>
            </div>

            <!-- Doctor Information Card -->
            <c:if test="${not empty doctor}">
                <div class="card" style="margin-bottom: 2rem;">
                    <div class="card-header">
                        <h3><i class="fas fa-user-md"></i> Doctor Information</h3>
                    </div>
                    <div class="card-body">
                        <div class="doctor-profile">
                            <div class="doctor-avatar">
                                <i class="fas fa-user-md"></i>
                            </div>
                            <div class="doctor-details">
                                <h3>Dr. ${doctor.firstName} ${doctor.lastName}</h3>
                                <p class="doctor-id">Doctor ID: ${doctor.id}</p>
                                <div class="doctor-meta">
                                    <span class="specialization">
                                        <i class="fas fa-stethoscope"></i> ${doctor.specialization}
                                    </span>
                                    <span class="department">
                                        <i class="fas fa-building"></i> ${doctor.department}
                                    </span>
                                    <c:if test="${not empty doctor.experienceYears}">
                                        <span class="experience">
                                            <i class="fas fa-award"></i> ${doctor.experienceYears} years experience
                                        </span>
                                    </c:if>
                                </div>
                                <div class="doctor-contact">
                                    <c:if test="${not empty doctor.phone}">
                                        <span><i class="fas fa-phone"></i> ${doctor.phone}</span>
                                    </c:if>
                                    <c:if test="${not empty doctor.email}">
                                        <span><i class="fas fa-envelope"></i> ${doctor.email}</span>
                                    </c:if>
                                </div>
                            </div>
                            <div class="doctor-actions">
                                <a href="/doctors/${doctor.id}" class="btn btn-info">
                                    <i class="fas fa-eye"></i> View Doctor
                                </a>
                            </div>
                        </div>
                    </div>
                </div>
            </c:if>

            <!-- Today's Schedule Summary -->
            <c:if test="${not empty appointments}">
                <div class="card" style="margin-bottom: 2rem;">
                    <div class="card-header">
                        <h3><i class="fas fa-calendar-day"></i> Schedule Summary</h3>
                    </div>
                    <div class="card-body">
                        <c:set var="todayAppointments" value="0"/>
                        <c:set var="scheduledCount" value="0"/>
                        <c:set var="completedCount" value="0"/>
                       
                        <fmt:formatDate value="${new java.util.Date()}" pattern="yyyy-MM-dd" var="today"/>
                       
                        <c:forEach var="appointment" items="${appointments}">
                            <fmt:formatDate value="${appointment.appointmentDateTime}" pattern="yyyy-MM-dd" var="appointmentDate"/>
                            <c:if test="${appointmentDate == today}">
                                <c:set var="todayAppointments" value="${todayAppointments + 1}"/>
                            </c:if>
                            <c:if test="${appointment.status == 'SCHEDULED' || appointment.status == 'CONFIRMED'}">
                                <c:set var="scheduledCount" value="${scheduledCount + 1}"/>
                            </c:if>
                            <c:if test="${appointment.status == 'COMPLETED'}">
                                <c:set var="completedCount" value="${completedCount + 1}"/>
                            </c:if>
                        </c:forEach>
                       
                        <div class="stats-grid">
                            <div class="stat-item">
                                <div class="stat-icon">
                                    <i class="fas fa-calendar"></i>
                                </div>
                                <div class="stat-content">
                                    <h4>${fn:length(appointments)}</h4>
                                    <p>Total Appointments</p>
                                </div>
                            </div>
                            <div class="stat-item">
                                <div class="stat-icon">
                                    <i class="fas fa-calendar-day"></i>
                                </div>
                                <div class="stat-content">
                                    <h4>${todayAppointments}</h4>
                                    <p>Today's Appointments</p>
                                </div>
                            </div>
                            <div class="stat-item">
                                <div class="stat-icon">
                                    <i class="fas fa-clock"></i>
                                </div>
                                <div class="stat-content">
                                    <h4>${scheduledCount}</h4>
                                    <p>Scheduled</p>
                                </div>
                            </div>
                            <div class="stat-item">
                                <div class="stat-icon">
                                    <i class="fas fa-check-circle"></i>
                                </div>
                                <div class="stat-content">
                                    <h4>${completedCount}</h4>
                                    <p>Completed</p>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </c:if>

            <!-- Appointments Table -->
            <div class="card">
                <div class="card-header">
                    <h3>
                        <i class="fas fa-calendar-alt"></i>
                        Doctor's Schedule
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
                                            <th>Date & Time</th>
                                            <th>Patient</th>
                                            <th>Type</th>
                                            <th>Status</th>
                                            <th>Reason</th>
                                            <th>Notes</th>
                                            <th>Actions</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                        <c:forEach var="appointment" items="${appointments}">
                                            <tr class="${appointment.status == 'COMPLETED' ? 'completed-appointment' : ''}">
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
                                                    <div class="patient-info">
                                                        <i class="fas fa-user-injured"></i>
                                                        <strong>${appointment.patientName}</strong>
                                                        <small class="text-muted">ID: ${appointment.patientId}</small>
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
                                                        <c:when test="${appointment.status == 'CONFIRMED'}">
                                                            <span class="badge badge-info">
                                                                <i class="fas fa-check-circle"></i> Confirmed
                                                            </span>
                                                        </c:when>
                                                        <c:when test="${appointment.status == 'IN_PROGRESS'}">
                                                            <span class="badge badge-primary">
                                                                <i class="fas fa-play"></i> In Progress
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
                                                        <c:when test="${not empty appointment.reason && fn:length(appointment.reason) > 30}">
                                                            <span title="${appointment.reason}">
                                                                ${fn:substring(appointment.reason, 0, 30)}...
                                                            </span>
                                                        </c:when>
                                                        <c:otherwise>
                                                            ${appointment.reason}
                                                        </c:otherwise>
                                                    </c:choose>
                                                </td>
                                                <td>
                                                    <c:choose>
                                                        <c:when test="${not empty appointment.notes && fn:length(appointment.notes) > 30}">
                                                            <span title="${appointment.notes}">
                                                                ${fn:substring(appointment.notes, 0, 30)}...
                                                            </span>
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
                                                        <c:if test="${appointment.status == 'SCHEDULED' || appointment.status == 'CONFIRMED'}">
                                                            <button onclick="updateStatus('${appointment.id}', 'IN_PROGRESS')"
                                                                    class="btn btn-small btn-primary"
                                                                    title="Start Appointment">
                                                                <i class="fas fa-play"></i>
                                                            </button>
                                                            <button onclick="updateStatus('${appointment.id}', 'COMPLETED')"
                                                                    class="btn btn-small btn-success"
                                                                    title="Mark as Completed">
                                                                <i class="fas fa-check"></i>
                                                            </button>
                                                        </c:if>
                                                        <c:if test="${appointment.status != 'COMPLETED' && appointment.status != 'CANCELLED'}">
                                                            <a href="/appointments/${appointment.id}/edit"
                                                               class="btn btn-small btn-warning"
                                                               title="Edit">
                                                                <i class="fas fa-edit"></i>
                                                            </a>
                                                        </c:if>
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
                                <p>This doctor has no appointments scheduled.</p>
                                <a href="/appointments/new?doctorId=${doctor.id}" class="btn btn-primary">
                                    <i class="fas fa-plus"></i> Schedule First Appointment
                                </a>
                            </div>
                        </c:otherwise>
                    </c:choose>
                </div>
            </div>
        </main>
    </div>

    <!-- Scripts -->
    <script src="/js/main.js"></script>
    <script>
        function updateStatus(appointmentId, status) {
            let confirmMessage = 'Are you sure you want to update the appointment status to ' + status + '?';
            if (status === 'IN_PROGRESS') {
                confirmMessage = 'Are you sure you want to start this appointment?';
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