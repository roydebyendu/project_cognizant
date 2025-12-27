<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
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
                <li><a href="/dashboard" class="active"><i class="fas fa-tachometer-alt"></i> Dashboard</a></li>
                <li><a href="/patients"><i class="fas fa-user-injured"></i> Patients</a></li>
                <li><a href="/doctors"><i class="fas fa-user-md"></i> Doctors</a></li>
                <li><a href="/appointments"><i class="fas fa-calendar-alt"></i> Appointments</a></li>
            </ul>
        </div>
    </nav>

    <!-- Main Content -->
    <div class="container">
        <main class="main-content">
            <h1 class="page-title">
                <i class="fas fa-tachometer-alt"></i> Dashboard
            </h1>

            <!-- Statistics Cards -->
            <div class="dashboard-stats">
                <div class="stat-card patients">
                    <i class="fas fa-user-injured stat-icon" style="font-size: 2.5rem; margin-bottom: 1rem;"></i>
                    <div class="stat-number" id="patientsCount">-</div>
                    <div class="stat-label">Total Patients</div>
                    <a href="/patients" class="btn btn-primary btn-sm" style="margin-top: 1rem;">
                        <i class="fas fa-eye"></i> View All
                    </a>
                </div>

                <div class="stat-card doctors">
                    <i class="fas fa-user-md stat-icon" style="font-size: 2.5rem; margin-bottom: 1rem;"></i>
                    <div class="stat-number" id="doctorsCount">-</div>
                    <div class="stat-label">Total Doctors</div>
                    <a href="/doctors" class="btn btn-primary btn-sm" style="margin-top: 1rem;">
                        <i class="fas fa-eye"></i> View All
                    </a>
                </div>

                <div class="stat-card appointments">
                    <i class="fas fa-calendar-alt stat-icon" style="font-size: 2.5rem; margin-bottom: 1rem;"></i>
                    <div class="stat-number" id="appointmentsCount">-</div>
                    <div class="stat-label">Total Appointments</div>
                    <a href="/appointments" class="btn btn-primary btn-sm" style="margin-top: 1rem;">
                        <i class="fas fa-eye"></i> View All
                    </a>
                </div>

                <div class="stat-card" style="background: linear-gradient(135deg, #9b59b6 0%, #8e44ad 100%); box-shadow: 0 4px 15px rgba(155, 89, 182, 0.3);">
                    <i class="fas fa-calendar-check stat-icon" style="font-size: 2.5rem; margin-bottom: 1rem;"></i>
                    <div class="stat-number" id="todaysAppointments">-</div>
                    <div class="stat-label">Today's Appointments</div>
                    <button class="btn btn-primary btn-sm" style="margin-top: 1rem;" onclick="refreshStats()">
                        <i class="fas fa-refresh"></i> Refresh
                    </button>
                </div>
            </div>

            <!-- Quick Actions -->
            <div class="card mt-3">
                <div class="card-header">
                    <h3><i class="fas fa-bolt"></i> Quick Actions</h3>
                </div>
                <div class="card-body">
                    <div style="display: grid; grid-template-columns: repeat(auto-fit, minmax(200px, 1fr)); gap: 1rem;">
                        <a href="/patients/new" class="btn btn-success">
                            <i class="fas fa-user-plus"></i> Add New Patient
                        </a>
                        <a href="/doctors/new" class="btn btn-primary">
                            <i class="fas fa-user-md"></i> Add New Doctor
                        </a>
                        <a href="/appointments/new" class="btn btn-warning">
                            <i class="fas fa-calendar-plus"></i> Schedule Appointment
                        </a>
                        <button class="btn btn-secondary" onclick="exportData()">
                            <i class="fas fa-download"></i> Export Data
                        </button>
                    </div>
                </div>
            </div>

            <!-- Recent Activities -->
            <div style="display: grid; grid-template-columns: 1fr 1fr; gap: 2rem; margin-top: 2rem;">
               
                <!-- Recent Patients -->
                <div class="card">
                    <div class="card-header">
                        <h4><i class="fas fa-user-injured"></i> Recent Patients</h4>
                    </div>
                    <div class="card-body">
                        <div id="recentPatients" class="loading-placeholder">
                            <div class="loading-spinner"></div>
                            <p>Loading recent patients...</p>
                        </div>
                    </div>
                    <div class="card-footer">
                        <a href="/patients" class="btn btn-primary btn-sm">
                            <i class="fas fa-arrow-right"></i> View All Patients
                        </a>
                    </div>
                </div>

                <!-- Upcoming Appointments -->
                <div class="card">
                    <div class="card-header">
                        <h4><i class="fas fa-calendar-alt"></i> Upcoming Appointments</h4>
                    </div>
                    <div class="card-body">
                        <div id="upcomingAppointments" class="loading-placeholder">
                            <div class="loading-spinner"></div>
                            <p>Loading upcoming appointments...</p>
                        </div>
                    </div>
                    <div class="card-footer">
                        <a href="/appointments" class="btn btn-warning btn-sm">
                            <i class="fas fa-arrow-right"></i> View All Appointments
                        </a>
                    </div>
                </div>
            </div>

            <!-- System Status -->
            <div class="card mt-3">
                <div class="card-header">
                    <h4><i class="fas fa-server"></i> System Status</h4>
                </div>
                <div class="card-body">
                    <div style="display: grid; grid-template-columns: repeat(auto-fit, minmax(200px, 1fr)); gap: 1rem;">
                        <div class="service-status" id="patientService">
                            <i class="fas fa-circle text-secondary"></i>
                            <span>Patient Service</span>
                            <span class="status-text">Checking...</span>
                        </div>
                        <div class="service-status" id="doctorService">
                            <i class="fas fa-circle text-secondary"></i>
                            <span>Doctor Service</span>
                            <span class="status-text">Checking...</span>
                        </div>
                        <div class="service-status" id="appointmentService">
                            <i class="fas fa-circle text-secondary"></i>
                            <span>Appointment Service</span>
                            <span class="status-text">Checking...</span>
                        </div>
                        <div class="service-status" id="gatewayService">
                            <i class="fas fa-circle text-secondary"></i>
                            <span>API Gateway</span>
                            <span class="status-text">Checking...</span>
                        </div>
                    </div>
                </div>
            </div>
        </main>
    </div>

    <!-- Footer -->
    <footer class="footer" style="background-color: #2c3e50; color: white; text-align: center; padding: 2rem 0; margin-top: 3rem;">
        <div class="container">
            <p>&copy; 2025 Patient Record Management System. All rights reserved.</p>
            <p>Built with Spring Boot Microservices</p>
        </div>
    </footer>

    <script src="/js/main.js"></script>
    <script>
        // Dashboard specific JavaScript
        document.addEventListener('DOMContentLoaded', function() {
            loadDashboardData();
            checkServiceStatus();
        });

        function loadDashboardData() {
            // Load statistics
            loadStats();
           
            // Load recent activities
            loadRecentPatients();
            loadUpcomingAppointments();
        }

        function loadStats() {
            // Load patient count
            fetch('/api/patients')
                .then(response => response.json())
                .then(data => {
                    document.getElementById('patientsCount').textContent = data.length || 0;
                })
                .catch(error => {
                    document.getElementById('patientsCount').textContent = 'Error';
                });

            // Load doctor count
            fetch('/api/doctors')
                .then(response => response.json())
                .then(data => {
                    document.getElementById('doctorsCount').textContent = data.length || 0;
                })
                .catch(error => {
                    document.getElementById('doctorsCount').textContent = 'Error';
                });

            // Load appointment count
            fetch('/api/appointments')
                .then(response => response.json())
                .then(data => {
                    document.getElementById('appointmentsCount').textContent = data.length || 0;
                   
                    // Calculate today's appointments
                    const today = new Date().toISOString().split('T')[0];
                    const todaysAppts = data.filter(apt =>
                        apt.appointmentDateTime && apt.appointmentDateTime.startsWith(today)
                    );
                    document.getElementById('todaysAppointments').textContent = todaysAppts.length;
                })
                .catch(error => {
                    document.getElementById('appointmentsCount').textContent = 'Error';
                    document.getElementById('todaysAppointments').textContent = 'Error';
                });
        }

        function loadRecentPatients() {
            fetch('/api/patients')
                .then(response => response.json())
                .then(data => {
                    const recentPatients = data.slice(-5).reverse(); // Get last 5 patients
                    let html = '';
                   
                    if (recentPatients.length > 0) {
                        recentPatients.forEach(patient => {
                            html += `
                                <div style="padding: 0.5rem; border-bottom: 1px solid #ecf0f1; display: flex; justify-content: space-between; align-items: center;">
                                    <div>
                                        <strong>\${patient.firstName} \${patient.lastName}</strong><br>
                                        <small style="color: #7f8c8d;">\${patient.email || 'No email'}</small>
                                    </div>
                                    <a href="/patients/\${patient.id}" class="btn btn-primary btn-sm">
                                        <i class="fas fa-eye"></i>
                                    </a>
                                </div>
                            `;
                        });
                    } else {
                        html = '<p style="text-align: center; color: #7f8c8d;">No patients found</p>';
                    }
                   
                    document.getElementById('recentPatients').innerHTML = html;
                })
                .catch(error => {
                    document.getElementById('recentPatients').innerHTML =
                        '<p style="color: #e74c3c;">Error loading patients</p>';
                });
        }

        function loadUpcomingAppointments() {
            fetch('/api/appointments')
                .then(response => response.json())
                .then(data => {
                    const now = new Date();
                    const upcoming = data
                        .filter(apt => new Date(apt.appointmentDateTime) > now)
                        .sort((a, b) => new Date(a.appointmentDateTime) - new Date(b.appointmentDateTime))
                        .slice(0, 5);
                   
                    let html = '';
                   
                    if (upcoming.length > 0) {
                        upcoming.forEach(appointment => {
                            const date = new Date(appointment.appointmentDateTime);
                            html += `
                                <div style="padding: 0.5rem; border-bottom: 1px solid #ecf0f1; display: flex; justify-content: space-between; align-items: center;">
                                    <div>
                                        <strong>Patient ID: \${appointment.patientId}</strong><br>
                                        <small style="color: #7f8c8d;">\${date.toLocaleString()}</small>
                                    </div>
                                    <a href="/appointments/\${appointment.id}" class="btn btn-warning btn-sm">
                                        <i class="fas fa-eye"></i>
                                    </a>
                                </div>
                            `;
                        });
                    } else {
                        html = '<p style="text-align: center; color: #7f8c8d;">No upcoming appointments</p>';
                    }
                   
                    document.getElementById('upcomingAppointments').innerHTML = html;
                })
                .catch(error => {
                    document.getElementById('upcomingAppointments').innerHTML =
                        '<p style="color: #e74c3c;">Error loading appointments</p>';
                });
        }

        function checkServiceStatus() {
            const services = [
                { id: 'patientService', url: '/api/patients' },
                { id: 'doctorService', url: '/api/doctors' },
                { id: 'appointmentService', url: '/api/appointments' }
            ];

            services.forEach(service => {
                fetch(service.url)
                    .then(response => {
                        const element = document.getElementById(service.id);
                        const icon = element.querySelector('i');
                        const statusText = element.querySelector('.status-text');
                       
                        if (response.ok) {
                            icon.style.color = '#27ae60';
                            statusText.textContent = 'Online';
                            statusText.style.color = '#27ae60';
                        } else {
                            icon.style.color = '#f39c12';
                            statusText.textContent = 'Warning';
                            statusText.style.color = '#f39c12';
                        }
                    })
                    .catch(error => {
                        const element = document.getElementById(service.id);
                        const icon = element.querySelector('i');
                        const statusText = element.querySelector('.status-text');
                       
                        icon.style.color = '#e74c3c';
                        statusText.textContent = 'Offline';
                        statusText.style.color = '#e74c3c';
                    });
            });
        }

        function refreshStats() {
            showLoading();
            loadDashboardData();
            setTimeout(hideLoading, 1000);
        }

        function exportData() {
            alert('Export functionality would be implemented here');
        }

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

    <style>
        .service-status {
            display: flex;
            align-items: center;
            gap: 0.5rem;
            padding: 0.5rem;
            border: 1px solid #ecf0f1;    
            border-radius: 5px;
        }

        .loading-placeholder {
            text-align: center;
            padding: 2rem;
            color: #7f8c8d;
        }
    </style>
</body>
</html>