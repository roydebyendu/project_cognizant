package com.debyendu.doctor.controller;

import com.debyendu.doctor.model.Doctor;
import com.debyendu.doctor.service.DoctorService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import jakarta.validation.Valid;
import java.util.List;
import java.util.Optional;

@RestController
@RequestMapping("/api/doctors")
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
   
    @PostMapping
    public ResponseEntity<Doctor> createDoctor(@Valid @RequestBody Doctor doctor) {
        try {
            Doctor savedDoctor = doctorService.saveDoctor(doctor);
            return ResponseEntity.status(HttpStatus.CREATED).body(savedDoctor);
        } catch (Exception e) {
            return ResponseEntity.status(HttpStatus.BAD_REQUEST).build();
        }
    }
   
    @PutMapping("/{id}")
    public ResponseEntity<Doctor> updateDoctor(@PathVariable Long id,
                                             @Valid @RequestBody Doctor doctorDetails) {
        Doctor updatedDoctor = doctorService.updateDoctor(id, doctorDetails);
        if (updatedDoctor != null) {
            return ResponseEntity.ok(updatedDoctor);
        }
        return ResponseEntity.notFound().build();
    }
   
    @DeleteMapping("/{id}")
    public ResponseEntity<Void> deleteDoctor(@PathVariable Long id) {
        boolean deleted = doctorService.deleteDoctor(id);
        if (deleted) {
            return ResponseEntity.noContent().build();
        }
        return ResponseEntity.notFound().build();
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
   
    @GetMapping("/department/{department}")
    public ResponseEntity<List<Doctor>> getDoctorsByDepartment(@PathVariable String department) {
        List<Doctor> doctors = doctorService.getDoctorsByDepartment(department);
        return ResponseEntity.ok(doctors);
    }
   
    @GetMapping("/search")
    public ResponseEntity<List<Doctor>> searchDoctors(@RequestParam String firstName,
                                                     @RequestParam String lastName) {
        List<Doctor> doctors = doctorService.searchDoctors(firstName, lastName);
        return ResponseEntity.ok(doctors);
    }
   
    @GetMapping("/experience/{minYears}")
    public ResponseEntity<List<Doctor>> getDoctorsByMinExperience(@PathVariable Integer minYears) {
        List<Doctor> doctors = doctorService.getDoctorsByMinExperience(minYears);
        return ResponseEntity.ok(doctors);
    }
}