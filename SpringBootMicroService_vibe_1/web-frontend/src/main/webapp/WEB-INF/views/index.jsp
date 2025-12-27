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
                <li><a href="/" class="active"><i class="fas fa-home"></i> Home</a></li>
                <li><a href="/dashboard"><i class="fas fa-tachometer-alt"></i> Dashboard</a></li>
                <li><a href="/patients"><i class="fas fa-user-injured"></i> Patients</a></li>
                <li><a href="/doctors"><i class="fas fa-user-md"></i> Doctors</a></li>
                <li><a href="/appointments"><i class="fas fa-calendar-alt"></i> Appointments</a></li>
            </ul>
        </div>
    </nav>

    <!-- Main Content -->
    <div class="container">
        <main class="main-content">
            <div class="text-center mb-3">
                <h1 class="page-title">
                    <i class="fas fa-hospital-alt" style="color: #3498db;"></i>
                    Welcome to Patient Record Management System
                </h1>
                <p style="font-size: 1.2rem; color: #7f8c8d; margin-bottom: 3rem;">
                    A comprehensive solution for managing patient records, doctor information, and appointments
                </p>
            </div>

            <!-- Quick Actions -->
            <div class="dashboard-stats">
                <div class="stat-card patients">
                    <div class="stat-content">
                        <i class="fas fa-user-injured" style="font-size: 3rem; margin-bottom: 1rem;"></i>
                        <h3>Manage Patients</h3>
                        <p>Add, edit, and view patient records with comprehensive medical information</p>
                        <a href="/patients" class="btn btn-primary" style="margin-top: 1rem;">
                            <i class="fas fa-arrow-right"></i> View Patients
                        </a>
                    </div>
                </div>

                <div class="stat-card doctors">
                    <div class="stat-content">
                        <i class="fas fa-user-md" style="font-size: 3rem; margin-bottom: 1rem;"></i>
                        <h3>Manage Doctors</h3>
                        <p>Maintain doctor profiles, specializations, and availability schedules</p>
                        <a href="/doctors" class="btn btn-primary" style="margin-top: 1rem;">
                            <i class="fas fa-arrow-right"></i> View Doctors
                        </a>
                    </div>
                </div>

                <div class="stat-card appointments">
                    <div class="stat-content">
                        <i class="fas fa-calendar-alt" style="font-size: 3rem; margin-bottom: 1rem;"></i>
                        <h3>Schedule Appointments</h3>
                        <p>Book and manage appointments between patients and doctors</p>
                        <a href="/appointments" class="btn btn-primary" style="margin-top: 1rem;">
                            <i class="fas fa-arrow-right"></i> View Appointments
                        </a>
                    </div>
                </div>

                <div class="stat-card" style="background: linear-gradient(135deg, #9b59b6 0%, #8e44ad 100%); box-shadow: 0 4px 15px rgba(155, 89, 182, 0.3);">
                    <div class="stat-content">
                        <i class="fas fa-tachometer-alt" style="font-size: 3rem; margin-bottom: 1rem;"></i>
                        <h3>Dashboard</h3>
                        <p>Get an overview of all system statistics and recent activities</p>
                        <a href="/dashboard" class="btn btn-primary" style="margin-top: 1rem;">
                            <i class="fas fa-arrow-right"></i> View Dashboard
                        </a>
                    </div>
                </div>
            </div>

            <!-- Features Section -->
            <div class="card mt-3">
                <div class="card-header">
                    <h3><i class="fas fa-star"></i> System Features</h3>
                </div>
                <div class="card-body">
                    <div style="display: grid; grid-template-columns: repeat(auto-fit, minmax(300px, 1fr)); gap: 2rem;">
                        <div>
                            <h4><i class="fas fa-shield-alt" style="color: #27ae60;"></i> Secure Data Management</h4>
                            <p>All patient data is securely stored and managed with proper validation and error handling.</p>
                        </div>
                        <div>
                            <h4><i class="fas fa-search" style="color: #3498db;"></i> Advanced Search</h4>
                            <p>Search patients by name, blood type, or contact information. Find doctors by specialization.</p>
                        </div>
                        <div>
                            <h4><i class="fas fa-calendar-check" style="color: #f39c12;"></i> Appointment Management</h4>
                            <p>Schedule, update, and track appointments with real-time status updates.</p>
                        </div>
                        <div>
                            <h4><i class="fas fa-mobile-alt" style="color: #e74c3c;"></i> Responsive Design</h4>
                            <p>Access the system from any device with our mobile-friendly responsive interface.</p>
                        </div>
                        <div>
                            <h4><i class="fas fa-network-wired" style="color: #9b59b6;"></i> Microservices Architecture</h4>
                            <p>Built with Spring Boot microservices for scalability and maintainability.</p>
                        </div>
                        <div>
                            <h4><i class="fas fa-database" style="color: #34495e;"></i> JDBC Integration</h4>
                            <p>Efficient database operations with Spring Data JDBC for optimal performance.</p>
                        </div>
                    </div>
                </div>
            </div>

            <!-- Quick Start Guide -->
            <div class="card mt-3">
                <div class="card-header">
                    <h3><i class="fas fa-rocket"></i> Quick Start Guide</h3>
                </div>
                <div class="card-body">
                    <div style="display: grid; grid-template-columns: repeat(auto-fit, minmax(250px, 1fr)); gap: 1.5rem;">
                        <div style="text-align: center; padding: 1rem; border: 2px solid #ecf0f1; border-radius: 8px;">
                            <div style="background-color: #3498db; color: white; width: 40px; height: 40px; border-radius: 50%; display: flex; align-items: center; justify-content: center; margin: 0 auto 1rem;">1</div>
                            <h5>Add Doctors</h5>
                            <p>Start by adding doctors with their specializations and availability.</p>
                        </div>
                        <div style="text-align: center; padding: 1rem; border: 2px solid #ecf0f1; border-radius: 8px;">
                            <div style="background-color: #27ae60; color: white; width: 40px; height: 40px; border-radius: 50%; display: flex; align-items: center; justify-content: center; margin: 0 auto 1rem;">2</div>
                            <h5>Register Patients</h5>
                            <p>Add patient information including medical history and contact details.</p>
                        </div>
                        <div style="text-align: center; padding: 1rem; border: 2px solid #ecf0f1; border-radius: 8px;">
                            <div style="background-color: #f39c12; color: white; width: 40px; height: 40px; border-radius: 50%; display: flex; align-items: center; justify-content: center; margin: 0 auto 1rem;">3</div>
                            <h5>Schedule Appointments</h5>
                            <p>Book appointments between patients and doctors based on availability.</p>
                        </div>
                        <div style="text-align: center; padding: 1rem; border: 2px solid #ecf0f1; border-radius: 8px;">
                            <div style="background-color: #9b59b6; color: white; width: 40px; height: 40px; border-radius: 50%; display: flex; align-items: center; justify-content: center; margin: 0 auto 1rem;">4</div>
                            <h5>Monitor & Manage</h5>
                            <p>Use the dashboard to monitor system activity and manage records.</p>
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
            <p>Built with Spring Boot Microservices & JDBC</p>
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