<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Appointments - Patient Management System</title>
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
            <li><a href="/web/appointments" class="active">
                <i class="fas fa-calendar-alt"></i> Appointments
            </a></li>
            <li><a href="/web/medical-records">
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
                <h2><i class="fas fa-calendar-alt"></i> Appointment Management</h2>
                <a href="/web/appointments/new" class="btn btn-primary">
                    <i class="fas fa-calendar-plus"></i> Schedule New Appointment
                </a>
            </div>

            <!-- Filter Options -->
            <div class="card" style="margin-bottom: 2rem;">
                <div style="display: flex; gap: 1rem; align-items: center; flex-wrap: wrap;">
                    <label style="font-weight: 600;">Filter by Status:</label>
                    <select id="statusFilter" class="form-control" style="width: auto;">
                        <option value="">All Appointments</option>
                        <option value="SCHEDULED">Scheduled</option>
                        <option value="CONFIRMED">Confirmed</option>
                        <option value="IN_PROGRESS">In Progress</option>
                        <option value="COMPLETED">Completed</option>
                        <option value="CANCELLED">Cancelled</option>
                        <option value="NO_SHOW">No Show</option>
                    </select>
                   
                    <label style="font-weight: 600; margin-left: 1rem;">Search:</label>
                    <input type="text" id="searchInput" class="form-control" placeholder="Search by patient or doctor name..." style="width: auto; flex: 1; min-width: 250px;">
                </div>
            </div>

            <!-- Appointments Table -->
            <div class="table-container">
                <table class="table">
                    <thead>
                        <tr>
                            <th>ID</th>
                            <th>Date & Time</th>
                            <th>Patient</th>
                            <th>Doctor</th>
                            <th>Reason</th>
                            <th>Status</th>
                            <th>Duration</th>
                            <th>Actions</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:forEach var="appointment" items="${appointments}">
                            <tr data-status="${appointment.status}">
                                <td>${appointment.id}</td>
                                <td>
                                    <fmt:formatDate value="${appointment.appointmentDateTime}" pattern="dd/MM/yyyy"/>
                                    <br>
                                    <small style="color: #666;">
                                        <fmt:formatDate value="${appointment.appointmentDateTime}" pattern="HH:mm"/>
                                    </small>
                                </td>
                                <td>
                                    <strong>${appointment.patient.firstName} ${appointment.patient.lastName}</strong>
                                    <br>
                                    <small style="color: #666;">ID: ${appointment.patient.id}</small>
                                </td>
                                <td>
                                    <strong>Dr. ${appointment.doctor.firstName} ${appointment.doctor.lastName}</strong>
                                    <br>
                                    <small style="color: #666;">${appointment.doctor.specialization}</small>
                                </td>
                                <td>${appointment.reasonForVisit}</td>
                                <td>
                                    <span class="badge ${
                                        appointment.status == 'SCHEDULED' ? 'badge-info' :
                                        appointment.status == 'CONFIRMED' ? 'badge-success' :
                                        appointment.status == 'IN_PROGRESS' ? 'badge-warning' :
                                        appointment.status == 'COMPLETED' ? 'badge-success' :
                                        appointment.status == 'CANCELLED' ? 'badge-danger' :
                                        'badge-secondary'
                                    }">
                                        ${appointment.status.replace('_', ' ')}
                                    </span>
                                </td>
                                <td>${appointment.durationMinutes} min</td>
                                <td class="actions">
                                    <a href="/web/appointments/${appointment.id}" class="btn btn-info btn-sm">
                                        <i class="fas fa-eye"></i> View
                                    </a>
                                    <c:if test="${appointment.status != 'COMPLETED' && appointment.status != 'CANCELLED'}">
                                        <a href="/web/appointments/edit/${appointment.id}" class="btn btn-primary btn-sm">
                                            <i class="fas fa-edit"></i> Edit
                                        </a>
                                    </c:if>
                                    <a href="/web/appointments/delete/${appointment.id}"
                                       class="btn btn-danger btn-sm"
                                       onclick="return confirm('Are you sure you want to cancel this appointment?')">
                                        <i class="fas fa-times"></i> Cancel
                                    </a>
                                </td>
                            </tr>
                        </c:forEach>
                        <c:if test="${empty appointments}">
                            <tr>
                                <td colspan="8" style="text-align: center; padding: 2rem; color: #666;">
                                    <i class="fas fa-calendar-alt" style="font-size: 3rem; margin-bottom: 1rem; opacity: 0.3;"></i>
                                    <br>No appointments found. <a href="/web/appointments/new">Schedule the first appointment</a>
                                </td>
                            </tr>
                        </c:if>
                    </tbody>
                </table>
            </div>
        </div>
    </div>

    <!-- Footer -->
    <footer style="text-align: center; padding: 2rem; background-color: #34495e; color: white; margin-top: 2rem;">
        <p>&copy; 2025 Patient Management System. All rights reserved.</p>
    </footer>

    <script>
        // Filter functionality
        function filterAppointments() {
            const statusFilter = document.getElementById('statusFilter').value;
            const searchTerm = document.getElementById('searchInput').value.toLowerCase();
            const rows = document.querySelectorAll('.table tbody tr');
           
            rows.forEach(row => {
                if (row.cells.length === 1) return; // Skip empty message row
               
                const status = row.getAttribute('data-status');
                const text = row.textContent.toLowerCase();
               
                const statusMatch = !statusFilter || status === statusFilter;
                const searchMatch = !searchTerm || text.includes(searchTerm);
               
                if (statusMatch && searchMatch) {
                    row.style.display = '';
                } else {
                    row.style.display = 'none';
                }
            });
        }

        // Event listeners
        document.getElementById('statusFilter').addEventListener('change', filterAppointments);
        document.getElementById('searchInput').addEventListener('input', filterAppointments);
    </script>
</body>
</html>
