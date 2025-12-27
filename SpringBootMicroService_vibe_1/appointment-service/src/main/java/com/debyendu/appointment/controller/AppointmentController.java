package com.debyendu.appointment.controller;

import com.debyendu.appointment.model.Appointment;
import com.debyendu.appointment.service.AppointmentService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.format.annotation.DateTimeFormat;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import jakarta.validation.Valid;
import java.time.LocalDateTime;
import java.util.List;
import java.util.Optional;

@RestController
@RequestMapping("/api/appointments")
@CrossOrigin(origins = "*")
public class AppointmentController {
   
    @Autowired
    private AppointmentService appointmentService;
   
    @GetMapping
    public ResponseEntity<List<Appointment>> getAllAppointments() {
        List<Appointment> appointments = appointmentService.getAllAppointments();
        return ResponseEntity.ok(appointments);
    }
   
    @GetMapping("/{id}")
    public ResponseEntity<Appointment> getAppointmentById(@PathVariable Long id) {
        Optional<Appointment> appointment = appointmentService.getAppointmentById(id);
        return appointment.map(ResponseEntity::ok)
                         .orElse(ResponseEntity.notFound().build());
    }
   
    @PostMapping
    public ResponseEntity<Appointment> createAppointment(@Valid @RequestBody Appointment appointment) {
        try {
            Appointment savedAppointment = appointmentService.saveAppointment(appointment);
            return ResponseEntity.status(HttpStatus.CREATED).body(savedAppointment);
        } catch (Exception e) {
            return ResponseEntity.status(HttpStatus.BAD_REQUEST).build();
        }
    }
   
    @PutMapping("/{id}")
    public ResponseEntity<Appointment> updateAppointment(@PathVariable Long id,
                                                       @Valid @RequestBody Appointment appointmentDetails) {
        Appointment updatedAppointment = appointmentService.updateAppointment(id, appointmentDetails);
        if (updatedAppointment != null) {
            return ResponseEntity.ok(updatedAppointment);
        }
        return ResponseEntity.notFound().build();
    }
   
    @DeleteMapping("/{id}")
    public ResponseEntity<Void> deleteAppointment(@PathVariable Long id) {
        boolean deleted = appointmentService.deleteAppointment(id);
        if (deleted) {
            return ResponseEntity.noContent().build();
        }
        return ResponseEntity.notFound().build();
    }
   
    @GetMapping("/patient/{patientId}")
    public ResponseEntity<List<Appointment>> getAppointmentsByPatientId(@PathVariable Long patientId) {
        List<Appointment> appointments = appointmentService.getAppointmentsByPatientId(patientId);
        return ResponseEntity.ok(appointments);
    }
   
    @GetMapping("/doctor/{doctorId}")
    public ResponseEntity<List<Appointment>> getAppointmentsByDoctorId(@PathVariable Long doctorId) {
        List<Appointment> appointments = appointmentService.getAppointmentsByDoctorId(doctorId);
        return ResponseEntity.ok(appointments);
    }
   
    @GetMapping("/status/{status}")
    public ResponseEntity<List<Appointment>> getAppointmentsByStatus(@PathVariable String status) {
        List<Appointment> appointments = appointmentService.getAppointmentsByStatus(status);
        return ResponseEntity.ok(appointments);
    }
   
    @GetMapping("/date-range")
    public ResponseEntity<List<Appointment>> getAppointmentsBetweenDates(
            @RequestParam @DateTimeFormat(iso = DateTimeFormat.ISO.DATE_TIME) LocalDateTime startDate,
            @RequestParam @DateTimeFormat(iso = DateTimeFormat.ISO.DATE_TIME) LocalDateTime endDate) {
        List<Appointment> appointments = appointmentService.getAppointmentsBetweenDates(startDate, endDate);
        return ResponseEntity.ok(appointments);
    }
   
    @GetMapping("/doctor/{doctorId}/date-range")
    public ResponseEntity<List<Appointment>> getDoctorAppointmentsBetweenDates(
            @PathVariable Long doctorId,
            @RequestParam @DateTimeFormat(iso = DateTimeFormat.ISO.DATE_TIME) LocalDateTime startDate,
            @RequestParam @DateTimeFormat(iso = DateTimeFormat.ISO.DATE_TIME) LocalDateTime endDate) {
        List<Appointment> appointments = appointmentService.getDoctorAppointmentsBetweenDates(doctorId, startDate, endDate);
        return ResponseEntity.ok(appointments);
    }
   
    @GetMapping("/patient/{patientId}/status/{status}")
    public ResponseEntity<List<Appointment>> getPatientAppointmentsByStatus(
            @PathVariable Long patientId, @PathVariable String status) {
        List<Appointment> appointments = appointmentService.getPatientAppointmentsByStatus(patientId, status);
        return ResponseEntity.ok(appointments);
    }
   
    @GetMapping("/doctor/{doctorId}/status/{status}")
    public ResponseEntity<List<Appointment>> getDoctorAppointmentsByStatus(
            @PathVariable Long doctorId, @PathVariable String status) {
        List<Appointment> appointments = appointmentService.getDoctorAppointmentsByStatus(doctorId, status);
        return ResponseEntity.ok(appointments);
    }
   
    @PatchMapping("/{id}/status/{status}")
    public ResponseEntity<Appointment> updateAppointmentStatus(@PathVariable Long id,
                                                             @PathVariable String status) {
        Appointment updatedAppointment = appointmentService.updateAppointmentStatus(id, status);
        if (updatedAppointment != null) {
            return ResponseEntity.ok(updatedAppointment);
        }
        return ResponseEntity.notFound().build();
    }
}