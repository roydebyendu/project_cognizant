package com.healthcare.patientmanagement.entity;

import jakarta.persistence.*;
import jakarta.validation.constraints.*;
import java.time.LocalDateTime;

@Entity
@Table(name = "medical_records")
public class MedicalRecord {
   
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;
   
    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "patient_id", nullable = false)
    private Patient patient;
   
    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "doctor_id", nullable = false)
    private Doctor doctor;
   
    @NotNull(message = "Visit date is required")
    @Column(name = "visit_date", nullable = false)
    private LocalDateTime visitDate;
   
    @Column(name = "diagnosis", length = 1000)
    private String diagnosis;
   
    @Column(name = "symptoms", length = 1000)
    private String symptoms;
   
    @Column(name = "treatment", length = 1000)
    private String treatment;
   
    @Column(name = "prescription", length = 2000)
    private String prescription;
   
    @Column(name = "test_results", length = 2000)
    private String testResults;
   
    @Column(name = "follow_up_date")
    private LocalDateTime followUpDate;
   
    @Column(name = "notes", length = 2000)
    private String notes;
   
    @Column(name = "vital_signs", length = 500)
    private String vitalSigns;
   
    @Column(name = "created_at")
    private LocalDateTime createdAt;
   
    @Column(name = "updated_at")
    private LocalDateTime updatedAt;
   
    @PrePersist
    protected void onCreate() {
        createdAt = LocalDateTime.now();
        updatedAt = LocalDateTime.now();
    }
   
    @PreUpdate
    protected void onUpdate() {
        updatedAt = LocalDateTime.now();
    }
   
    // Constructors
    public MedicalRecord() {}
   
    public MedicalRecord(Patient patient, Doctor doctor, LocalDateTime visitDate) {
        this.patient = patient;
        this.doctor = doctor;
        this.visitDate = visitDate;
    }
   
    // Getters and Setters
    public Long getId() { return id; }
    public void setId(Long id) { this.id = id; }
   
    public Patient getPatient() { return patient; }
    public void setPatient(Patient patient) { this.patient = patient; }
   
    public Doctor getDoctor() { return doctor; }
    public void setDoctor(Doctor doctor) { this.doctor = doctor; }
   
    public LocalDateTime getVisitDate() { return visitDate; }
    public void setVisitDate(LocalDateTime visitDate) { this.visitDate = visitDate; }
   
    public String getDiagnosis() { return diagnosis; }
    public void setDiagnosis(String diagnosis) { this.diagnosis = diagnosis; }
   
    public String getSymptoms() { return symptoms; }
    public void setSymptoms(String symptoms) { this.symptoms = symptoms; }
   
    public String getTreatment() { return treatment; }
    public void setTreatment(String treatment) { this.treatment = treatment; }
   
    public String getPrescription() { return prescription; }
    public void setPrescription(String prescription) { this.prescription = prescription; }
   
    public String getTestResults() { return testResults; }
    public void setTestResults(String testResults) { this.testResults = testResults; }
   
    public LocalDateTime getFollowUpDate() { return followUpDate; }
    public void setFollowUpDate(LocalDateTime followUpDate) { this.followUpDate = followUpDate; }
   
    public String getNotes() { return notes; }
    public void setNotes(String notes) { this.notes = notes; }
   
    public String getVitalSigns() { return vitalSigns; }
    public void setVitalSigns(String vitalSigns) { this.vitalSigns = vitalSigns; }
   
    public LocalDateTime getCreatedAt() { return createdAt; }
    public void setCreatedAt(LocalDateTime createdAt) { this.createdAt = createdAt; }
   
    public LocalDateTime getUpdatedAt() { return updatedAt; }
    public void setUpdatedAt(LocalDateTime updatedAt) { this.updatedAt = updatedAt; }
}