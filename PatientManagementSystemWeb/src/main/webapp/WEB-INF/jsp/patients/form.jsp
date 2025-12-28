<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>${patient.id != null ? 'Edit' : 'Add'} Patient - Patient Management System</title>
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
            <li><a href="/web/patients" class="active">
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
            <div style="display: flex; justify-content: space-between; align-items: center; margin-bottom: 2rem;">
                <h2>
                    <i class="fas fa-user-${patient.id != null ? 'edit' : 'plus'}"></i>
                    ${patient.id != null ? 'Edit' : 'Add New'} Patient
                </h2>
                <a href="/web/patients" class="btn btn-secondary">
                    <i class="fas fa-arrow-left"></i> Back to Patients
                </a>
            </div>

            <div class="form-container">
                <form action="/web/patients/save" method="post">
                    <c:if test="${patient.id != null}">
                        <input type="hidden" name="id" value="${patient.id}"/>
                    </c:if>

                    <!-- Personal Information -->
                    <div class="card">
                        <div class="card-header">
                            <h3 class="card-title"><i class="fas fa-user"></i> Personal Information</h3>
                        </div>
                       
                        <div class="form-row">
                            <div class="form-group">
                                <label for="firstName">First Name *</label>
                                <input type="text"
                                       id="firstName"
                                       name="firstName"
                                       class="form-control"
                                       value="${patient.firstName}"
                                       required>
                            </div>
                            <div class="form-group">
                                <label for="lastName">Last Name *</label>
                                <input type="text"
                                       id="lastName"
                                       name="lastName"
                                       class="form-control"
                                       value="${patient.lastName}"
                                       required>
                            </div>
                        </div>

                        <div class="form-row">
                            <div class="form-group">
                                <label for="email">Email</label>
                                <input type="email"
                                       id="email"
                                       name="email"
                                       class="form-control"
                                       value="${patient.email}">
                            </div>
                            <div class="form-group">
                                <label for="phoneNumber">Phone Number</label>
                                <input type="tel"
                                       id="phoneNumber"
                                       name="phoneNumber"
                                       class="form-control"
                                       value="${patient.phoneNumber}">
                            </div>
                        </div>

                        <div class="form-row">
                            <div class="form-group">
                                <label for="dateOfBirth">Date of Birth *</label>
                                <input type="date"
                                       id="dateOfBirth"
                                       name="dateOfBirth"
                                       class="form-control"
                                       value="${patient.dateOfBirth}"
                                       required>
                            </div>
                            <div class="form-group">
                                <label for="gender">Gender</label>
                                <select id="gender" name="gender" class="form-control">
                                    <option value="">Select Gender</option>
                                    <option value="MALE" ${patient.gender == 'MALE' ? 'selected' : ''}>Male</option>
                                    <option value="FEMALE" ${patient.gender == 'FEMALE' ? 'selected' : ''}>Female</option>
                                    <option value="OTHER" ${patient.gender == 'OTHER' ? 'selected' : ''}>Other</option>
                                </select>
                            </div>
                        </div>

                        <div class="form-group">
                            <label for="address">Address</label>
                            <textarea id="address"
                                      name="address"
                                      class="form-control"
                                      rows="3">${patient.address}</textarea>
                        </div>
                    </div>

                    <!-- Emergency Contact -->
                    <div class="card">
                        <div class="card-header">
                            <h3 class="card-title"><i class="fas fa-phone"></i> Emergency Contact</h3>
                        </div>
                       
                        <div class="form-row">
                            <div class="form-group">
                                <label for="emergencyContactName">Emergency Contact Name</label>
                                <input type="text"
                                       id="emergencyContactName"
                                       name="emergencyContactName"
                                       class="form-control"
                                       value="${patient.emergencyContactName}">
                            </div>
                            <div class="form-group">
                                <label for="emergencyContactPhone">Emergency Contact Phone</label>
                                <input type="tel"
                                       id="emergencyContactPhone"
                                       name="emergencyContactPhone"
                                       class="form-control"
                                       value="${patient.emergencyContactPhone}">
                            </div>
                        </div>
                    </div>

                    <!-- Form Actions -->
                    <div class="btn-group">
                        <button type="submit" class="btn btn-primary">
                            <i class="fas fa-save"></i> Save Patient
                        </button>
                        <a href="/web/patients" class="btn btn-secondary">
                            <i class="fas fa-times"></i> Cancel
                        </a>
                    </div>
                </form>
            </div>
        </div>
    </div>

    <!-- Footer -->
    <footer style="text-align: center; padding: 2rem; background-color: #34495e; color: white; margin-top: 2rem;">
        <p>&copy; 2025 Patient Management System. All rights reserved.</p>
    </footer>

    <script>
        // Form validation
        document.querySelector('form').addEventListener('submit', function(e) {
            const firstName = document.getElementById('firstName').value.trim();
            const lastName = document.getElementById('lastName').value.trim();
            const dateOfBirth = document.getElementById('dateOfBirth').value;

            if (!firstName || !lastName || !dateOfBirth) {
                e.preventDefault();
                alert('Please fill in all required fields (marked with *)');
                return false;
            }

            // Validate date of birth is not in the future
            const today = new Date();
            const birthDate = new Date(dateOfBirth);
            if (birthDate > today) {
                e.preventDefault();
                alert('Date of birth cannot be in the future');
                return false;
            }
        });
    </script>
</body>
</html>