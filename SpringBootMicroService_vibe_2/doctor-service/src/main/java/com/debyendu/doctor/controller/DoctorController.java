package com.debyendu.doctor.controller;

import com.debyendu.doctor.model.Doctor;
import com.debyendu.doctor.service.DoctorService;
import jakarta.validation.Valid;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;
import java.util.Optional;

@RestController
@RequestMapping("/doctors")
@CrossOrigin(origins = "*")
public class DoctorController {
   
    @Autowired
    private DoctorService doctorService;
   
    @GetMapping
    public ResponseEntity<List<Doctor>> getAllDoctors() {
        List<Doctor> doctors = doctorService.getAllDoctors();
        return ResponseEntity.ok(doctors);
    }
   
    @GetMapping("/{id}")
    public ResponseEntity<Doctor> getDoctorById(@PathVariable Long id) {
        Optional<Doctor> doctor = doctorService.getDoctorById(id);
        return doctor.map(ResponseEntity::ok)
                     .orElse(ResponseEntity.notFound().build());
    }
   
    @GetMapping("/email/{email}")
    public ResponseEntity<Doctor> getDoctorByEmail(@PathVariable String email) {
        Optional<Doctor> doctor = doctorService.getDoctorByEmail(email);
        return doctor.map(ResponseEntity::ok)
                     .orElse(ResponseEntity.notFound().build());
    }
   
    @GetMapping("/license/{licenseNumber}")
    public ResponseEntity<Doctor> getDoctorByLicenseNumber(@PathVariable String licenseNumber) {
        Optional<Doctor> doctor = doctorService.getDoctorByLicenseNumber(licenseNumber);
        return doctor.map(ResponseEntity::ok)
                     .orElse(ResponseEntity.notFound().build());
    }
   
    @GetMapping("/specialization/{specialization}")
    public ResponseEntity<List<Doctor>> getDoctorsBySpecialization(@PathVariable String specialization) {
        List<Doctor> doctors = doctorService.getDoctorsBySpecialization(specialization);
        return ResponseEntity.ok(doctors);
    }
   
    @GetMapping("/search")
    public ResponseEntity<List<Doctor>> searchDoctors(@RequestParam String name) {
        List<Doctor> doctors = doctorService.searchDoctorsByName(name);
        return ResponseEntity.ok(doctors);
    }
   
    @GetMapping("/experience/{minYears}")
    public ResponseEntity<List<Doctor>> getDoctorsByExperience(@PathVariable Integer minYears) {
        List<Doctor> doctors = doctorService.getDoctorsByExperience(minYears);
        return ResponseEntity.ok(doctors);
    }
   
    @PostMapping
    public ResponseEntity<?> createDoctor(@Valid @RequestBody Doctor doctor) {
        try {
            Doctor createdDoctor = doctorService.createDoctor(doctor);
            return ResponseEntity.status(HttpStatus.CREATED).body(createdDoctor);
        } catch (RuntimeException e) {
            return ResponseEntity.badRequest().body(e.getMessage());
        }
    }
   
    @PutMapping("/{id}")
    public ResponseEntity<?> updateDoctor(@PathVariable Long id, @Valid @RequestBody Doctor doctorDetails) {
        try {
            Doctor updatedDoctor = doctorService.updateDoctor(id, doctorDetails);
            return ResponseEntity.ok(updatedDoctor);
        } catch (RuntimeException e) {
            return ResponseEntity.badRequest().body(e.getMessage());
        }
    }
   
    @DeleteMapping("/{id}")
    public ResponseEntity<?> deleteDoctor(@PathVariable Long id) {
        try {
            doctorService.deleteDoctor(id);
            return ResponseEntity.ok().body("Doctor deleted successfully");
        } catch (RuntimeException e) {
            return ResponseEntity.badRequest().body(e.getMessage());
        }
    }
   
    @GetMapping("/{id}/exists")
    public ResponseEntity<Boolean> doctorExists(@PathVariable Long id) {
        boolean exists = doctorService.existsById(id);
        return ResponseEntity.ok(exists);
    }
}