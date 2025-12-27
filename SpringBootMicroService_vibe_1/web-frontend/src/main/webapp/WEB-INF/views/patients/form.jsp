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
                    <i class="fas fa-user-${patient.id != null ? 'edit' : 'plus'}"></i>
                    ${patient.id != null ? 'Edit Patient' : 'Add New Patient'}
                </h1>
                <a href="/patients" class="btn btn-secondary">
                    <i class="fas fa-arrow-left"></i> Back to Patients
                </a>
            </div>

            <div class="card">
                <div class="card-header">
                    <h3>
                        <i class="fas fa-user-injured"></i>
                        Patient Information
                    </h3>
                </div>
                <div class="card-body">
                    <form action="${patient.id != null ? '/patients/'.concat(patient.id) : '/patients'}"
                          method="post" id="patientForm">
                       
                        <!-- Personal Information Section -->
                        <fieldset style="border: 1px solid #ecf0f1; border-radius: 5px; padding: 1.5rem; margin-bottom: 2rem;">
                            <legend style="font-weight: bold; color: #2c3e50; padding: 0 1rem;">
                                <i class="fas fa-user"></i> Personal Information
                            </legend>
                           
                            <div class="form-row">
                                <div class="form-col">
                                    <label for="firstName" class="form-label">
                                        First Name <span style="color: #e74c3c;">*</span>
                                    </label>
                                    <input type="text" id="firstName" name="firstName" class="form-control"
                                           value="${patient.firstName}" required maxlength="50"
                                           placeholder="Enter first name">
                                </div>
                                <div class="form-col">
                                    <label for="lastName" class="form-label">
                                        Last Name <span style="color: #e74c3c;">*</span>
                                    </label>
                                    <input type="text" id="lastName" name="lastName" class="form-control"
                                           value="${patient.lastName}" required maxlength="50"
                                           placeholder="Enter last name">
                                </div>
                            </div>

                            <div class="form-row">
                                <div class="form-col">
                                    <label for="dateOfBirth" class="form-label">Date of Birth</label>
                                    <input type="date" id="dateOfBirth" name="dateOfBirth" class="form-control"
                                           value="<fmt:formatDate value='${patient.dateOfBirth}' pattern='yyyy-MM-dd' />">
                                </div>
                                <div class="form-col">
                                    <label for="gender" class="form-label">Gender</label>
                                    <select id="gender" name="gender" class="form-control">
                                        <option value="">Select Gender</option>
                                        <option value="Male" ${patient.gender == 'Male' ? 'selected' : ''}>Male</option>
                                        <option value="Female" ${patient.gender == 'Female' ? 'selected' : ''}>Female</option>
                                        <option value="Other" ${patient.gender == 'Other' ? 'selected' : ''}>Other</option>
                                    </select>
                                </div>
                            </div>

                            <div class="form-group">
                                <label for="address" class="form-label">Address</label>
                                <textarea id="address" name="address" class="form-control" rows="3"
                                          placeholder="Enter full address">${patient.address}</textarea>
                            </div>
                        </fieldset>

                        <!-- Contact Information Section -->
                        <fieldset style="border: 1px solid #ecf0f1; border-radius: 5px; padding: 1.5rem; margin-bottom: 2rem;">
                            <legend style="font-weight: bold; color: #2c3e50; padding: 0 1rem;">
                                <i class="fas fa-phone"></i> Contact Information
                            </legend>
                           
                            <div class="form-row">
                                <div class="form-col">
                                    <label for="email" class="form-label">Email Address</label>
                                    <input type="email" id="email" name="email" class="form-control"
                                           value="${patient.email}" maxlength="100"
                                           placeholder="Enter email address">
                                </div>
                                <div class="form-col">
                                    <label for="phoneNumber" class="form-label">Phone Number</label>
                                    <input type="tel" id="phoneNumber" name="phoneNumber" class="form-control"
                                           value="${patient.phoneNumber}" maxlength="20"
                                           placeholder="Enter phone number">
                                </div>
                            </div>
                        </fieldset>

                        <!-- Medical Information Section -->
                        <fieldset style="border: 1px solid #ecf0f1; border-radius: 5px; padding: 1.5rem; margin-bottom: 2rem;">
                            <legend style="font-weight: bold; color: #2c3e50; padding: 0 1rem;">
                                <i class="fas fa-heartbeat"></i> Medical Information
                            </legend>
                           
                            <div class="form-group">
                                <label for="bloodType" class="form-label">Blood Type</label>
                                <select id="bloodType" name="bloodType" class="form-control">
                                    <option value="">Select Blood Type</option>
                                    <option value="A+" ${patient.bloodType == 'A+' ? 'selected' : ''}>A+</option>
                                    <option value="A-" ${patient.bloodType == 'A-' ? 'selected' : ''}>A-</option>
                                    <option value="B+" ${patient.bloodType == 'B+' ? 'selected' : ''}>B+</option>
                                    <option value="B-" ${patient.bloodType == 'B-' ? 'selected' : ''}>B-</option>
                                    <option value="AB+" ${patient.bloodType == 'AB+' ? 'selected' : ''}>AB+</option>
                                    <option value="AB-" ${patient.bloodType == 'AB-' ? 'selected' : ''}>AB-</option>
                                    <option value="O+" ${patient.bloodType == 'O+' ? 'selected' : ''}>O+</option>
                                    <option value="O-" ${patient.bloodType == 'O-' ? 'selected' : ''}>O-</option>
                                </select>
                            </div>
                        </fieldset>

                        <!-- Emergency Contact Section -->
                        <fieldset style="border: 1px solid #ecf0f1; border-radius: 5px; padding: 1.5rem; margin-bottom: 2rem;">
                            <legend style="font-weight: bold; color: #2c3e50; padding: 0 1rem;">
                                <i class="fas fa-exclamation-triangle"></i> Emergency Contact
                            </legend>
                           
                            <div class="form-row">
                                <div class="form-col">
                                    <label for="emergencyContact" class="form-label">Emergency Contact Name</label>
                                    <input type="text" id="emergencyContact" name="emergencyContact" class="form-control"
                                           value="${patient.emergencyContact}" maxlength="100"
                                           placeholder="Enter emergency contact name">
                                </div>
                                <div class="form-col">
                                    <label for="emergencyContactPhone" class="form-label">Emergency Contact Phone</label>
                                    <input type="tel" id="emergencyContactPhone" name="emergencyContactPhone" class="form-control"
                                           value="${patient.emergencyContactPhone}" maxlength="20"
                                           placeholder="Enter emergency contact phone">
                                </div>
                            </div>
                        </fieldset>

                        <!-- Form Actions -->
                        <div class="form-actions" style="display: flex; gap: 1rem; justify-content: flex-end; margin-top: 2rem;">
                            <a href="/patients" class="btn btn-secondary">
                                <i class="fas fa-times"></i> Cancel
                            </a>
                            <button type="reset" class="btn btn-warning">
                                <i class="fas fa-undo"></i> Reset
                            </button>
                            <button type="submit" class="btn btn-success">
                                <i class="fas fa-save"></i>
                                ${patient.id != null ? 'Update Patient' : 'Save Patient'}
                            </button>
                        </div>
                    </form>
                </div>
            </div>

            <!-- Help Section -->
            <div class="card mt-3">
                <div class="card-header">
                    <h4><i class="fas fa-info-circle"></i> Help & Guidelines</h4>
                </div>
                <div class="card-body">
                    <div style="display: grid; grid-template-columns: repeat(auto-fit, minmax(300px, 1fr)); gap: 1.5rem;">
                        <div>
                            <h5><i class="fas fa-asterisk" style="color: #e74c3c;"></i> Required Fields</h5>
                            <p>Fields marked with a red asterisk (*) are required and must be filled out.</p>
                        </div>
                        <div>
                            <h5><i class="fas fa-shield-alt" style="color: #27ae60;"></i> Data Privacy</h5>
                            <p>All patient information is securely stored and protected according to privacy regulations.</p>
                        </div>
                        <div>
                            <h5><i class="fas fa-phone" style="color: #3498db;"></i> Phone Format</h5>
                            <p>Enter phone numbers with country code for international numbers (e.g., +1234567890).</p>
                        </div>
                        <div>
                            <h5><i class="fas fa-envelope" style="color: #f39c12;"></i> Email Validation</h5>
                            <p>Ensure email addresses are valid as they may be used for appointment notifications.</p>
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
        </div>
    </footer>

    <script src="/js/main.js"></script>
    <script>
        document.addEventListener('DOMContentLoaded', function() {
            // Setup auto-save for this form
            setupAutoSave('#patientForm');
           
            // Add real-time validation
            setupRealTimeValidation();
        });

        function setupRealTimeValidation() {
            const emailField = document.getElementById('email');
            const phoneField = document.getElementById('phoneNumber');
            const emergencyPhoneField = document.getElementById('emergencyContactPhone');

            // Email validation
            emailField.addEventListener('blur', function() {
                if (this.value && !isValidEmail(this.value)) {
                    this.style.borderColor = '#e74c3c';
                    showFieldError(this, 'Please enter a valid email address');
                } else {
                    this.style.borderColor = '#27ae60';
                    clearFieldError(this);
                }
            });

            // Phone validation
            [phoneField, emergencyPhoneField].forEach(field => {
                field.addEventListener('blur', function() {
                    if (this.value && !isValidPhone(this.value)) {
                        this.style.borderColor = '#e74c3c';
                        showFieldError(this, 'Please enter a valid phone number');
                    } else if (this.value) {
                        this.style.borderColor = '#27ae60';
                        clearFieldError(this);
                    }
                });
            });

            // Age calculation
            const dobField = document.getElementById('dateOfBirth');
            dobField.addEventListener('change', function() {
                if (this.value) {
                    const age = calculateAge(new Date(this.value));
                    if (age < 0) {
                        this.style.borderColor = '#e74c3c';
                        showFieldError(this, 'Date of birth cannot be in the future');
                    } else if (age > 150) {
                        this.style.borderColor = '#f39c12';
                        showFieldError(this, 'Please verify the date of birth');
                    } else {
                        this.style.borderColor = '#27ae60';
                        clearFieldError(this);
                    }
                }
            });
        }

        function calculateAge(birthDate) {
            const today = new Date();
            let age = today.getFullYear() - birthDate.getFullYear();
            const monthDiff = today.getMonth() - birthDate.getMonth();
           
            if (monthDiff < 0 || (monthDiff === 0 && today.getDate() < birthDate.getDate())) {
                age--;
            }
           
            return age;
        }

        function showFieldError(field, message) {
            clearFieldError(field);
           
            const errorDiv = document.createElement('div');
            errorDiv.className = 'field-error';
            errorDiv.style.cssText = 'color: #e74c3c; font-size: 0.8rem; margin-top: 0.25rem;';
            errorDiv.textContent = message;
           
            field.parentNode.appendChild(errorDiv);
        }

        function clearFieldError(field) {
            const existingError = field.parentNode.querySelector('.field-error');
            if (existingError) {
                existingError.remove();
            }
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
</body>
</html>
