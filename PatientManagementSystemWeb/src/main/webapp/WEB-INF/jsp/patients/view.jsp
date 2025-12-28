<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Patient Details - Patient Management System</title>
    <link rel="stylesheet" href="/css/style.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
</head>
<body>
    <!-- Header -->
    <header class="header">
        <h1><i class="fas fa-hospital"></i> Patient Management System</h1>
        <p>Comprehensive Healthcare Management Solution</p>
    </header>

    <!-- Navigation -->
    <nav class="navbar">
        <ul>
            <li><a href="/web/dashboard">
                <i class="fas fa-tachometer-alt"></i> Dashboard
            </a></li>
            <li><a href="/web/patients" class="active">
                <i class="fas fa-users"></i> Patients
            </a></li>
            <li><a href="/web/doctors">
                <i class="fas fa-user-md"></i> Doctors
            </a></li>
            <li><a href="/web/appointments">
                <i class="fas fa-calendar-alt"></i> Appointments
            </a></li>
            <li><a href="/web/medical-records">
                <i class="fas fa-file-medical"></i> Medical Records
            </a></li>
        </ul>
    </nav>

    <!-- Main Content -->
    <div class="container">
        <div class="content">
            <div style="display: flex; justify-content: space-between; align-items: center; margin-bottom: 2rem;">
                <h2><i class="fas fa-user"></i> Patient Details</h2>
                <div class="btn-group">
                    <a href="/web/patients/edit/${patient.id}" class="btn btn-primary">
                        <i class="fas fa-edit"></i> Edit Patient
                    </a>
                    <a href="/web/patients" class="btn btn-secondary">
                        <i class="fas fa-arrow-left"></i> Back to Patients
                    </a>
                </div>
            </div>

            <!-- Patient Information -->
            <div class="card">
                <div class="card-header">
                    <h3 class="card-title">
                        <i class="fas fa-user"></i> ${patient.firstName} ${patient.lastName}
                        <span class="badge ${patient.gender == 'MALE' ? 'badge-info' : patient.gender == 'FEMALE' ? 'badge-warning' : 'badge-secondary'}">
                            ${patient.gender}
                        </span>
                    </h3>
                </div>
               
                <div style="display: grid; grid-template-columns: repeat(auto-fit, minmax(300px, 1fr)); gap: 2rem;">
                    <!-- Personal Information -->
                    <div>
                        <h4><i class="fas fa-user-circle"></i> Personal Information</h4>
                        <table style="width: 100%; margin-top: 1rem;">
                            <tr>
                                <td style="padding: 0.5rem; font-weight: bold; border-bottom: 1px solid #e9ecef;">Patient ID:</td>
                                <td style="padding: 0.5rem; border-bottom: 1px solid #e9ecef;">${patient.id}</td>
                            </tr>
                            <tr>
                                <td style="padding: 0.5rem; font-weight: bold; border-bottom: 1px solid #e9ecef;">Full Name:</td>
                                <td style="padding: 0.5rem; border-bottom: 1px solid #e9ecef;">${patient.firstName} ${patient.lastName}</td>
                            </tr>
                            <tr>
                                <td style="padding: 0.5rem; font-weight: bold; border-bottom: 1px solid #e9ecef;">Date of Birth:</td>
                                <td style="padding: 0.5rem; border-bottom: 1px solid #e9ecef;">
                                    <fmt:formatDate value="${patient.dateOfBirth}" pattern="dd/MM/yyyy"/>
                                </td>
                            </tr>
                            <tr>
                                <td style="padding: 0.5rem; font-weight: bold; border-bottom: 1px solid #e9ecef;">Gender:</td>
                                <td style="padding: 0.5rem; border-bottom: 1px solid #e9ecef;">${patient.gender}</td>
                            </tr>
                        </table>
                    </div>

                    <!-- Contact Information -->
                    <div>
                        <h4><i class="fas fa-address-card"></i> Contact Information</h4>
                        <table style="width: 100%; margin-top: 1rem;">
                            <tr>
                                <td style="padding: 0.5rem; font-weight: bold; border-bottom: 1px solid #e9ecef;">Email:</td>
                                <td style="padding: 0.5rem; border-bottom: 1px solid #e9ecef;">
                                    <c:choose>
                                        <c:when test="${not empty patient.email}">
                                            <a href="mailto:${patient.email}">${patient.email}</a>
                                        </c:when>
                                        <c:otherwise>
                                            <span style="color: #666;">Not provided</span>
                                        </c:otherwise>
                                    </c:choose>
                                </td>
                            </tr>
                            <tr>
                                <td style="padding: 0.5rem; font-weight: bold; border-bottom: 1px solid #e9ecef;">Phone:</td>
                                <td style="padding: 0.5rem; border-bottom: 1px solid #e9ecef;">
                                    <c:choose>
                                        <c:when test="${not empty patient.phoneNumber}">
                                            <a href="tel:${patient.phoneNumber}">${patient.phoneNumber}</a>
                                        </c:when>
                                        <c:otherwise>
                                            <span style="color: #666;">Not provided</span>
                                        </c:otherwise>
                                    </c:choose>
                                </td>
                            </tr>
                            <tr>
                                <td style="padding: 0.5rem; font-weight: bold; border-bottom: 1px solid #e9ecef;">Address:</td>
                                <td style="padding: 0.5rem; border-bottom: 1px solid #e9ecef;">
                                    <c:choose>
                                        <c:when test="${not empty patient.address}">
                                            ${patient.address}
                                        </c:when>
                                        <c:otherwise>
                                            <span style="color: #666;">Not provided</span>
                                        </c:otherwise>
                                    </c:choose>
                                </td>
                            </tr>
                        </table>
                    </div>
                </div>
            </div>

            <!-- Emergency Contact -->
            <c:if test="${not empty patient.emergencyContactName || not empty patient.emergencyContactPhone}">
                <div class="card">
                    <div class="card-header">
                        <h3 class="card-title"><i class="fas fa-phone"></i> Emergency Contact</h3>
                    </div>
                   
                    <table style="width: 100%; max-width: 600px;">
                        <c:if test="${not empty patient.emergencyContactName}">
                            <tr>
                                <td style="padding: 0.5rem; font-weight: bold; border-bottom: 1px solid #e9ecef; width: 200px;">Contact Name:</td>
                                <td style="padding: 0.5rem; border-bottom: 1px solid #e9ecef;">${patient.emergencyContactName}</td>
                            </tr>
                        </c:if>
                        <c:if test="${not empty patient.emergencyContactPhone}">
                            <tr>
                                <td style="padding: 0.5rem; font-weight: bold; border-bottom: 1px solid #e9ecef;">Contact Phone:</td>
                                <td style="padding: 0.5rem; border-bottom: 1px solid #e9ecef;">
                                    <a href="tel:${patient.emergencyContactPhone}">${patient.emergencyContactPhone}</a>
                                </td>
                            </tr>
                        </c:if>
                    </table>
                </div>
            </c:if>

            <!-- Record Information -->
            <div class="card">
                <div class="card-header">
                    <h3 class="card-title"><i class="fas fa-info-circle"></i> Record Information</h3>
                </div>
               
                <table style="width: 100%; max-width: 600px;">
                    <tr>
                        <td style="padding: 0.5rem; font-weight: bold; border-bottom: 1px solid #e9ecef; width: 200px;">Created Date:</td>
                        <td style="padding: 0.5rem; border-bottom: 1px solid #e9ecef;">
                            <fmt:formatDate value="${patient.createdAt}" pattern="dd/MM/yyyy HH:mm:ss"/>
                        </td>
                    </tr>
                    <tr>
                        <td style="padding: 0.5rem; font-weight: bold; border-bottom: 1px solid #e9ecef;">Last Updated:</td>
                        <td style="padding: 0.5rem; border-bottom: 1px solid #e9ecef;">
                            <fmt:formatDate value="${patient.updatedAt}" pattern="dd/MM/yyyy HH:mm:ss"/>
                        </td>
                    </tr>
                </table>
            </div>

            <!-- Quick Actions -->
            <div class="card">
                <div class="card-header">
                    <h3 class="card-title"><i class="fas fa-bolt"></i> Quick Actions</h3>
                </div>
                <div class="btn-group">
                    <a href="/web/appointments/new?patientId=${patient.id}" class="btn btn-success">
                        <i class="fas fa-calendar-plus"></i> Schedule Appointment
                    </a>
                    <a href="/web/medical-records/new?patientId=${patient.id}" class="btn btn-info">
                        <i class="fas fa-file-medical"></i> Add Medical Record
                    </a>
                    <a href="/web/patients/edit/${patient.id}" class="btn btn-primary">
                        <i class="fas fa-edit"></i> Edit Patient
                    </a>
                </div>
            </div>
        </div>
    </div>

    <!-- Footer -->
    <footer style="text-align: center; padding: 2rem; background-color: #34495e; color: white; margin-top: 2rem;">
        <p>&copy; 2025 Patient Management System. All rights reserved.</p>
    </footer>
</body>
</html>