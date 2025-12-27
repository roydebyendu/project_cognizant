package com.debyendu.appointment.controller;

import com.debyendu.appointment.model.Appointment;
import com.debyendu.appointment.model.AppointmentStatus;
import com.debyendu.appointment.service.AppointmentService;
import jakarta.validation.Valid;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.format.annotation.DateTimeFormat;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.time.LocalDate;
import java.util.List;
import java.util.Optional;

@RestController
@RequestMapping("/appointments")
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
   
    @GetMapping("/patient/{patientId}")
    public ResponseEntity<List<Appointment>> getAppointmentsByPatient(@PathVariable Long patientId) {
        List<Appointment> appointments = appointmentService.getAppointmentsByPatient(patientId);
        return ResponseEntity.ok(appointments);
    }
   
    @GetMapping("/doctor/{doctorId}")
    public ResponseEntity<List<Appointment>> getAppointmentsByDoctor(@PathVariable Long doctorId) {
        List<Appointment> appointments = appointmentService.getAppointmentsByDoctor(doctorId);
        return ResponseEntity.ok(appointments);
    }
   
    @GetMapping("/status/{status}")
    public ResponseEntity<List<Appointment>> getAppointmentsByStatus(@PathVariable AppointmentStatus status) {
        List<Appointment> appointments = appointmentService.getAppointmentsByStatus(status);
        return ResponseEntity.ok(appointments);
    }
   
    @GetMapping("/date/{date}")
    public ResponseEntity<List<Appointment>> getAppointmentsByDate(
            @PathVariable @DateTimeFormat(iso = DateTimeFormat.ISO.DATE) LocalDate date) {
        List<Appointment> appointments = appointmentService.getAppointmentsByDate(date);
        return ResponseEntity.ok(appointments);
    }
   
    @GetMapping("/patient/{patientId}/status/{status}")
    public ResponseEntity<List<Appointment>> getPatientAppointmentsByStatus(
            @PathVariable Long patientId, @PathVariable AppointmentStatus status) {
        List<Appointment> appointments = appointmentService.getPatientAppointmentsByStatus(patientId, status);
        return ResponseEntity.ok(appointments);
    }
   
    @GetMapping("/doctor/{doctorId}/status/{status}")
    public ResponseEntity<List<Appointment>> getDoctorAppointmentsByStatus(
            @PathVariable Long doctorId, @PathVariable AppointmentStatus status) {
        List<Appointment> appointments = appointmentService.getDoctorAppointmentsByStatus(doctorId, status);
        return ResponseEntity.ok(appointments);
    }
   
    @GetMapping("/doctor/{doctorId}/date/{date}")
    public ResponseEntity<List<Appointment>> getDoctorAppointmentsByDate(
            @PathVariable Long doctorId,
            @PathVariable @DateTimeFormat(iso = DateTimeFormat.ISO.DATE) LocalDate date) {
        List<Appointment> appointments = appointmentService.getDoctorAppointmentsByDate(doctorId, date);
        return ResponseEntity.ok(appointments);
    }
   
    @GetMapping("/between")
    public ResponseEntity<List<Appointment>> getAppointmentsBetweenDates(
            @RequestParam @DateTimeFormat(iso = DateTimeFormat.ISO.DATE) LocalDate startDate,
            @RequestParam @DateTimeFormat(iso = DateTimeFormat.ISO.DATE) LocalDate endDate) {
        List<Appointment> appointments = appointmentService.getAppointmentsBetweenDates(startDate, endDate);
        return ResponseEntity.ok(appointments);
    }
   
    @PostMapping
    public ResponseEntity<?> createAppointment(@Valid @RequestBody Appointment appointment) {
        try {
            Appointment createdAppointment = appointmentService.createAppointment(appointment);
            return ResponseEntity.status(HttpStatus.CREATED).body(createdAppointment);
        } catch (RuntimeException e) {
            return ResponseEntity.badRequest().body(e.getMessage());
        }
    }
   
    @PutMapping("/{id}")
    public ResponseEntity<?> updateAppointment(@PathVariable Long id, @Valid @RequestBody Appointment appointmentDetails) {
        try {
            Appointment updatedAppointment = appointmentService.updateAppointment(id, appointmentDetails);
            return ResponseEntity.ok(updatedAppointment);
        } catch (RuntimeException e) {
            return ResponseEntity.badRequest().body(e.getMessage());
        }
    }
   
    @PatchMapping("/{id}/status")
    public ResponseEntity<?> updateAppointmentStatus(@PathVariable Long id, @RequestParam AppointmentStatus status) {
        try {
            Appointment updatedAppointment = appointmentService.updateAppointmentStatus(id, status);
            return ResponseEntity.ok(updatedAppointment);
        } catch (RuntimeException e) {
            return ResponseEntity.badRequest().body(e.getMessage());
        }
    }
   
    @PatchMapping("/{id}/cancel")
    public ResponseEntity<?> cancelAppointment(@PathVariable Long id) {
        try {
            Appointment cancelledAppointment = appointmentService.cancelAppointment(id);
            return ResponseEntity.ok(cancelledAppointment);
        } catch (RuntimeException e) {
            return ResponseEntity.badRequest().body(e.getMessage());
        }
    }
   
    @PatchMapping("/{id}/complete")
    public ResponseEntity<?> completeAppointment(@PathVariable Long id) {
        try {
            Appointment completedAppointment = appointmentService.completeAppointment(id);
            return ResponseEntity.ok(completedAppointment);
        } catch (RuntimeException e) {
            return ResponseEntity.badRequest().body(e.getMessage());
        }
    }
   
    @DeleteMapping("/{id}")
    public ResponseEntity<?> deleteAppointment(@PathVariable Long id) {
        try {
            appointmentService.deleteAppointment(id);
            return ResponseEntity.ok().body("Appointment deleted successfully");
        } catch (RuntimeException e) {
            return ResponseEntity.badRequest().body(e.getMessage());
        }
    }
}