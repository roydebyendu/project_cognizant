package com.debyendu.appointment.model;

import jakarta.persistence.*;
import jakarta.validation.constraints.*;
import java.time.LocalDate;
import java.time.LocalTime;

@Entity
@Table(name = "appointments")
public class Appointment {
   
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;
   
    @NotNull(message = "Patient ID is required")
    @Column(name = "patient_id", nullable = false)
    private Long patientId;
   
    @NotNull(message = "Doctor ID is required")
    @Column(name = "doctor_id", nullable = false)
    private Long doctorId;
   
    @NotNull(message = "Appointment date is required")
    @Future(message = "Appointment date must be in the future")
    @Column(name = "appointment_date", nullable = false)
    private LocalDate appointmentDate;
   
    @NotNull(message = "Appointment time is required")
    @Column(name = "appointment_time", nullable = false)
    private LocalTime appointmentTime;
   
    @Enumerated(EnumType.STRING)
    @Column(name = "status", nullable = false)
    private AppointmentStatus status = AppointmentStatus.SCHEDULED;
   
    @Column(name = "notes", length = 1000)
    private String notes;
   
    // Constructors
    public Appointment() {}
   
    public Appointment(Long patientId, Long doctorId, LocalDate appointmentDate,
                      LocalTime appointmentTime, String notes) {
        this.patientId = patientId;
        this.doctorId = doctorId;
        this.appointmentDate = appointmentDate;
        this.appointmentTime = appointmentTime;
        this.notes = notes;
        this.status = AppointmentStatus.SCHEDULED;
    }
   
    // Getters and Setters
    public Long getId() {
        return id;
    }
   
    public void setId(Long id) {
        this.id = id;
    }
   
    public Long getPatientId() {
        return patientId;
    }
   
    public void setPatientId(Long patientId) {
        this.patientId = patientId;
    }
   
    public Long getDoctorId() {
        return doctorId;
    }
   
    public void setDoctorId(Long doctorId) {
        this.doctorId = doctorId;
    }
   
    public LocalDate getAppointmentDate() {
        return appointmentDate;
    }
   
    public void setAppointmentDate(LocalDate appointmentDate) {
        this.appointmentDate = appointmentDate;
    }
   
    public LocalTime getAppointmentTime() {
        return appointmentTime;
    }
   
    public void setAppointmentTime(LocalTime appointmentTime) {
        this.appointmentTime = appointmentTime;
    }
   
    public AppointmentStatus getStatus() {
        return status;
    }
   
    public void setStatus(AppointmentStatus status) {
        this.status = status;
    }
   
    public String getNotes() {
        return notes;
    }
   
    public void setNotes(String notes) {
        this.notes = notes;
    }
}