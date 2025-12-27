<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>${title} - Patient Record Management System</title>
   
    <!-- Custom CSS -->
    <link rel="stylesheet" href="/css/style.css">
   
    <!-- Favicon -->
    <link rel="icon" type="image/x-icon" href="/favicon.ico">
   
    <!-- Font Awesome for icons -->
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
    <!--nav class="navbar">
        <div class="container">
            <ul>
                <li><a href="/" class="${pageContext.request.requestURI == '/' ? 'active' : ''}">
                    <i class="fas fa-home"></i> Home
                </a></li>
                <li><a href="/dashboard" class="${pageContext.request.requestURI == '/dashboard' ? 'active' : ''}">
                    <i class="fas fa-tachometer-alt"></i> Dashboard
                </a></li>
                <li><a href="/patients" class="${fn:startsWith(pageContext.request.requestURI, '/patients') ? 'active' : ''}">
                    <i class="fas fa-user-injured"></i> Patients
                </a></li>
                <li><a href="/doctors" class="${fn:startsWith(pageContext.request.requestURI, '/doctors') ? 'active' : ''}">
                    <i class="fas fa-user-md"></i> Doctors
                </a></li>
                <li><a href="/appointments" class="${fn:startsWith(pageContext.request.requestURI, '/appointments') ? 'active' : ''}">
                    <i class="fas fa-calendar-alt"></i> Appointments
                </a></li>
            </ul>
        </div>
    </nav-->

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
       
        <c:if test="${not empty warning}">
            <div class="alert alert-warning">
                <i class="fas fa-exclamation-triangle"></i> ${warning}
            </div>
        </c:if>
       
        <c:if test="${not empty info}">
            <div class="alert alert-info">
                <i class="fas fa-info-circle"></i> ${info}
            </div>
        </c:if>

        <main class="main-content">
            <!-- Page content will be inserted here -->
        </main>
    </div>

    <!-- Footer -->
    <footer class="footer" style="background-color: #2c3e50; color: white; text-align: center; padding: 2rem 0; margin-top: 3rem;">
        <div class="container">
            <p>&copy; 2025 Patient Record Management System. All rights reserved.</p>
            <p>Built with Spring Boot Microservices</p>
        </div>
    </footer>

    <!-- JavaScript -->
    <script src="/js/main.js"></script>
   
    <script>
        // Update current time
        function updateTime() {
            const now = new Date();
            const timeString = now.toLocaleString();
            const timeElement = document.getElementById('currentTime');
            if (timeElement) {
                timeElement.textContent = timeString;
            }
        }
       
        // Update time every second
        setInterval(updateTime, 1000);
        updateTime(); // Initial call
    </script>
</body>
</html>