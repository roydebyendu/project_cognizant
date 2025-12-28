<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>${medicalRecord.id != null ? 'Edit' : 'Add'} Medical Record - Patient Management System</title>
    <link rel="stylesheet" href="/css/style.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
    <style>
        .medical-form {
            max-width: 1000px;
            margin: 0 auto;
        }
       
        .form-section {
            background: white;
            border-radius: 8px;
            padding: 2rem;
            margin-bottom: 2rem;
            box-shadow: 0 2px 10px rgba(0,0,0,0.1);
        }
       
        .section-header {
            border-bottom: 2px solid #e9ecef;
            padding-bottom: 1rem;
            margin-bottom: 2rem;
        }
       
        .section-title {
            font-size: 1.3rem;
            color: #2c3e50;
            margin: 0;
        }
       
        .vital-signs-grid {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(200px, 1fr));
            gap: 1rem;
        }
       
        .prescription-item {
            background: #f8f9fa;
            border: 1px solid #e9ecef;
            border-radius: 5px;
            padding: 1rem;
            margin-bottom: 1rem;
        }
       
        .char-counter {
            font-size: 0.8rem;
            color: #666;
            text-align: right;
            margin-top: 0.25rem;
        }
       
        .required-field {
            color: #e74c3c;
        }
    </style>
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
        <div class="content">
            <div style="display: flex; justify-content: space-between; align-items: center; margin-bottom: 2rem;">
                <h2>
                    <i class="fas fa-file-medical"></i>
                    ${medicalRecord.id != null ? 'Edit' : 'Add New'} Medical Record
                </h2>
                <a href="/web/medical-records" class="btn btn-secondary">
                    <i class="fas fa-arrow-left"></i> Back to Medical Records
                </a>
            </div>

            <div class="medical-form">
                <form action="/web/medical-records/save" method="post" id="medicalRecordForm">
                    <c:if test="${medicalRecord.id != null}">
                        <input type="hidden" name="id" value="${medicalRecord.id}"/>
                    </c:if>

                    <!-- Basic Information -->
                    <div class="form-section">
                        <div class="section-header">
                            <h3 class="section-title"><i class="fas fa-info-circle"></i> Basic Information</h3>
                        </div>
                       
                        <div class="form-row">
                            <div class="form-group">
                                <label for="patientId">Patient <span class="required-field">*</span></label>
                                <select id="patientId" name="patient.id" class="form-control" required>
                                    <option value="">Select Patient</option>
                                    <c:forEach var="patient" items="${patients}">
                                        <option value="${patient.id}"
                                                ${medicalRecord.patient.id == patient.id ? 'selected' : ''}
                                                data-dob="${patient.dateOfBirth}"
                                                data-gender="${patient.gender}">
                                            ${patient.firstName} ${patient.lastName} (ID: ${patient.id})
                                        </option>
                                    </c:forEach>
                                </select>
                            </div>
                            <div class="form-group">
                                <label for="doctorId">Doctor <span class="required-field">*</span></label>
                                <select id="doctorId" name="doctor.id" class="form-control" required>
                                    <option value="">Select Doctor</option>
                                    <c:forEach var="doctor" items="${doctors}">
                                        <option value="${doctor.id}"
                                                ${medicalRecord.doctor.id == doctor.id ? 'selected' : ''}>
                                            Dr. ${doctor.firstName} ${doctor.lastName} - ${doctor.specialization}
                                        </option>
                                    </c:forEach>
                                </select>
                            </div>
                        </div>

                        <div class="form-row">
                            <div class="form-group">
                                <label for="visitDate">Visit Date & Time <span class="required-field">*</span></label>
                                <input type="datetime-local"
                                       id="visitDate"
                                       name="visitDate"
                                       class="form-control"
                                       value="${medicalRecord.visitDate}"
                                       required>
                            </div>
                            <div class="form-group">
                                <label for="followUpDate">Follow-up Date</label>
                                <input type="datetime-local"
                                       id="followUpDate"
                                       name="followUpDate"
                                       class="form-control"
                                       value="${medicalRecord.followUpDate}">
                            </div>
                        </div>
                    </div>

                    <!-- Vital Signs -->
                    <div class="form-section">
                        <div class="section-header">
                            <h3 class="section-title"><i class="fas fa-heartbeat"></i> Vital Signs</h3>
                        </div>
                       
                        <div class="vital-signs-grid">
                            <div class="form-group">
                                <label for="bloodPressure">Blood Pressure (mmHg)</label>
                                <input type="text"
                                       id="bloodPressure"
                                       name="vitalSigns.bloodPressure"
                                       class="form-control"
                                       placeholder="120/80">
                            </div>
                            <div class="form-group">
                                <label for="heartRate">Heart Rate (bpm)</label>
                                <input type="number"
                                       id="heartRate"
                                       name="vitalSigns.heartRate"
                                       class="form-control"
                                       placeholder="72">
                            </div>
                            <div class="form-group">
                                <label for="temperature">Temperature (°C)</label>
                                <input type="number"
                                       step="0.1"
                                       id="temperature"
                                       name="vitalSigns.temperature"
                                       class="form-control"
                                       placeholder="36.5">
                            </div>
                            <div class="form-group">
                                <label for="weight">Weight (kg)</label>
                                <input type="number"
                                       step="0.1"
                                       id="weight"
                                       name="vitalSigns.weight"
                                       class="form-control"
                                       placeholder="70.0">
                            </div>
                            <div class="form-group">
                                <label for="height">Height (cm)</label>
                                <input type="number"
                                       id="height"
                                       name="vitalSigns.height"
                                       class="form-control"
                                       placeholder="175">
                            </div>
                            <div class="form-group">
                                <label for="oxygenSaturation">Oxygen Saturation (%)</label>
                                <input type="number"
                                       id="oxygenSaturation"
                                       name="vitalSigns.oxygenSaturation"
                                       class="form-control"
                                       placeholder="98">
                            </div>
                        </div>
                       
                        <div class="form-group">
                            <label for="vitalSigns">Additional Vital Signs Notes</label>
                            <textarea id="vitalSigns"
                                      name="vitalSigns"
                                      class="form-control"
                                      rows="3"
                                      maxlength="500"
                                      oninput="updateCharCounter(this, 'vitalSignsCounter')">${medicalRecord.vitalSigns}</textarea>
                            <div id="vitalSignsCounter" class="char-counter">0/500 characters</div>
                        </div>
                    </div>

                    <!-- Clinical Information -->
                    <div class="form-section">
                        <div class="section-header">
                            <h3 class="section-title"><i class="fas fa-stethoscope"></i> Clinical Information</h3>
                        </div>
                       
                        <div class="form-group">
                            <label for="symptoms">Chief Complaint & Symptoms</label>
                            <textarea id="symptoms"
                                      name="symptoms"
                                      class="form-control"
                                      rows="4"
                                      maxlength="1000"
                                      oninput="updateCharCounter(this, 'symptomsCounter')"
                                      placeholder="Describe the patient's chief complaint and presenting symptoms...">${medicalRecord.symptoms}</textarea>
                            <div id="symptomsCounter" class="char-counter">0/1000 characters</div>
                        </div>
                       
                        <div class="form-group">
                            <label for="diagnosis">Diagnosis</label>
                            <textarea id="diagnosis"
                                      name="diagnosis"
                                      class="form-control"
                                      rows="4"
                                      maxlength="1000"
                                      oninput="updateCharCounter(this, 'diagnosisCounter')"
                                      placeholder="Primary and secondary diagnoses, ICD codes if applicable...">${medicalRecord.diagnosis}</textarea>
                            <div id="diagnosisCounter" class="char-counter">0/1000 characters</div>
                        </div>
                       
                        <div class="form-group">
                            <label for="treatment">Treatment Plan</label>
                            <textarea id="treatment"
                                      name="treatment"
                                      class="form-control"
                                      rows="4"
                                      maxlength="1000"
                                      oninput="updateCharCounter(this, 'treatmentCounter')"
                                      placeholder="Describe the treatment plan, procedures performed, recommendations...">${medicalRecord.treatment}</textarea>
                            <div id="treatmentCounter" class="char-counter">0/1000 characters</div>
                        </div>
                    </div>

                    <!-- Prescription -->
                    <div class="form-section">
                        <div class="section-header">
                            <h3 class="section-title"><i class="fas fa-pills"></i> Prescription & Medications</h3>
                        </div>
                       
                        <div class="form-group">
                            <label for="prescription">Prescription Details</label>
                            <textarea id="prescription"
                                      name="prescription"
                                      class="form-control"
                                      rows="6"
                                      maxlength="2000"
                                      oninput="updateCharCounter(this, 'prescriptionCounter')"
                                      placeholder="List medications, dosages, frequency, duration, and special instructions...">${medicalRecord.prescription}</textarea>
                            <div id="prescriptionCounter" class="char-counter">0/2000 characters</div>
                        </div>
                    </div>

                    <!-- Test Results -->
                    <div class="form-section">
                        <div class="section-header">
                            <h3 class="section-title"><i class="fas fa-flask"></i> Laboratory & Test Results</h3>
                        </div>
                       
                        <div class="form-group">
                            <label for="testResults">Test Results & Laboratory Values</label>
                            <textarea id="testResults"
                                      name="testResults"
                                      class="form-control"
                                      rows="6"
                                      maxlength="2000"
                                      oninput="updateCharCounter(this, 'testResultsCounter')"
                                      placeholder="Enter laboratory results, imaging findings, test interpretations...">${medicalRecord.testResults}</textarea>
                            <div id="testResultsCounter" class="char-counter">0/2000 characters</div>
                        </div>
                    </div>

                    <!-- Additional Notes -->
                    <div class="form-section">
                        <div class="section-header">
                            <h3 class="section-title"><i class="fas fa-sticky-note"></i> Additional Notes</h3>
                        </div>
                       
                        <div class="form-group">
                            <label for="notes">Clinical Notes & Observations</label>
                            <textarea id="notes"
                                      name="notes"
                                      class="form-control"
                                      rows="5"
                                      maxlength="2000"
                                      oninput="updateCharCounter(this, 'notesCounter')"
                                      placeholder="Any additional observations, patient education provided, special considerations...">${medicalRecord.notes}</textarea>
                            <div id="notesCounter" class="char-counter">0/2000 characters</div>
                        </div>
                    </div>

                    <!-- Form Actions -->
                    <div class="form-section">
                        <div class="btn-group">
                            <button type="submit" class="btn btn-primary" id="saveBtn">
                                <i class="fas fa-save"></i> Save Medical Record
                            </button>
                            <button type="button" class="btn btn-success" onclick="saveAndPrint()">
                                <i class="fas fa-print"></i> Save & Print
                            </button>
                            <a href="/web/medical-records" class="btn btn-secondary">
                                <i class="fas fa-times"></i> Cancel
                            </a>
                        </div>
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
        // Character counter function
        function updateCharCounter(textarea, counterId) {
            const counter = document.getElementById(counterId);
            const current = textarea.value.length;
            const max = textarea.getAttribute('maxlength');
            counter.textContent = `${current}/${max} characters`;
           
            if (current > max * 0.9) {
                counter.style.color = '#e74c3c';
            } else if (current > max * 0.7) {
                counter.style.color = '#f39c12';
            } else {
                counter.style.color = '#666';
            }
        }

        // Initialize character counters
        document.addEventListener('DOMContentLoaded', function() {
            const textareas = document.querySelectorAll('textarea[maxlength]');
            textareas.forEach(textarea => {
                const counterId = textarea.getAttribute('oninput').match(/'(\w+)'/)[1];
                updateCharCounter(textarea, counterId);
            });
        });

        // Form validation
        document.getElementById('medicalRecordForm').addEventListener('submit', function(e) {
            const patientId = document.getElementById('patientId').value;
            const doctorId = document.getElementById('doctorId').value;
            const visitDate = document.getElementById('visitDate').value;

            if (!patientId || !doctorId || !visitDate) {
                e.preventDefault();
                alert('Please fill in all required fields (Patient, Doctor, and Visit Date)');
                return false;
            }

            // Validate visit date is not in the future
            const visitDateTime = new Date(visitDate);
            const now = new Date();
            if (visitDateTime > now) {
                if (!confirm('The visit date is in the future. Are you sure you want to continue?')) {
                    e.preventDefault();
                    return false;
                }
            }

            // Show loading state
            const saveBtn = document.getElementById('saveBtn');
            saveBtn.innerHTML = '<i class="fas fa-spinner fa-spin"></i> Saving...';
            saveBtn.disabled = true;
        });

        // Save and print function
        function saveAndPrint() {
            const form = document.getElementById('medicalRecordForm');
            const originalAction = form.action;
            form.action = originalAction + '?print=true';
            form.submit();
        }

        // Auto-save functionality (optional)
        let autoSaveTimer;
        function autoSave() {
            // Implementation for auto-saving draft
            console.log('Auto-saving draft...');
        }

        document.querySelectorAll('input, textarea, select').forEach(element => {
            element.addEventListener('input', function() {
                clearTimeout(autoSaveTimer);
                autoSaveTimer = setTimeout(autoSave, 30000); // Auto-save after 30 seconds of inactivity
            });
        });

        // BMI Calculator
        function calculateBMI() {
            const weight = parseFloat(document.getElementById('weight').value);
            const height = parseFloat(document.getElementById('height').value);
           
            if (weight && height) {
                const heightM = height / 100; // Convert cm to meters
                const bmi = weight / (heightM * heightM);
               
                let category = '';
                if (bmi < 18.5) category = 'Underweight';
                else if (bmi < 25) category = 'Normal';
                else if (bmi < 30) category = 'Overweight';
                else category = 'Obese';
               
                const bmiInfo = `BMI: ${bmi.toFixed(1)} (${category})`;
               
                // Add BMI to vital signs if not already present
                const vitalSigns = document.getElementById('vitalSigns');
                if (!vitalSigns.value.includes('BMI:')) {
                    vitalSigns.value += (vitalSigns.value ? '\n' : '') + bmiInfo;
                    updateCharCounter(vitalSigns, 'vitalSignsCounter');
                }
            }
        }

        document.getElementById('weight').addEventListener('blur', calculateBMI);
        document.getElementById('height').addEventListener('blur', calculateBMI);
    </script>
</body>
</html>