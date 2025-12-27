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
                    <i class="fas fa-user-${doctor.id != null ? 'edit' : 'plus'}"></i>
                    ${doctor.id != null ? 'Edit Doctor' : 'Add New Doctor'}
                </h1>
                <a href="/doctors" class="btn btn-secondary">
                    <i class="fas fa-arrow-left"></i> Back to Doctors
                </a>
            </div>

            <div class="card">
                <div class="card-header">
                    <h3>
                        <i class="fas fa-user-md"></i>
                        Doctor Information
                    </h3>
                </div>
                <div class="card-body">
                    <form action="${doctor.id != null ? '/doctors/'.concat(doctor.id) : '/doctors'}"
                          method="post" id="doctorForm">
                       
                        <!-- Personal Information Section -->
                        <fieldset style="border: 1px solid #ecf0f1; border-radius: 5px; padding: 1.5rem; margin-bottom: 2rem;">
                            <legend style="font-weight: bold; color: #2c3e50; padding: 0 1rem;">
                                <i class="fas fa-user"></i> Personal Information
                            </legend>
                           
                            <div class="form-grid">
                                <div class="form-group">
                                    <label for="firstName" class="required">First Name:</label>
                                    <input type="text" id="firstName" name="firstName"
                                           value="${doctor.firstName}" required
                                           placeholder="Enter first name">
                                </div>
                               
                                <div class="form-group">
                                    <label for="lastName" class="required">Last Name:</label>
                                    <input type="text" id="lastName" name="lastName"
                                           value="${doctor.lastName}" required
                                           placeholder="Enter last name">
                                </div>
                               
                                <div class="form-group">
                                    <label for="dateOfBirth">Date of Birth:</label>
                                    <input type="date" id="dateOfBirth" name="dateOfBirth"
                                           value="${doctor.availableFromTime}">
                                </div>
                               
                                <div class="form-group">
                                    <label for="gender">Gender:</label>
                                    <select id="gender" name="gender">
                                        <option value="">Select Gender</option>
                                        <option value="Male" ${doctor.gender == 'Male' ? 'selected' : ''}>Male</option>
                                        <option value="Female" ${doctor.gender == 'Female' ? 'selected' : ''}>Female</option>
                                        <option value="Other" ${doctor.gender == 'Other' ? 'selected' : ''}>Other</option>
                                    </select>
                                </div>
                            </div>
                        </fieldset>

                        <!-- Professional Information Section -->
                        <fieldset style="border: 1px solid #ecf0f1; border-radius: 5px; padding: 1.5rem; margin-bottom: 2rem;">
                            <legend style="font-weight: bold; color: #2c3e50; padding: 0 1rem;">
                                <i class="fas fa-stethoscope"></i> Professional Information
                            </legend>
                           
                            <div class="form-grid">
                                <div class="form-group">
                                    <label for="specialization" class="required">Specialization:</label>
                                    <input type="text" id="specialization" name="specialization"
                                           value="${doctor.specialization}" required
                                           placeholder="e.g., Cardiology, Neurology">
                                    <small class="form-help">Enter medical specialization</small>
                                </div>
                               
                                <div class="form-group">
                                    <label for="department" class="required">Department:</label>
                                    <input type="text" id="department" name="department"
                                           value="${doctor.department}" required
                                           placeholder="e.g., Internal Medicine">
                                    <small class="form-help">Hospital department</small>
                                </div>
                               
                                <div class="form-group">
                                    <label for="licenseNumber">License Number:</label>
                                    <input type="text" id="licenseNumber" name="licenseNumber"
                                           value="${doctor.licenseNumber}"
                                           placeholder="Medical license number">
                                </div>
                               
                                <div class="form-group">
                                    <label for="experienceYears">Experience (Years):</label>
                                    <input type="number" id="experienceYears" name="experienceYears"
                                           value="${doctor.experienceYears}" min="0" max="50"
                                           placeholder="Years of experience">
                                </div>
                            </div>
                        </fieldset>

                        <!-- Contact Information Section -->
                        <fieldset style="border: 1px solid #ecf0f1; border-radius: 5px; padding: 1.5rem; margin-bottom: 2rem;">
                            <legend style="font-weight: bold; color: #2c3e50; padding: 0 1rem;">
                                <i class="fas fa-address-book"></i> Contact Information
                            </legend>
                           
                            <div class="form-grid">
                                <div class="form-group">
                                    <label for="phone">Phone Number:</label>
                                    <input type="tel" id="phone" name="phone"
                                           value="${doctor.phoneNumber}"
                                           placeholder="Enter phone number"
                                           pattern="[0-9\-\+\(\)\s]+">
                                </div>
                               
                                <div class="form-group">
                                    <label for="email">Email Address:</label>
                                    <input type="email" id="email" name="email"
                                           value="${doctor.email}"
                                           placeholder="Enter email address">
                                </div>
                            </div>
                           
                            <div class="form-group">
                                <label for="address">Address:</label>
                                <textarea id="address" name="address" rows="3"
                                          placeholder="Enter complete address">${doctor.address}</textarea>
                            </div>
                        </fieldset>

                        <!-- Additional Information Section -->
                        <fieldset style="border: 1px solid #ecf0f1; border-radius: 5px; padding: 1.5rem; margin-bottom: 2rem;">
                            <legend style="font-weight: bold; color: #2c3e50; padding: 0 1rem;">
                                <i class="fas fa-info-circle"></i> Additional Information
                            </legend>
                           
                            <div class="form-group">
                                <label for="qualifications">Qualifications:</label>
                                <textarea id="qualifications" name="qualifications" rows="3"
                                          placeholder="Enter medical qualifications and degrees">${doctor.qualifications}</textarea>
                                <small class="form-help">List degrees, certifications, and medical qualifications</small>
                            </div>
                           
                            <div class="form-group">
                                <label for="consultationFee">Consultation Fee:</label>
                                <div class="input-group">
                                    <span class="input-group-addon">$</span>
                                    <input type="number" id="consultationFee" name="consultationFee"
                                           value="${doctor.consultationFee}" min="0" step="0.01"
                                           placeholder="0.00">
                                </div>
                            </div>
                           
                            <div class="form-group">
                                <label for="availableHours">Available Hours:</label>
                                <input type="text" id="availableHours" name="availableHours"
                                       value="${doctor.availableFromTime}"
                                       placeholder="e.g., Mon-Fri 9:00 AM - 5:00 PM">
                                <small class="form-help">Working hours and availability</small>
                            </div>
                        </fieldset>

                        <!-- Form Actions -->
                        <div class="form-actions" style="text-align: center; padding-top: 2rem; border-top: 1px solid #ecf0f1;">
                            <button type="submit" class="btn btn-primary btn-large">
                                <i class="fas fa-save"></i>
                                ${doctor.id != null ? 'Update Doctor' : 'Save Doctor'}
                            </button>
                            <a href="/doctors" class="btn btn-secondary btn-large">
                                <i class="fas fa-times"></i> Cancel
                            </a>
                            <c:if test="${doctor.id != null}">
                                <a href="/doctors/${doctor.id}" class="btn btn-info btn-large">
                                    <i class="fas fa-eye"></i> View Details
                                </a>
                            </c:if>
                        </div>
                    </form>
                </div>
            </div>
        </main>
    </div>

    <!-- Scripts -->
    <script src="/js/main.js"></script>
    <script>
        // Form validation
        document.getElementById('doctorForm').addEventListener('submit', function(e) {
            const firstName = document.getElementById('firstName').value.trim();
            const lastName = document.getElementById('lastName').value.trim();
            const specialization = document.getElementById('specialization').value.trim();
            const department = document.getElementById('department').value.trim();
           
            if (!firstName || !lastName || !specialization || !department) {
                e.preventDefault();
                alert('Please fill in all required fields marked with *');
                return false;
            }
           
            // Email validation
            const email = document.getElementById('email').value.trim();
            if (email && !isValidEmail(email)) {
                e.preventDefault();
                alert('Please enter a valid email address');
                return false;
            }
        });
       
        function isValidEmail(email) {
            const emailRegex = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;
            return emailRegex.test(email);
        }

        // Initialize time display
        updateTime();
        setInterval(updateTime, 1000);
    </script>

</body>
</html>
