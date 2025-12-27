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
                <li><a href="/patients" class="active"><i class="fas fa-user-injured"></i> Patients</a></li>
                <li><a href="/doctors"><i class="fas fa-user-md"></i> Doctors</a></li>
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
                    <i class="fas fa-user-injured"></i> Patient Details
                </h1>
                <div>
                    <a href="/patients" class="btn btn-secondary">
                        <i class="fas fa-arrow-left"></i> Back to Patients
                    </a>
                    <a href="/patients/${patient.id}/edit" class="btn btn-warning">
                        <i class="fas fa-edit"></i> Edit
                    </a>
                    <a href="/appointments/patient/${patient.id}" class="btn btn-info">
                        <i class="fas fa-calendar"></i> View Appointments
                    </a>
                </div>
            </div>

            <!-- Patient Profile Card -->
            <div class="card" style="margin-bottom: 2rem;">
                <div class="card-header">
                    <h3>
                        <i class="fas fa-id-card"></i>
                        Patient Profile
                    </h3>
                </div>
                <div class="card-body">
                    <div class="profile-header">
                        <div class="profile-avatar">
                            <i class="fas fa-user-injured"></i>
                        </div>
                        <div class="profile-info">
                            <h2>${patient.firstName} ${patient.lastName}</h2>
                            <p class="subtitle">Patient ID: ${patient.id}</p>
                            <c:if test="${not empty patient.dateOfBirth}">
                                <p class="age">
                                    <i class="fas fa-birthday-cake"></i>
                                    <fmt:formatDate value="${patient.dateOfBirth}" pattern="MMM dd, yyyy"/>
                                </p>
                            </c:if>
                            <c:if test="${not empty patient.bloodGroup}">
                                <p class="blood-group">
                                    <i class="fas fa-tint"></i> Blood Group: ${patient.bloodGroup}
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
                                <label>Patient ID:</label>
                                <span>${patient.id}</span>
                            </div>
                            <div class="detail-item">
                                <label>Full Name:</label>
                                <span>${patient.firstName} ${patient.lastName}</span>
                            </div>
                            <c:if test="${not empty patient.dateOfBirth}">
                                <div class="detail-item">
                                    <label>Date of Birth:</label>
                                    <span>
                                        <fmt:formatDate value="${patient.dateOfBirth}" pattern="MMM dd, yyyy"/>
                                    </span>
                                </div>
                            </c:if>
                            <c:if test="${not empty patient.gender}">
                                <div class="detail-item">
                                    <label>Gender:</label>
                                    <span>${patient.gender}</span>
                                </div>
                            </c:if>
                            <c:if test="${not empty patient.bloodGroup}">
                                <div class="detail-item">
                                    <label>Blood Group:</label>
                                    <span class="badge badge-danger">${patient.bloodGroup}</span>
                                </div>
                            </c:if>
                            <c:if test="${not empty patient.maritalStatus}">
                                <div class="detail-item">
                                    <label>Marital Status:</label>
                                    <span>${patient.maritalStatus}</span>
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
                            <c:if test="${not empty patient.phone}">
                                <div class="detail-item">
                                    <label>Phone:</label>
                                    <span>
                                        <i class="fas fa-phone"></i>
                                        <a href="tel:${patient.phone}">${patient.phone}</a>
                                    </span>
                                </div>
                            </c:if>
                            <c:if test="${not empty patient.email}">
                                <div class="detail-item">
                                    <label>Email:</label>
                                    <span>
                                        <i class="fas fa-envelope"></i>
                                        <a href="mailto:${patient.email}">${patient.email}</a>
                                    </span>
                                </div>
                            </c:if>
                            <c:if test="${not empty patient.address}">
                                <div class="detail-item full-width">
                                    <label>Address:</label>
                                    <span>
                                        <i class="fas fa-map-marker-alt"></i>
                                        ${patient.address}
                                    </span>
                                </div>
                            </c:if>
                        </div>
                    </div>
                </div>

                <!-- Emergency Contact -->
                <div class="card">
                    <div class="card-header">
                        <h3><i class="fas fa-phone-alt"></i> Emergency Contact</h3>
                    </div>
                    <div class="card-body">
                        <div class="detail-grid">
                            <c:if test="${not empty patient.emergencyContactName}">
                                <div class="detail-item">
                                    <label>Contact Name:</label>
                                    <span>${patient.emergencyContactName}</span>
                                </div>
                            </c:if>
                            <c:if test="${not empty patient.emergencyContactPhone}">
                                <div class="detail-item">
                                    <label>Contact Phone:</label>
                                    <span>
                                        <i class="fas fa-phone"></i>
                                        <a href="tel:${patient.emergencyContactPhone}">${patient.emergencyContactPhone}</a>
                                    </span>
                                </div>
                            </c:if>
                            <c:if test="${not empty patient.emergencyContactRelation}">
                                <div class="detail-item">
                                    <label>Relationship:</label>
                                    <span>${patient.emergencyContactRelation}</span>
                                </div>
                            </c:if>
                        </div>
                    </div>
                </div>

                <!-- Medical Information -->
                <div class="card">
                    <div class="card-header">
                        <h3><i class="fas fa-heartbeat"></i> Medical Information</h3>
                    </div>
                    <div class="card-body">
                        <div class="detail-grid">
                            <c:if test="${not empty patient.allergies}">
                                <div class="detail-item full-width">
                                    <label>Allergies:</label>
                                    <span class="medical-alert">
                                        <i class="fas fa-exclamation-triangle"></i>
                                        ${patient.allergies}
                                    </span>
                                </div>
                            </c:if>
                            <c:if test="${not empty patient.medicalHistory}">
                                <div class="detail-item full-width">
                                    <label>Medical History:</label>
                                    <span>${patient.medicalHistory}</span>
                                </div>
                            </c:if>
                            <c:if test="${not empty patient.currentMedications}">
                                <div class="detail-item full-width">
                                    <label>Current Medications:</label>
                                    <span>${patient.currentMedications}</span>
                                </div>
                            </c:if>
                            <c:if test="${not empty patient.insuranceProvider}">
                                <div class="detail-item">
                                    <label>Insurance Provider:</label>
                                    <span>${patient.insuranceProvider}</span>
                                </div>
                            </c:if>
                            <c:if test="${not empty patient.insurancePolicyNumber}">
                                <div class="detail-item">
                                    <label>Policy Number:</label>
                                    <span>${patient.insurancePolicyNumber}</span>
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
                        <a href="/appointments/new?patientId=${patient.id}" class="btn btn-primary">
                            <i class="fas fa-calendar-plus"></i> Schedule Appointment
                        </a>
                        <a href="/appointments/patient/${patient.id}" class="btn btn-info">
                            <i class="fas fa-calendar"></i> View All Appointments
                        </a>
                        <a href="/patients/${patient.id}/edit" class="btn btn-warning">
                            <i class="fas fa-edit"></i> Edit Patient
                        </a>
                        <button onclick="confirmDelete('${patient.id}', '${fn:escapeXml(patient.firstName)} ${fn:escapeXml(patient.lastName)}')"
                                class="btn btn-danger">
                            <i class="fas fa-trash"></i> Delete Patient
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
                <p>Are you sure you want to delete <strong id="patientName"></strong>?</p>
                <p class="text-warning">
                    <i class="fas fa-warning"></i>
                    This action cannot be undone and may affect existing appointments.
                </p>
            </div>
            <div class="modal-footer">
                <form id="deleteForm" method="post" style="display: inline;">
                    <button type="button" class="btn btn-secondary close-modal">Cancel</button>
                    <button type="submit" class="btn btn-danger">
                        <i class="fas fa-trash"></i> Delete Patient
                    </button>
                </form>
            </div>
        </div>
    </div>

    <!-- Scripts -->
    <script src="/js/main.js"></script>
    <script>
        function confirmDelete(patientId, patientName) {
            document.getElementById('patientName').textContent = patientName;
            document.getElementById('deleteForm').action = '/patients/' + patientId + '/delete';
            showModal('deleteModal');
        }

        // Initialize time display
        updateTime();
        setInterval(updateTime, 1000);
    </script>

</body>
</html>
