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
                    <i class="fas fa-user-injured"></i> Patients
                </h1>
                <a href="/patients/new" class="btn btn-success">
                    <i class="fas fa-user-plus"></i> Add New Patient
                </a>
            </div>

            <!-- Search Form -->
            <form class="search-form" action="/patients/search" method="get">
                <div class="form-row">
                    <div class="form-col">
                        <label for="firstName" class="form-label">First Name</label>
                        <input type="text" id="firstName" name="firstName" class="form-control"
                               placeholder="Enter first name" value="${param.firstName}">
                    </div>
                    <div class="form-col">
                        <label for="lastName" class="form-label">Last Name</label>
                        <input type="text" id="lastName" name="lastName" class="form-control"
                               placeholder="Enter last name" value="${param.lastName}">
                    </div>
                    <div class="form-col">
                        <label for="bloodType" class="form-label">Blood Type</label>
                        <select id="bloodType" name="bloodType" class="form-control">
                            <option value="">All Blood Types</option>
                            <option value="A+" ${param.bloodType == 'A+' ? 'selected' : ''}>A+</option>
                            <option value="A-" ${param.bloodType == 'A-' ? 'selected' : ''}>A-</option>
                            <option value="B+" ${param.bloodType == 'B+' ? 'selected' : ''}>B+</option>
                            <option value="B-" ${param.bloodType == 'B-' ? 'selected' : ''}>B-</option>
                            <option value="AB+" ${param.bloodType == 'AB+' ? 'selected' : ''}>AB+</option>
                            <option value="AB-" ${param.bloodType == 'AB-' ? 'selected' : ''}>AB-</option>
                            <option value="O+" ${param.bloodType == 'O+' ? 'selected' : ''}>O+</option>
                            <option value="O-" ${param.bloodType == 'O-' ? 'selected' : ''}>O-</option>
                        </select>
                    </div>
                    <div class="form-col" style="display: flex; align-items: end; gap: 0.5rem;">
                        <button type="submit" class="btn btn-primary">
                            <i class="fas fa-search"></i> Search
                        </button>
                        <a href="/patients" class="btn btn-secondary">
                            <i class="fas fa-times"></i> Clear
                        </a>
                    </div>
                </div>
            </form>

            <!-- Patients Table -->
            <c:choose>
                <c:when test="${not empty patients}">
                    <div class="card">
                        <div class="card-header">
                            <h4><i class="fas fa-list"></i> Patient Records (${fn:length(patients)} found)</h4>
                        </div>
                        <div class="card-body" style="padding: 0;">
                            <table class="table">
                                <thead>
                                    <tr>
                                        <th>ID</th>
                                        <th>Name</th>
                                        <th>Email</th>
                                        <th>Phone</th>
                                        <th>Date of Birth</th>
                                        <th>Gender</th>
                                        <th class="hide-mobile">Blood Type</th>
                                        <th>Actions</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <c:forEach var="patient" items="${patients}">
                                        <tr>
                                            <td><strong>#${patient.id}</strong></td>
                                            <td>
                                                <div>
                                                    <strong>${patient.firstName} ${patient.lastName}</strong>
                                                </div>
                                            </td>
                                            <td>
                                                <c:choose>
                                                    <c:when test="${not empty patient.email}">
                                                        <a href="mailto:${patient.email}" style="color: #3498db;">
                                                            ${patient.email}
                                                        </a>
                                                    </c:when>
                                                    <c:otherwise>
                                                        <span style="color: #95a5a6;">Not provided</span>
                                                    </c:otherwise>
                                                </c:choose>
                                            </td>
                                            <td>
                                                <c:choose>
                                                    <c:when test="${not empty patient.phoneNumber}">
                                                        <a href="tel:${patient.phoneNumber}" style="color: #3498db;">
                                                            ${patient.phoneNumber}
                                                        </a>
                                                    </c:when>
                                                    <c:otherwise>
                                                        <span style="color: #95a5a6;">Not provided</span>
                                                    </c:otherwise>
                                                </c:choose>
                                            </td>
                                            <td>
                                                <c:if test="${not empty patient.dateOfBirth}">
                                                    <fmt:formatDate value="${patient.dateOfBirth}" pattern="MMM dd, yyyy" />
                                                </c:if>
                                            </td>
                                            <td>
                                                <c:if test="${not empty patient.gender}">
                                                    <span class="status-badge ${patient.gender == 'Male' ? 'status-confirmed' : 'status-scheduled'}">
                                                        ${patient.gender}
                                                    </span>
                                                </c:if>
                                            </td>
                                            <td class="hide-mobile">
                                                <c:if test="${not empty patient.bloodType}">
                                                    <span class="status-badge status-completed">${patient.bloodType}</span>
                                                </c:if>
                                            </td>
                                            <td>
                                                <div style="display: flex; gap: 0.25rem;">
                                                    <a href="/patients/${patient.id}" class="btn btn-primary btn-sm" title="View Details">
                                                        <i class="fas fa-eye"></i>
                                                    </a>
                                                    <a href="/patients/${patient.id}/edit" class="btn btn-warning btn-sm" title="Edit">
                                                        <i class="fas fa-edit"></i>
                                                    </a>
                                                    <a href="/appointments/patient/${patient.id}" class="btn btn-secondary btn-sm" title="View Appointments">
                                                        <i class="fas fa-calendar-alt"></i>
                                                    </a>
                                                    <form action="/patients/${patient.id}/delete" method="post" style="display: inline;">
                                                        <button type="submit" class="btn btn-danger btn-sm" title="Delete"
                                                                onclick="return confirm('Are you sure you want to delete this patient? This action cannot be undone.')">
                                                            <i class="fas fa-trash"></i>
                                                        </button>
                                                    </form>
                                                </div>
                                            </td>
                                        </tr>
                                    </c:forEach>
                                </tbody>
                            </table>
                        </div>
                    </div>
                </c:when>
                <c:otherwise>
                    <div class="card">
                        <div class="card-body text-center" style="padding: 3rem;">
                            <i class="fas fa-user-injured" style="font-size: 4rem; color: #bdc3c7; margin-bottom: 1rem;"></i>
                            <h3 style="color: #7f8c8d; margin-bottom: 1rem;">No Patients Found</h3>
                            <p style="color: #95a5a6; margin-bottom: 2rem;">
                                <c:choose>
                                    <c:when test="${not empty param.firstName or not empty param.lastName or not empty param.bloodType}">
                                        No patients match your search criteria. Try adjusting your search parameters.
                                    </c:when>
                                    <c:otherwise>
                                        There are no patients in the system yet. Add the first patient to get started.
                                    </c:otherwise>
                                </c:choose>
                            </p>
                            <a href="/patients/new" class="btn btn-success">
                                <i class="fas fa-user-plus"></i> Add First Patient
                            </a>
                        </div>
                    </div>
                </c:otherwise>
            </c:choose>

            <!-- Quick Stats -->
            <c:if test="${not empty patients}">
                <div class="card mt-3">
                    <div class="card-header">
                        <h4><i class="fas fa-chart-bar"></i> Patient Statistics</h4>
                    </div>
                    <div class="card-body">
                        <div style="display: grid; grid-template-columns: repeat(auto-fit, minmax(200px, 1fr)); gap: 1rem;">
                            <div style="text-align: center; padding: 1rem; background-color: #f8f9fa; border-radius: 5px;">
                                <h5 style="color: #3498db;">Total Patients</h5>
                                <div style="font-size: 2rem; font-weight: bold; color: #2c3e50;">${fn:length(patients)}</div>
                            </div>
                            <div style="text-align: center; padding: 1rem; background-color: #f8f9fa; border-radius: 5px;">
                                <h5 style="color: #27ae60;">With Email</h5>
                                <div style="font-size: 2rem; font-weight: bold; color: #2c3e50;">
                                    <c:set var="emailCount" value="0" />
                                    <c:forEach var="patient" items="${patients}">
                                        <c:if test="${not empty patient.email}">
                                            <c:set var="emailCount" value="${emailCount + 1}" />
                                        </c:if>
                                    </c:forEach>
                                    ${emailCount}
                                </div>
                            </div>
                            <div style="text-align: center; padding: 1rem; background-color: #f8f9fa; border-radius: 5px;">
                                <h5 style="color: #e74c3c;">With Phone</h5>
                                <div style="font-size: 2rem; font-weight: bold; color: #2c3e50;">
                                    <c:set var="phoneCount" value="0" />
                                    <c:forEach var="patient" items="${patients}">
                                        <c:if test="${not empty patient.phoneNumber}">
                                            <c:set var="phoneCount" value="${phoneCount + 1}" />
                                        </c:if>
                                    </c:forEach>
                                    ${phoneCount}
                                </div>
                            </div>
                            <div style="text-align: center; padding: 1rem; background-color: #f8f9fa; border-radius: 5px;">
                                <h5 style="color: #f39c12;">Blood Type Recorded</h5>
                                <div style="font-size: 2rem; font-weight: bold; color: #2c3e50;">
                                    <c:set var="bloodTypeCount" value="0" />
                                    <c:forEach var="patient" items="${patients}">
                                        <c:if test="${not empty patient.bloodType}">
                                            <c:set var="bloodTypeCount" value="${bloodTypeCount + 1}" />
                                        </c:if>
                                    </c:forEach>
                                    ${bloodTypeCount}
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </c:if>
        </main>
    </div>

    <!-- Footer -->
    <footer class="footer" style="background-color: #2c3e50; color: white; text-align: center; padding: 2rem 0; margin-top: 3rem;">
        <div class="container">
            <p>&copy; 2025 Patient Record Management System. All rights reserved.</p>
        </div>
    </footer>

    <script src="/js/main.js"></script>
    <script>
        function updateTime() {
            const now = new Date();
            const timeString = now.toLocaleString();
            const timeElement = document.getElementById('currentTime');
            if (timeElement) {
                timeElement.textContent = timeString;
            }
        }
        setInterval(updateTime, 1000);
        updateTime();
    </script>
</body>
</html>
