package com.debyendu.web.model;

import com.fasterxml.jackson.annotation.JsonFormat;

import java.math.BigDecimal;
import java.util.Date;

public class Appointment {
   
    private Long id;
    private Long patientId;
    private Long doctorId;
   
    @JsonFormat(pattern = "yyyy-MM-dd'T'HH:mm")
    private Date appointmentDateTime;
   
    private String status;
    private String reason;
    private String notes;
    private BigDecimal consultationFee;
    private Integer duration;
    private String appointmentType;
   
    @JsonFormat(pattern = "yyyy-MM-dd'T'HH:mm:ss")
    private Date createdAt;
   
    @JsonFormat(pattern = "yyyy-MM-dd'T'HH:mm:ss")
    private Date updatedAt;
   
    // Additional fields for display
    private String patientName;
    private String doctorName;
   
    // Constructors
    public Appointment() {}
   
    // Getters and Setters
    public Long getId() { return id; }
    public void setId(Long id) { this.id = id; }
   
    public Long getPatientId() { return patientId; }
    public void setPatientId(Long patientId) { this.patientId = patientId; }
   
    public Long getDoctorId() { return doctorId; }
    public void setDoctorId(Long doctorId) { this.doctorId = doctorId; }
   
    public Date getAppointmentDateTime() { return appointmentDateTime; }
    public void setAppointmentDateTime(Date appointmentDateTime) { this.appointmentDateTime = appointmentDateTime; }
   
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
   
    public Date getCreatedAt() { return createdAt; }
    public void setCreatedAt(Date createdAt) { this.createdAt = createdAt; }
   
    public Date getUpdatedAt() { return updatedAt; }
    public void setUpdatedAt(Date updatedAt) { this.updatedAt = updatedAt; }
   
    public String getPatientName() { return patientName; }
    public void setPatientName(String patientName) { this.patientName = patientName; }
   
    public String getDoctorName() { return doctorName; }
    public void setDoctorName(String doctorName) { this.doctorName = doctorName; }
}