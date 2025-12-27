package com.debyendu.web.client;

import com.debyendu.web.model.Appointment;
import org.springframework.cloud.openfeign.FeignClient;
import org.springframework.format.annotation.DateTimeFormat;
import org.springframework.web.bind.annotation.*;

import java.time.LocalDateTime;
import java.util.List;

@FeignClient(name = "appointment-service", url = "${api.gateway.url}")
public interface AppointmentServiceClient {
   
    @GetMapping("/api/appointments")
    List<Appointment> getAllAppointments();
   
    @GetMapping("/api/appointments/{id}")
    Appointment getAppointmentById(@PathVariable("id") Long id);
   
    @PostMapping("/api/appointments")
    Appointment createAppointment(@RequestBody Appointment appointment);
   
    @PutMapping("/api/appointments/{id}")
    Appointment updateAppointment(@PathVariable("id") Long id, @RequestBody Appointment appointment);
   
    @DeleteMapping("/api/appointments/{id}")
    void deleteAppointment(@PathVariable("id") Long id);
   
    @GetMapping("/api/appointments/patient/{patientId}")
    List<Appointment> getAppointmentsByPatientId(@PathVariable("patientId") Long patientId);
   
    @GetMapping("/api/appointments/doctor/{doctorId}")
    List<Appointment> getAppointmentsByDoctorId(@PathVariable("doctorId") Long doctorId);
   
    @GetMapping("/api/appointments/status/{status}")
    List<Appointment> getAppointmentsByStatus(@PathVariable("status") String status);
   
    @PatchMapping("/api/appointments/{id}/status/{status}")
    Appointment updateAppointmentStatus(@PathVariable("id") Long id, @PathVariable("status") String status);
}
