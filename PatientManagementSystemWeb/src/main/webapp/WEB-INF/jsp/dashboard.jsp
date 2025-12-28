<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="pageTitle" value="Dashboard" scope="request"/>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Dashboard - Patient Management System</title>
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
            <li><a href="/web/dashboard" class="active">
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
            <li><a href="/web/medical-records">
                <i class="fas fa-file-medical"></i> Medical Records
            </a></li>
        </ul>
    </nav>

    <!-- Main Content -->
    <div class="container">
        <div class="content">
            <h2><i class="fas fa-tachometer-alt"></i> Dashboard Overview</h2>
           
            <!-- Statistics Cards -->
            <div class="dashboard-stats">
                <div class="stat-card patients">
                    <div class="stat-number">${totalPatients}</div>
                    <div class="stat-label">
                        <i class="fas fa-users"></i> Total Patients
                    </div>
                </div>
               
                <div class="stat-card doctors">
                    <div class="stat-number">${totalDoctors}</div>
                    <div class="stat-label">
                        <i class="fas fa-user-md"></i> Total Doctors
                    </div>
                </div>
               
                <div class="stat-card appointments">
                    <div class="stat-number">${totalAppointments}</div>
                    <div class="stat-label">
                        <i class="fas fa-calendar-alt"></i> Total Appointments
                    </div>
                </div>
            </div>

            <!-- Quick Actions -->
            <div class="card">
                <div class="card-header">
                    <h3 class="card-title"><i class="fas fa-bolt"></i> Quick Actions</h3>
                </div>
                <div class="btn-group">
                    <a href="/web/patients/new" class="btn btn-primary">
                        <i class="fas fa-user-plus"></i> Add New Patient
                    </a>
                    <a href="/web/doctors/new" class="btn btn-success">
                        <i class="fas fa-plus"></i> Add New Doctor
                    </a>
                    <a href="/web/appointments/new" class="btn btn-secondary">
                        <i class="fas fa-calendar-plus"></i> Schedule Appointment
                    </a>
                </div>
            </div>

            <!-- Recent Activity -->
            <div class="card">
                <div class="card-header">
                    <h3 class="card-title"><i class="fas fa-clock"></i> System Information</h3>
                </div>
                <p><strong>System Status:</strong> <span class="badge badge-success">Online</span></p>
                <p><strong>Database:</strong> <span class="badge badge-success">Connected</span></p>
                <p><strong>Last Updated:</strong> ${dates.format(dates.createNow(), 'dd/MM/yyyy HH:mm:ss')}</p>
            </div>
        </div>
    </div>

    <!-- Footer -->
    <footer style="text-align: center; padding: 2rem; background-color: #34495e; color: white; margin-top: 2rem;">
        <p>&copy; 2025 Patient Management System. All rights reserved.</p>
    </footer>
</body>
</html>