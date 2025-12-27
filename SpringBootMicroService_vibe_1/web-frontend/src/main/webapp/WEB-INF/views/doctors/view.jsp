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
                    <i class="fas fa-user-md"></i> Doctor Details
                </h1>
                <div>
                    <a href="/doctors" class="btn btn-secondary">
                        <i class="fas fa-arrow-left"></i> Back to Doctors
                    </a>
                    <a href="/doctors/${doctor.id}/edit" class="btn btn-warning">
                        <i class="fas fa-edit"></i> Edit
                    </a>
                    <a href="/appointments/doctor/${doctor.id}" class="btn btn-info">
                        <i class="fas fa-calendar"></i> View Appointments
                    </a>
                </div>
            </div>

            <!-- Doctor Profile Card -->
            <div class="card" style="margin-bottom: 2rem;">
                <div class="card-header">
                    <h3>
                        <i class="fas fa-id-card"></i>
                        Doctor Profile
                    </h3>
                </div>
                <div class="card-body">
                    <div class="profile-header">
                        <div class="profile-avatar">
                            <i class="fas fa-user-md"></i>
                        </div>
                        <div class="profile-info">
                            <h2>Dr. ${doctor.firstName} ${doctor.lastName}</h2>
                            <p class="subtitle">${doctor.specialization}</p>
                            <p class="department"><strong>Department:</strong> ${doctor.department}</p>
                            <c:if test="${not empty doctor.experienceYears}">
                                <p class="experience">
                                    <i class="fas fa-award"></i> ${doctor.experienceYears} years of experience
                                </p>
                            </c:if>
                        </div>
                    </div>
                </div>
            </div>

            <div class="grid-container">
                <!-- Personal Information -->
                <div class="card">
                    <div class="card-header">
                        <h3><i class="fas fa-user"></i> Personal Information</h3>
                    </div>
                    <div class="card-body">
                        <div class="detail-grid">
                            <div class="detail-item">
                                <label>Doctor ID:</label>
                                <span>${doctor.id}</span>
                            </div>
                            <div class="detail-item">
                                <label>Full Name:</label>
                                <span>${doctor.firstName} ${doctor.lastName}</span>
                            </div>
                            <c:if test="${not empty doctor.dateOfBirth}">
                                <div class="detail-item">
                                    <label>Date of Birth:</label>
                                    <span>
                                        <fmt:formatDate value="${doctor.availableFromTime}" pattern="MMM dd, yyyy"/>
                                    </span>
                                </div>
                            </c:if>
                            <c:if test="${not empty doctor.gender}">
                                <div class="detail-item">
                                    <label>Gender:</label>
                                    <span>${doctor.gender}</span>
                                </div>
                            </c:if>
                        </div>
                    </div>
                </div>

                <!-- Professional Information -->
                <div class="card">
                    <div class="card-header">
                        <h3><i class="fas fa-stethoscope"></i> Professional Information</h3>
                    </div>
                    <div class="card-body">
                        <div class="detail-grid">
                            <div class="detail-item">
                                <label>Specialization:</label>
                                <span class="badge badge-info">${doctor.specialization}</span>
                            </div>
                            <div class="detail-item">
                                <label>Department:</label>
                                <span>${doctor.department}</span>
                            </div>
                            <c:if test="${not empty doctor.licenseNumber}">
                                <div class="detail-item">
                                    <label>License Number:</label>
                                    <span>${doctor.licenseNumber}</span>
                                </div>
                            </c:if>
                            <c:if test="${not empty doctor.experienceYears}">
                                <div class="detail-item">
                                    <label>Experience:</label>
                                    <span>${doctor.experienceYears} years</span>
                                </div>
                            </c:if>
                        </div>
                    </div>
                </div>

                <!-- Contact Information -->
                <div class="card">
                    <div class="card-header">
                        <h3><i class="fas fa-address-book"></i> Contact Information</h3>
                    </div>
                    <div class="card-body">
                        <div class="detail-grid">
                            <c:if test="${not empty doctor.phoneNumber}">
                                <div class="detail-item">
                                    <label>Phone:</label>
                                    <span>
                                        <i class="fas fa-phone"></i>
                                        <a href="tel:${doctor.phoneNumber}">${doctor.phoneNumber}</a>
                                    </span>
                                </div>
                            </c:if>
                            <c:if test="${not empty doctor.email}">
                                <div class="detail-item">
                                    <label>Email:</label>
                                    <span>
                                        <i class="fas fa-envelope"></i>
                                        <a href="mailto:${doctor.email}">${doctor.email}</a>
                                    </span>
                                </div>
                            </c:if>
                            <c:if test="${not empty doctor.address}">
                                <div class="detail-item full-width">
                                    <label>Address:</label>
                                    <span>
                                        <i class="fas fa-map-marker-alt"></i>
                                        ${doctor.address}
                                    </span>
                                </div>
                            </c:if>
                        </div>
                    </div>
                </div>

                <!-- Additional Information -->
                <div class="card">
                    <div class="card-header">
                        <h3><i class="fas fa-info-circle"></i> Additional Information</h3>
                    </div>
                    <div class="card-body">
                        <div class="detail-grid">
                            <c:if test="${not empty doctor.qualifications}">
                                <div class="detail-item full-width">
                                    <label>Qualifications:</label>
                                    <span>${doctor.qualifications}</span>
                                </div>
                            </c:if>
                            <c:if test="${not empty doctor.consultationFee}">
                                <div class="detail-item">
                                    <label>Consultation Fee:</label>
                                    <span>
                                        <i class="fas fa-dollar-sign"></i>
                                        <fmt:formatNumber value="${doctor.consultationFee}" type="currency"/>
                                    </span>
                                </div>
                            </c:if>
                            <c:if test="${not empty doctor.availableHours}">
                                <div class="detail-item full-width">
                                    <label>Available Hours:</label>
                                    <span>
                                        <i class="fas fa-clock"></i>
                                        ${doctor.availableHours}
                                    </span>
                                </div>
                            </c:if>
                        </div>
                    </div>
                </div>
            </div>

            <!-- Action Buttons -->
            <div class="card" style="margin-top: 2rem;">
                <div class="card-body" style="text-align: center;">
                    <div class="action-buttons">
                        <a href="/appointments/new?doctorId=${doctor.id}" class="btn btn-primary">
                            <i class="fas fa-calendar-plus"></i> Schedule Appointment
                        </a>
                        <a href="/appointments/doctor/${doctor.id}" class="btn btn-info">
                            <i class="fas fa-calendar"></i> View All Appointments
                        </a>
                        <a href="/doctors/${doctor.id}/edit" class="btn btn-warning">
                            <i class="fas fa-edit"></i> Edit Doctor
                        </a>
                        <button onclick="confirmDelete(${doctor.id}, 'Dr. ${fn:escapeXml(doctor.lastName)}')"
                                class="btn btn-danger">
                            <i class="fas fa-trash"></i> Delete Doctor
                        </button>
                    </div>
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