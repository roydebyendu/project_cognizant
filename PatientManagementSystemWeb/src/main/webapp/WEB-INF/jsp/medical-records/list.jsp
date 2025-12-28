<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Medical Records - Patient Management System</title>
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
            <li><a href="/web/patients">
                <i class="fas fa-users"></i> Patients
            </a></li>
            <li><a href="/web/doctors">
                <i class="fas fa-user-md"></i> Doctors
            </a></li>
            <li><a href="/web/appointments">
                <i class="fas fa-calendar-alt"></i> Appointments
            </a></li>
            <li><a href="/web/medical-records" class="active">
                <i class="fas fa-file-medical"></i> Medical Records
            </a></li>
        </ul>
    </nav>

    <!-- Main Content -->
    <div class="container">
        <!-- Success/Error Messages -->
        <c:if test="${not empty successMessage}">
            <div class="alert alert-success">
                <i class="fas fa-check-circle"></i> ${successMessage}
            </div>
        </c:if>
       
        <c:if test="${not empty errorMessage}">
            <div class="alert alert-danger">
                <i class="fas fa-exclamation-circle"></i> ${errorMessage}
            </div>
        </c:if>

        <div class="content">
            <div style="display: flex; justify-content: space-between; align-items: center; margin-bottom: 2rem;">
                <h2><i class="fas fa-file-medical"></i> Medical Records Management</h2>
                <a href="/web/medical-records/new" class="btn btn-primary">
                    <i class="fas fa-plus"></i> Add New Medical Record
                </a>
            </div>

            <!-- Filter and Search Section -->
            <div class="card" style="margin-bottom: 2rem;">
                <div style="display: grid; grid-template-columns: repeat(auto-fit, minmax(200px, 1fr)); gap: 1rem; align-items: end;">
                    <div class="form-group">
                        <label for="patientFilter">Filter by Patient:</label>
                        <select id="patientFilter" class="form-control">
                            <option value="">All Patients</option>
                            <c:forEach var="patient" items="${patients}">
                                <option value="${patient.id}">${patient.firstName} ${patient.lastName}</option>
                            </c:forEach>
                        </select>
                    </div>
                   
                    <div class="form-group">
                        <label for="doctorFilter">Filter by Doctor:</label>
                        <select id="doctorFilter" class="form-control">
                            <option value="">All Doctors</option>
                            <c:forEach var="doctor" items="${doctors}">
                                <option value="${doctor.id}">Dr. ${doctor.firstName} ${doctor.lastName}</option>
                            </c:forEach>
                        </select>
                    </div>
                   
                    <div class="form-group">
                        <label for="dateFilter">Visit Date:</label>
                        <input type="date" id="dateFilter" class="form-control">
                    </div>
                   
                    <div class="form-group">
                        <label for="searchInput">Search Records:</label>
                        <input type="text" id="searchInput" class="form-control" placeholder="Search diagnosis, symptoms, treatment...">
                    </div>
                </div>
            </div>

            <!-- Medical Records Table -->
            <div class="table-container">
                <table class="table">
                    <thead>
                        <tr>
                            <th>Record ID</th>
                            <th>Visit Date</th>
                            <th>Patient</th>
                            <th>Doctor</th>
                            <th>Diagnosis</th>
                            <th>Symptoms</th>
                            <th>Treatment</th>
                            <th>Follow-up</th>
                            <th>Actions</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:forEach var="record" items="${medicalRecords}">
                            <tr data-patient-id="${record.patient.id}" data-doctor-id="${record.doctor.id}">
                                <td>
                                    <strong>MR-${record.id}</strong>
                                </td>
                                <td>
                                    <fmt:formatDate value="${record.visitDate}" pattern="dd/MM/yyyy"/>
                                    <br>
                                    <small style="color: #666;">
                                        <fmt:formatDate value="${record.visitDate}" pattern="HH:mm"/>
                                    </small>
                                </td>
                                <td>
                                    <strong>${record.patient.firstName} ${record.patient.lastName}</strong>
                                    <br>
                                    <small style="color: #666;">
                                        ID: ${record.patient.id} |
                                        <fmt:formatDate value="${record.patient.dateOfBirth}" pattern="dd/MM/yyyy"/>
                                    </small>
                                </td>
                                <td>
                                    <strong>Dr. ${record.doctor.firstName} ${record.doctor.lastName}</strong>
                                    <br>
                                    <small style="color: #666;">${record.doctor.specialization}</small>
                                </td>
                                <td>
                                    <c:choose>
                                        <c:when test="${not empty record.diagnosis}">
                                            <span title="${record.diagnosis}">
                                                ${fn:length(record.diagnosis) > 50 ? fn:substring(record.diagnosis, 0, 50).concat('...') : record.diagnosis}
                                            </span>
                                        </c:when>
                                        <c:otherwise>
                                            <span style="color: #999; font-style: italic;">Not recorded</span>
                                        </c:otherwise>
                                    </c:choose>
                                </td>
                                <td>
                                    <c:choose>
                                        <c:when test="${not empty record.symptoms}">
                                            <span title="${record.symptoms}">
                                                ${fn:length(record.symptoms) > 40 ? fn:substring(record.symptoms, 0, 40).concat('...') : record.symptoms}
                                            </span>
                                        </c:when>
                                        <c:otherwise>
                                            <span style="color: #999; font-style: italic;">Not recorded</span>
                                        </c:otherwise>
                                    </c:choose>
                                </td>
                                <td>
                                    <c:choose>
                                        <c:when test="${not empty record.treatment}">
                                            <span title="${record.treatment}">
                                                ${fn:length(record.treatment) > 40 ? fn:substring(record.treatment, 0, 40).concat('...') : record.treatment}
                                            </span>
                                        </c:when>
                                        <c:otherwise>
                                            <span style="color: #999; font-style: italic;">Not recorded</span>
                                        </c:otherwise>
                                    </c:choose>
                                </td>
                                <td>
                                    <c:choose>
                                        <c:when test="${not empty record.followUpDate}">
                                            <span class="badge badge-warning">
                                                <fmt:formatDate value="${record.followUpDate}" pattern="dd/MM/yyyy"/>
                                            </span>
                                        </c:when>
                                        <c:otherwise>
                                            <span style="color: #999;">None</span>
                                        </c:otherwise>
                                    </c:choose>
                                </td>
                                <td class="actions">
                                    <a href="/web/medical-records/${record.id}" class="btn btn-info btn-sm" title="View Details">
                                        <i class="fas fa-eye"></i> View
                                    </a>
                                    <a href="/web/medical-records/edit/${record.id}" class="btn btn-primary btn-sm" title="Edit Record">
                                        <i class="fas fa-edit"></i> Edit
                                    </a>
                                    <a href="/web/medical-records/${record.id}/print" class="btn btn-secondary btn-sm" title="Print Record">
                                        <i class="fas fa-print"></i> Print
                                    </a>
                                    <a href="/web/medical-records/delete/${record.id}"
                                       class="btn btn-danger btn-sm"
                                       title="Delete Record"
                                       onclick="return confirm('Are you sure you want to delete this medical record? This action cannot be undone.')">
                                        <i class="fas fa-trash"></i> Delete
                                    </a>
                                </td>
                            </tr>
                        </c:forEach>
                        <c:if test="${empty medicalRecords}">
                            <tr>
                                <td colspan="9" style="text-align: center; padding: 2rem; color: #666;">
                                    <i class="fas fa-file-medical" style="font-size: 3rem; margin-bottom: 1rem; opacity: 0.3;"></i>
                                    <br>No medical records found. <a href="/web/medical-records/new">Add the first medical record</a>
                                </td>
                            </tr>
                        </c:if>
                    </tbody>
                </table>
            </div>

            <!-- Summary Statistics -->
            <div class="card" style="margin-top: 2rem;">
                <div class="card-header">
                    <h3 class="card-title"><i class="fas fa-chart-bar"></i> Records Summary</h3>
                </div>
                <div style="display: grid; grid-template-columns: repeat(auto-fit, minmax(200px, 1fr)); gap: 2rem; text-align: center;">
                    <div>
                        <div style="font-size: 2rem; font-weight: bold; color: #3498db;">${fn:length(medicalRecords)}</div>
                        <div style="color: #666;">Total Records</div>
                    </div>
                    <div>
                        <div style="font-size: 2rem; font-weight: bold; color: #27ae60;">
                            ${fn:length(uniquePatients)}
                        </div>
                        <div style="color: #666;">Unique Patients</div>
                    </div>
                    <div>
                        <div style="font-size: 2rem; font-weight: bold; color: #f39c12;">
                            ${fn:length(recordsWithFollowUp)}
                        </div>
                        <div style="color: #666;">Follow-up Required</div>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <!-- Footer -->
    <footer style="text-align: center; padding: 2rem; background-color: #34495e; color: white; margin-top: 2rem;">
        <p>&copy; 2025 Patient Management System. All rights reserved.</p>
    </footer>

    <script>
        // Filter and search functionality
        function filterRecords() {
            const patientFilter = document.getElementById('patientFilter').value;
            const doctorFilter = document.getElementById('doctorFilter').value;
            const dateFilter = document.getElementById('dateFilter').value;
            const searchTerm = document.getElementById('searchInput').value.toLowerCase();
            const rows = document.querySelectorAll('.table tbody tr');
           
            rows.forEach(row => {
                if (row.cells.length === 1) return; // Skip empty message row
               
                const patientId = row.getAttribute('data-patient-id');
                const doctorId = row.getAttribute('data-doctor-id');
                const rowText = row.textContent.toLowerCase();
                const visitDate = row.cells[1].textContent.trim().split('\n')[0]; // Get date part
               
                const patientMatch = !patientFilter || patientId === patientFilter;
                const doctorMatch = !doctorFilter || doctorId === doctorFilter;
                const dateMatch = !dateFilter || visitDate.includes(formatDateForComparison(dateFilter));
                const searchMatch = !searchTerm || rowText.includes(searchTerm);
               
                if (patientMatch && doctorMatch && dateMatch && searchMatch) {
                    row.style.display = '';
                } else {
                    row.style.display = 'none';
                }
            });
        }

        function formatDateForComparison(dateString) {
            const date = new Date(dateString);
            return date.toLocaleDateString('en-GB'); // Format as dd/mm/yyyy
        }

        // Event listeners for filters
        document.getElementById('patientFilter').addEventListener('change', filterRecords);
        document.getElementById('doctorFilter').addEventListener('change', filterRecords);
        document.getElementById('dateFilter').addEventListener('change', filterRecords);
        document.getElementById('searchInput').addEventListener('input', filterRecords);

        // Clear filters function
        function clearFilters() {
            document.getElementById('patientFilter').value = '';
            document.getElementById('doctorFilter').value = '';
            document.getElementById('dateFilter').value = '';
            document.getElementById('searchInput').value = '';
            filterRecords();
        }

        // Add clear filters button
        document.addEventListener('DOMContentLoaded', function() {
            const filterCard = document.querySelector('.card');
            const clearButton = document.createElement('button');
            clearButton.className = 'btn btn-secondary';
            clearButton.innerHTML = '<i class="fas fa-times"></i> Clear Filters';
            clearButton.onclick = clearFilters;
            clearButton.style.marginTop = '1rem';
            filterCard.appendChild(clearButton);
        });
    </script>
</body>
</html>
