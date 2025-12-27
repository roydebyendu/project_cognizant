package com.debyendu.web.client;

import com.debyendu.web.model.Appointment;
import org.springframework.cloud.openfeign.FeignClient;
import org.springframework.format.annotation.DateTimeFormat;
import org.springframework.web.bind.annotation.*;

import java.time.LocalDateTime;
import java.util.List;

@FeignClient(name = "appointment-service", url = "${api.gateway.url}")
public interface AppointmentServiceClient {
   
    @GetMapping("/appointments")
    List<Appointment> getAllAppointments();
   
    @GetMapping("/appointments/{id}")
    Appointment getAppointmentById(@PathVariable("id") Long id);
   
    @PostMapping("/appointments")
    Appointment createAppointment(@RequestBody Appointment appointment);
   
    @PutMapping("/appointments/{id}")
    Appointment updateAppointment(@PathVariable("id") Long id, @RequestBody Appointment appointment);
   
    @DeleteMapping("/appointments/{id}")
    void deleteAppointment(@PathVariable("id") Long id);
   
    @GetMapping("/appointments/patient/{patientId}")
    List<Appointment> getAppointmentsByPatientId(@PathVariable("patientId") Long patientId);
   
    @GetMapping("/appointments/doctor/{doctorId}")
    List<Appointment> getAppointmentsByDoctorId(@PathVariable("doctorId") Long doctorId);
   
    @GetMapping("/appointments/status/{status}")
    List<Appointment> getAppointmentsByStatus(@PathVariable("status") String status);
   
    @PatchMapping("/appointments/{id}/status/{status}")
    Appointment updateAppointmentStatus(@PathVariable("id") Long id, @PathVariable("status") String status);
}