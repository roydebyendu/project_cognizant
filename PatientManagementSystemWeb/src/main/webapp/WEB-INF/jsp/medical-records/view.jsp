<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Medical Record Details - Patient Management System</title>
    <link rel="stylesheet" href="/css/style.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
    <style>
        .medical-record-view {
            max-width: 900px;
            margin: 0 auto;
        }
       
        .record-header {
            background: linear-gradient(135deg, #3498db, #2980b9);
            color: white;
            padding: 2rem;
            border-radius: 10px;
            margin-bottom: 2rem;
            box-shadow: 0 4px 15px rgba(52, 152, 219, 0.3);
        }
       
        .record-id {
            font-size: 1.5rem;
            font-weight: bold;
            margin-bottom: 0.5rem;
        }
       
        .record-date {
            font-size: 1.1rem;
            opacity: 0.9;
        }
       
        .info-grid {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(300px, 1fr));
            gap: 2rem;
            margin-bottom: 2rem;
        }
       
        .info-card {
            background: white;
            border-radius: 8px;
            padding: 1.5rem;
            box-shadow: 0 2px 10px rgba(0,0,0,0.1);
            border-left: 4px solid #3498db;
        }
       
        .info-card.patient {
            border-left-color: #27ae60;
        }
       
        .info-card.doctor {
            border-left-color: #e74c3c;
        }
       
        .info-card.vital {
            border-left-color: #f39c12;
        }
       
        .card-title {
            font-size: 1.2rem;
            font-weight: bold;
            color: #2c3e50;
            margin-bottom: 1rem;
            display: flex;
            align-items: center;
            gap: 0.5rem;
        }
       
        .info-row {
            display: flex;
            justify-content: space-between;
            padding: 0.5rem 0;
            border-bottom: 1px solid #e9ecef;
        }
       
        .info-label {
            font-weight: 600;
            color: #666;
        }
       
        .info-value {
            color: #2c3e50;
            text-align: right;
        }
       
        .clinical-section {
            background: white;
            border-radius: 8px;
            padding: 2rem;
            margin-bottom: 2rem;
            box-shadow: 0 2px 10px rgba(0,0,0,0.1);
        }
       
        .section-header {
            border-bottom: 2px solid #e9ecef;
            padding-bottom: 1rem;
            margin-bottom: 1.5rem;
        }
       
        .section-title {
            font-size: 1.3rem;
            color: #2c3e50;
            margin: 0;
            display: flex;
            align-items: center;
            gap: 0.5rem;
        }
       
        .clinical-content {
            line-height: 1.6;
            color: #333;
            white-space: pre-wrap;
        }
       
        .empty-content {
            color: #999;
            font-style: italic;
            text-align: center;
            padding: 2rem;
        }
       
        .vital-signs-grid {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(150px, 1fr));
            gap: 1rem;
        }
       
        .vital-item {
            background: #f8f9fa;
            padding: 1rem;
            border-radius: 5px;
            text-align: center;
            border: 1px solid #e9ecef;
        }
       
        .vital-value {
            font-size: 1.5rem;
            font-weight: bold;
            color: #2c3e50;
        }
       
        .vital-label {
            font-size: 0.9rem;
            color: #666;
            margin-top: 0.25rem;
        }
       
        .follow-up-alert {
            background: linear-gradient(135deg, #f39c12, #e67e22);
            color: white;
            padding: 1rem;
            border-radius: 5px;
            margin-bottom: 2rem;
            text-align: center;
        }
       
        .print-hide {
            display: block;
        }
       
        @media print {
            .navbar, .print-hide, footer {
                display: none !important;
            }
           
            .header {
                background: #2c3e50 !important;
                color: white !important;
            }
           
            .record-header {
                background: #3498db !important;
                color: white !important;
            }
           
            .container {
                max-width: none !important;
                padding: 1rem !important;
            }
           
            .clinical-section, .info-card {
                box-shadow: none !important;
                border: 1px solid #ddd !important;
            }
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
    <nav class="navbar print-hide">
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
        <div class="content medical-record-view">
            <!-- Action Buttons -->
            <div class="print-hide" style="display: flex; justify-content: space-between; align-items: center; margin-bottom: 2rem;">
                <h2><i class="fas fa-file-medical"></i> Medical Record Details</h2>
                <div class="btn-group">
                    <button onclick="window.print()" class="btn btn-secondary">
                        <i class="fas fa-print"></i> Print Record
                    </button>
                    <a href="/web/medical-records/edit/${medicalRecord.id}" class="btn btn-primary">
                        <i class="fas fa-edit"></i> Edit Record
                    </a>
                    <a href="/web/medical-records" class="btn btn-secondary">
                        <i class="fas fa-arrow-left"></i> Back to Records
                    </a>
                </div>
            </div>

            <!-- Record Header -->
            <div class="record-header">
                <div class="record-id">Medical Record #MR-${medicalRecord.id}</div>
                <div class="record-date">
                    <i class="fas fa-calendar"></i>
                    Visit Date: <fmt:formatDate value="${medicalRecord.visitDate}" pattern="EEEE, MMMM dd, yyyy 'at' HH:mm"/>
                </div>
            </div>

            <!-- Follow-up Alert -->
            <c:if test="${not empty medicalRecord.followUpDate}">
                <div class="follow-up-alert">
                    <i class="fas fa-clock"></i>
                    <strong>Follow-up Required:</strong>
                    <fmt:formatDate value="${medicalRecord.followUpDate}" pattern="EEEE, MMMM dd, yyyy 'at' HH:mm"/>
                </div>
            </c:if>

            <!-- Patient and Doctor Information -->
            <div class="info-grid">
                <!-- Patient Information -->
                <div class="info-card patient">
                    <div class="card-title">
                        <i class="fas fa-user"></i> Patient Information
                    </div>
                    <div class="info-row">
                        <span class="info-label">Name:</span>
                        <span class="info-value">${medicalRecord.patient.firstName} ${medicalRecord.patient.lastName}</span>
                    </div>
                    <div class="info-row">
                        <span class="info-label">Patient ID:</span>
                        <span class="info-value">${medicalRecord.patient.id}</span>
                    </div>
                    <div class="info-row">
                        <span class="info-label">Date of Birth:</span>
                        <span class="info-value">
                            <fmt:formatDate value="${medicalRecord.patient.dateOfBirth}" pattern="dd/MM/yyyy"/>
                        </span>
                    </div>
                    <div class="info-row">
                        <span class="info-label">Gender:</span>
                        <span class="info-value">${medicalRecord.patient.gender}</span>
                    </div>
                    <div class="info-row">
                        <span class="info-label">Contact:</span>
                        <span class="info-value">${medicalRecord.patient.phoneNumber}</span>
                    </div>
                </div>

                <!-- Doctor Information -->
                <div class="info-card doctor">
                    <div class="card-title">
                        <i class="fas fa-user-md"></i> Doctor Information
                    </div>
                    <div class="info-row">
                        <span class="info-label">Name:</span>
                        <span class="info-value">Dr. ${medicalRecord.doctor.firstName} ${medicalRecord.doctor.lastName}</span>
                    </div>
                    <div class="info-row">
                        <span class="info-label">Specialization:</span>
                        <span class="info-value">${medicalRecord.doctor.specialization}</span>
                    </div>
                    <div class="info-row">
                        <span class="info-label">Department:</span>
                        <span class="info-value">${medicalRecord.doctor.department}</span>
                    </div>
                    <div class="info-row">
                        <span class="info-label">License #:</span>
                        <span class="info-value">${medicalRecord.doctor.licenseNumber}</span>
                    </div>
                    <div class="info-row">
                        <span class="info-label">Contact:</span>
                        <span class="info-value">${medicalRecord.doctor.phoneNumber}</span>
                    </div>
                </div>
            </div>

            <!-- Vital Signs -->
            <c:if test="${not empty medicalRecord.vitalSigns}">
                <div class="clinical-section">
                    <div class="section-header">
                        <h3 class="section-title">
                            <i class="fas fa-heartbeat"></i> Vital Signs
                        </h3>
                    </div>
                    <div class="clinical-content">${medicalRecord.vitalSigns}</div>
                </div>
            </c:if>

            <!-- Chief Complaint & Symptoms -->
            <div class="clinical-section">
                <div class="section-header">
                    <h3 class="section-title">
                        <i class="fas fa-notes-medical"></i> Chief Complaint & Symptoms
                    </h3>
                </div>
                <c:choose>
                    <c:when test="${not empty medicalRecord.symptoms}">
                        <div class="clinical-content">${medicalRecord.symptoms}</div>
                    </c:when>
                    <c:otherwise>
                        <div class="empty-content">No symptoms recorded</div>
                    </c:otherwise>
                </c:choose>
            </div>

            <!-- Diagnosis -->
            <div class="clinical-section">
                <div class="section-header">
                    <h3 class="section-title">
                        <i class="fas fa-diagnosis"></i> Diagnosis
                    </h3>
                </div>
                <c:choose>
                    <c:when test="${not empty medicalRecord.diagnosis}">
                        <div class="clinical-content">${medicalRecord.diagnosis}</div>
                    </c:when>
                    <c:otherwise>
                        <div class="empty-content">No diagnosis recorded</div>
                    </c:otherwise>
                </c:choose>
            </div>

            <!-- Treatment Plan -->
            <div class="clinical-section">
                <div class="section-header">
                    <h3 class="section-title">
                        <i class="fas fa-procedures"></i> Treatment Plan
                    </h3>
                </div>
                <c:choose>
                    <c:when test="${not empty medicalRecord.treatment}">
                        <div class="clinical-content">${medicalRecord.treatment}</div>
                    </c:when>
                    <c:otherwise>
                        <div class="empty-content">No treatment plan recorded</div>
                    </c:otherwise>
                </c:choose>
            </div>

            <!-- Prescription -->
            <c:if test="${not empty medicalRecord.prescription}">
                <div class="clinical-section">
                    <div class="section-header">
                        <h3 class="section-title">
                            <i class="fas fa-pills"></i> Prescription & Medications
                        </h3>
                    </div>
                    <div class="clinical-content">${medicalRecord.prescription}</div>
                </div>
            </c:if>

            <!-- Test Results -->
            <c:if test="${not empty medicalRecord.testResults}">
                <div class="clinical-section">
                    <div class="section-header">
                        <h3 class="section-title">
                            <i class="fas fa-flask"></i> Laboratory & Test Results
                        </h3>
                    </div>
                    <div class="clinical-content">${medicalRecord.testResults}</div>
                </div>
            </c:if>

            <!-- Additional Notes -->
            <c:if test="${not empty medicalRecord.notes}">
                <div class="clinical-section">
                    <div class="section-header">
                        <h3 class="section-title">
                            <i class="fas fa-sticky-note"></i> Additional Clinical Notes
                        </h3>
                    </div>
                    <div class="clinical-content">${medicalRecord.notes}</div>
                </div>
            </c:if>

            <!-- Record Metadata -->
            <div class="clinical-section">
                <div class="section-header">
                    <h3 class="section-title">
                        <i class="fas fa-info-circle"></i> Record Information
                    </h3>
                </div>
                <div class="info-grid">
                    <div>
                        <div class="info-row">
                            <span class="info-label">Record Created:</span>
                            <span class="info-value">
                                <fmt:formatDate value="${medicalRecord.createdAt}" pattern="dd/MM/yyyy HH:mm:ss"/>
                            </span>
                        </div>
                        <div class="info-row">
                            <span class="info-label">Last Updated:</span>
                            <span class="info-value">
                                <fmt:formatDate value="${medicalRecord.updatedAt}" pattern="dd/MM/yyyy HH:mm:ss"/>
                            </span>
                        </div>
                    </div>
                    <div>
                        <c:if test="${not empty medicalRecord.followUpDate}">
                            <div class="info-row">
                                <span class="info-label">Follow-up Date:</span>
                                <span class="info-value">
                                    <fmt:formatDate value="${medicalRecord.followUpDate}" pattern="dd/MM/yyyy HH:mm"/>
                                </span>
                            </div>
                        </c:if>
                    </div>
                </div>
            </div>

            <!-- Quick Actions -->
            <div class="clinical-section print-hide">
                <div class="section-header">
                    <h3 class="section-title">
                        <i class="fas fa-bolt"></i> Quick Actions
                    </h3>
                </div>
                <div class="btn-group">
                    <a href="/web/appointments/new?patientId=${medicalRecord.patient.id}&doctorId=${medicalRecord.doctor.id}"
                       class="btn btn-success">
                        <i class="fas fa-calendar-plus"></i> Schedule Follow-up
                    </a>
                    <a href="/web/medical-records/new?patientId=${medicalRecord.patient.id}"
                       class="btn btn-info">
                        <i class="fas fa-file-medical"></i> Add New Record
                    </a>
                    <a href="/web/patients/${medicalRecord.patient.id}"
                       class="btn btn-secondary">
                        <i class="fas fa-user"></i> View Patient Profile
                    </a>
                </div>
            </div>
        </div>
    </div>

    <!-- Footer -->
    <footer class="print-hide" style="text-align: center; padding: 2rem; background-color: #34495e; color: white; margin-top: 2rem;">
        <p>&copy; 2025 Patient Management System. All rights reserved.</p>
        <p style="font-size: 0.9rem; opacity: 0.8;">
            This medical record is confidential and protected by patient privacy laws.
        </p>
    </footer>

    <script>
        // Print formatting
        window.addEventListener('beforeprint', function() {
            document.title = 'Medical Record MR-${medicalRecord.id} - ${medicalRecord.patient.firstName} ${medicalRecord.patient.lastName}';
        });

        // Auto-hide empty sections for better presentation
        document.addEventListener('DOMContentLoaded', function() {
            const emptySections = document.querySelectorAll('.empty-content');
            emptySections.forEach(section => {
                const clinicalSection = section.closest('.clinical-section');
                if (clinicalSection && window.innerWidth > 768) {
                    clinicalSection.style.opacity = '0.7';
                }
            });
        });

        // Add copy functionality for record ID
        function copyRecordId() {
            const recordId = 'MR-${medicalRecord.id}';
            navigator.clipboard.writeText(recordId).then(function() {
                alert('Record ID copied to clipboard: ' + recordId);
            });
        }

        // Add copy button to record header
        document.addEventListener('DOMContentLoaded', function() {
            const recordHeader = document.querySelector('.record-header');
            const copyButton = document.createElement('button');
            copyButton.innerHTML = '<i class="fas fa-copy"></i>';
            copyButton.className = 'btn btn-sm';
            copyButton.style.cssText = 'position: absolute; top: 1rem; right: 1rem; background: rgba(255,255,255,0.2); border: 1px solid rgba(255,255,255,0.3); color: white;';
            copyButton.onclick = copyRecordId;
            copyButton.title = 'Copy Record ID';
            recordHeader.style.position = 'relative';
            recordHeader.appendChild(copyButton);
        });
    </script>
</body>
</html>
