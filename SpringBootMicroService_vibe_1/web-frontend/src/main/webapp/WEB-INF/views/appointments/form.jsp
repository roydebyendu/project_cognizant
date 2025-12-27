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
                <li><a href="/doctors"><i class="fas fa-user-md"></i> Doctors</a></li>
                <li><a href="/appointments" class="active"><i class="fas fa-calendar-alt"></i> Appointments</a></li>
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
                    <i class="fas fa-calendar-${appointment.id != null ? 'edit' : 'plus'}"></i>
                    ${appointment.id != null ? 'Edit Appointment' : 'Schedule New Appointment'}
                </h1>
                <a href="/appointments" class="btn btn-secondary">
                    <i class="fas fa-arrow-left"></i> Back to Appointments
                </a>
            </div>

            <div class="card">
                <div class="card-header">
                    <h3>
                        <i class="fas fa-calendar-alt"></i>
                        Appointment Details
                    </h3>
                </div>
                <div class="card-body">
                    <form action="${appointment.id != null ? '/appointments/'.concat(appointment.id) : '/appointments'}"
                          method="post" id="appointmentForm">
                       
                        <!-- Patient and Doctor Selection -->
                        <fieldset style="border: 1px solid #ecf0f1; border-radius: 5px; padding: 1.5rem; margin-bottom: 2rem;">
                            <legend style="font-weight: bold; color: #2c3e50; padding: 0 1rem;">
                                <i class="fas fa-users"></i> Patient & Doctor
                            </legend>
                           
                            <div class="form-grid">
                                <div class="form-group">
                                    <label for="patientId" class="required">Patient:</label>
                                    <select id="patientId" name="patientId" required>
                                        <option value="">Select Patient</option>
                                        <c:forEach var="patient" items="${patients}">
                                            <option value="${patient.id}"
                                                    ${appointment.patientId == patient.id ? 'selected' : ''}>
                                                ${patient.firstName} ${patient.lastName} (ID: ${patient.id})
                                            </option>
                                        </c:forEach>
                                    </select>
                                    <small class="form-help">Choose the patient for this appointment</small>
                                </div>
                               
                                <div class="form-group">
                                    <label for="doctorId" class="required">Doctor:</label>
                                    <select id="doctorId" name="doctorId" required>
                                        <option value="">Select Doctor</option>
                                        <c:forEach var="doctor" items="${doctors}">
                                            <option value="${doctor.id}"
                                                    ${appointment.doctorId == doctor.id ? 'selected' : ''}
                                                    data-specialization="${doctor.specialization}">
                                                Dr. ${doctor.firstName} ${doctor.lastName} - ${doctor.specialization} (ID: ${doctor.id})
                                            </option>
                                        </c:forEach>
                                    </select>
                                    <small class="form-help">Choose the attending doctor</small>
                                </div>
                            </div>
                        </fieldset>

                        <!-- Appointment Date and Time -->
                        <fieldset style="border: 1px solid #ecf0f1; border-radius: 5px; padding: 1.5rem; margin-bottom: 2rem;">
                            <legend style="font-weight: bold; color: #2c3e50; padding: 0 1rem;">
                                <i class="fas fa-calendar-clock"></i> Date & Time
                            </legend>
                           
                            <div class="form-grid">
                                <div class="form-group">
                                    <label for="appointmentDate" class="required">Appointment Date:</label>
                                    <input type="date" id="appointmentDate" name="appointmentDate"
                                           value="<fmt:formatDate value='${appointment.appointmentDateTime}' pattern='yyyy-MM-dd'/>"
                                           required min="${today}">
                                    <small class="form-help">Select appointment date</small>
                                </div>
                               
                                <div class="form-group">
                                    <label for="appointmentTime" class="required">Appointment Time:</label>
                                    <input type="time" id="appointmentTime" name="appointmentTime"
                                           value="<fmt:formatDate value='${appointment.appointmentDateTime}' pattern='HH:mm'/>"
                                           required>
                                    <small class="form-help">Select appointment time</small>
                                </div>
                               
                                <div class="form-group">
                                    <label for="duration">Duration (minutes):</label>
                                    <select id="duration" name="duration">
                                        <option value="">Select Duration</option>
                                        <option value="15" ${appointment.duration == 15 ? 'selected' : ''}>15 minutes</option>
                                        <option value="30" ${appointment.duration == 30 ? 'selected' : ''}>30 minutes</option>
                                        <option value="45" ${appointment.duration == 45 ? 'selected' : ''}>45 minutes</option>
                                        <option value="60" ${appointment.duration == 60 ? 'selected' : ''}>1 hour</option>
                                        <option value="90" ${appointment.duration == 90 ? 'selected' : ''}>1.5 hours</option>
                                        <option value="120" ${appointment.duration == 120 ? 'selected' : ''}>2 hours</option>
                                    </select>
                                </div>
                               
                                <div class="form-group">
                                    <label for="appointmentType">Appointment Type:</label>
                                    <select id="appointmentType" name="appointmentType">
                                        <option value="">Select Type</option>
                                        <option value="CONSULTATION" ${appointment.appointmentType == 'CONSULTATION' ? 'selected' : ''}>Consultation</option>
                                        <option value="FOLLOW_UP" ${appointment.appointmentType == 'FOLLOW_UP' ? 'selected' : ''}>Follow-up</option>
                                        <option value="EMERGENCY" ${appointment.appointmentType == 'EMERGENCY' ? 'selected' : ''}>Emergency</option>
                                        <option value="ROUTINE_CHECKUP" ${appointment.appointmentType == 'ROUTINE_CHECKUP' ? 'selected' : ''}>Routine Checkup</option>
                                        <option value="DIAGNOSTIC" ${appointment.appointmentType == 'DIAGNOSTIC' ? 'selected' : ''}>Diagnostic</option>
                                        <option value="SURGICAL" ${appointment.appointmentType == 'SURGICAL' ? 'selected' : ''}>Surgical</option>
                                    </select>
                                </div>
                            </div>
                        </fieldset>

                        <!-- Appointment Status and Priority -->
                        <c:if test="${appointment.id != null}">
                            <fieldset style="border: 1px solid #ecf0f1; border-radius: 5px; padding: 1.5rem; margin-bottom: 2rem;">
                                <legend style="font-weight: bold; color: #2c3e50; padding: 0 1rem;">
                                    <i class="fas fa-flag"></i> Status & Priority
                                </legend>
                               
                                <div class="form-grid">
                                    <div class="form-group">
                                        <label for="status">Status:</label>
                                        <select id="status" name="status">
                                            <option value="SCHEDULED" ${appointment.status == 'SCHEDULED' ? 'selected' : ''}>Scheduled</option>
                                            <option value="CONFIRMED" ${appointment.status == 'CONFIRMED' ? 'selected' : ''}>Confirmed</option>
                                            <option value="IN_PROGRESS" ${appointment.status == 'IN_PROGRESS' ? 'selected' : ''}>In Progress</option>
                                            <option value="COMPLETED" ${appointment.status == 'COMPLETED' ? 'selected' : ''}>Completed</option>
                                            <option value="CANCELLED" ${appointment.status == 'CANCELLED' ? 'selected' : ''}>Cancelled</option>
                                            <option value="NO_SHOW" ${appointment.status == 'NO_SHOW' ? 'selected' : ''}>No Show</option>
                                        </select>
                                    </div>
                                   
                                    <div class="form-group">
                                        <label for="priority">Priority:</label>
                                        <select id="priority" name="priority">
                                            <option value="">Select Priority</option>
                                            <option value="LOW" ${appointment.priority == 'LOW' ? 'selected' : ''}>Low</option>
                                            <option value="NORMAL" ${appointment.priority == 'NORMAL' ? 'selected' : ''}>Normal</option>
                                            <option value="HIGH" ${appointment.priority == 'HIGH' ? 'selected' : ''}>High</option>
                                            <option value="URGENT" ${appointment.priority == 'URGENT' ? 'selected' : ''}>Urgent</option>
                                        </select>
                                    </div>
                                </div>
                            </fieldset>
                        </c:if>

                        <!-- Notes and Additional Information -->
                        <fieldset style="border: 1px solid #ecf0f1; border-radius: 5px; padding: 1.5rem; margin-bottom: 2rem;">
                            <legend style="font-weight: bold; color: #2c3e50; padding: 0 1rem;">
                                <i class="fas fa-sticky-note"></i> Notes & Information
                            </legend>
                           
                            <div class="form-group">
                                <label for="reason">Reason for Visit:</label>
                                <textarea id="reason" name="reason" rows="3"
                                          placeholder="Enter the reason for this appointment">${appointment.reason}</textarea>
                                <small class="form-help">Brief description of the reason for the visit</small>
                            </div>
                           
                            <div class="form-group">
                                <label for="notes">Additional Notes:</label>
                                <textarea id="notes" name="notes" rows="4"
                                          placeholder="Any additional notes or special instructions">${appointment.notes}</textarea>
                                <small class="form-help">Any special instructions, preparation notes, or additional information</small>
                            </div>
                        </fieldset>

                        <!-- Form Actions -->
                        <div class="form-actions" style="text-align: center; padding-top: 2rem; border-top: 1px solid #ecf0f1;">
                            <button type="submit" class="btn btn-primary btn-large">
                                <i class="fas fa-save"></i>
                                ${appointment.id != null ? 'Update Appointment' : 'Schedule Appointment'}
                            </button>
                            <a href="/appointments" class="btn btn-secondary btn-large">
                                <i class="fas fa-times"></i> Cancel
                            </a>
                            <c:if test="${appointment.id != null}">
                                <a href="/appointments/${appointment.id}" class="btn btn-info btn-large">
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
        // Set minimum date to today
        document.getElementById('appointmentDate').min = new Date().toISOString().split('T')[0];
       
        // Form validation
        document.getElementById('appointmentForm').addEventListener('submit', function(e) {
            const patientId = document.getElementById('patientId').value;
            const doctorId = document.getElementById('doctorId').value;
            const appointmentDate = document.getElementById('appointmentDate').value;
            const appointmentTime = document.getElementById('appointmentTime').value;
           
            if (!patientId || !doctorId || !appointmentDate || !appointmentTime) {
                e.preventDefault();
                alert('Please fill in all required fields marked with *');
                return false;
            }
           
            // Check if appointment is in the past
            const appointmentDateTime = new Date(appointmentDate + 'T' + appointmentTime);
            const now = new Date();
           
            if (appointmentDateTime <= now) {
                e.preventDefault();
                alert('Appointment date and time must be in the future');
                return false;
            }
        });
       
        // Show doctor specialization when selected
        document.getElementById('doctorId').addEventListener('change', function() {
            const selectedOption = this.options[this.selectedIndex];
            const specialization = selectedOption.getAttribute('data-specialization');
           
            // You could show this information somewhere on the form
            console.log('Selected doctor specialization:', specialization);
        });

        // Initialize time display
        updateTime();
        setInterval(updateTime, 1000);
    </script>

</body>
</html>