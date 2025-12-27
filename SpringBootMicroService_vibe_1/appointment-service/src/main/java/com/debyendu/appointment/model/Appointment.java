package com.debyendu.appointment.model;

import org.springframework.data.annotation.Id;
import org.springframework.data.relational.core.mapping.Table;

import jakarta.validation.constraints.NotNull;
import java.math.BigDecimal;
import java.time.LocalDateTime;

@Table("appointments")
public class Appointment {
   
    @Id
    private Long id;
   
    @NotNull(message = "Patient ID is required")
    private Long patientId;
   
    @NotNull(message = "Doctor ID is required")
    private Long doctorId;
   
    @NotNull(message = "Appointment date and time is required")
    private LocalDateTime appointmentDateTime;
   
    private String status; // SCHEDULED, CONFIRMED, COMPLETED, CANCELLED
   
    private String reason;
   
    private String notes;
   
    private BigDecimal consultationFee;
   
    private Integer duration; // in minutes
   
    private String appointmentType; // IN_PERSON, ONLINE
   
    private LocalDateTime createdAt;
   
    private LocalDateTime updatedAt;
   
    // Constructors
    public Appointment() {}
   
    public Appointment(Long patientId, Long doctorId, LocalDateTime appointmentDateTime,
                      String status, String reason, String notes, BigDecimal consultationFee,
                      Integer duration, String appointmentType) {
        this.patientId = patientId;
        this.doctorId = doctorId;
        this.appointmentDateTime = appointmentDateTime;
        this.status = status;
        this.reason = reason;
        this.notes = notes;
        this.consultationFee = consultationFee;
        this.duration = duration;
        this.appointmentType = appointmentType;
        this.createdAt = LocalDateTime.now();
        this.updatedAt = LocalDateTime.now();
    }
   
    // Getters and Setters
    public Long getId() { return id; }
    public void setId(Long id) { this.id = id; }
   
    public Long getPatientId() { return patientId; }
    public void setPatientId(Long patientId) { this.patientId = patientId; }
   
    public Long getDoctorId() { return doctorId; }
    public void setDoctorId(Long doctorId) { this.doctorId = doctorId; }
   
    public LocalDateTime getAppointmentDateTime() { return appointmentDateTime; }
    public void setAppointmentDateTime(LocalDateTime appointmentDateTime) { this.appointmentDateTime = appointmentDateTime; }
   
    public String getStatus() { return status; }
    public void setStatus(String status) { this.status = status; }
   
    public String getReason() { return reason; }
    public void setReason(String reason) { this.reason = reason; }
   
    public String getNotes() { return notes; }
    public void setNotes(String notes) { this.notes = notes; }
   
    public BigDecimal getConsultationFee() { return consultationFee; }
    public void setConsultationFee(BigDecimal consultationFee) { this.consultationFee = consultationFee; }
   
    public Integer getDuration() { return duration; }
    public void setDuration(Integer duration) { this.duration = duration; }
   
    public String getAppointmentType() { return appointmentType; }
    public void setAppointmentType(String appointmentType) { this.appointmentType = appointmentType; }
   
    public LocalDateTime getCreatedAt() { return createdAt; }
    public void setCreatedAt(LocalDateTime createdAt) { this.createdAt = createdAt; }
   
    public LocalDateTime getUpdatedAt() { return updatedAt; }
    public void setUpdatedAt(LocalDateTime updatedAt) { this.updatedAt = updatedAt; }
}
