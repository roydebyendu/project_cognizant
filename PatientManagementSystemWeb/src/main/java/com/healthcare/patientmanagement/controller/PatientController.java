package com.healthcare.patientmanagement.controller;

import com.healthcare.patientmanagement.entity.Patient;
import com.healthcare.patientmanagement.service.PatientService;
import jakarta.validation.Valid;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.time.LocalDate;
import java.util.List;

@RestController
@RequestMapping("/api/patients")
@CrossOrigin(origins = "*")
public class PatientController {
   
    @Autowired
    private PatientService patientService;
   
    @GetMapping
    public ResponseEntity<List<Patient>> getAllPatients() {
        List<Patient> patients = patientService.getAllPatients();
        return ResponseEntity.ok(patients);
    }
   
    @GetMapping("/{id}")
    public ResponseEntity<Patient> getPatientById(@PathVariable Long id) {
        return patientService.getPatientById(id)
                .map(patient -> ResponseEntity.ok(patient))
                .orElse(ResponseEntity.notFound().build());
    }
   
    @GetMapping("/email/{email}")
    public ResponseEntity<Patient> getPatientByEmail(@PathVariable String email) {
        return patientService.getPatientByEmail(email)
                .map(patient -> ResponseEntity.ok(patient))
                .orElse(ResponseEntity.notFound().build());
    }
   
    @PostMapping
    public ResponseEntity<Patient> createPatient(@Valid @RequestBody Patient patient) {
        try {
            Patient savedPatient = patientService.savePatient(patient);
            return ResponseEntity.status(HttpStatus.CREATED).body(savedPatient);
        } catch (RuntimeException e) {
            return ResponseEntity.status(HttpStatus.BAD_REQUEST).build();
        }
    }
   
    @PutMapping("/{id}")
    public ResponseEntity<Patient> updatePatient(@PathVariable Long id,
                                               @Valid @RequestBody Patient patientDetails) {
        try {
            Patient updatedPatient = patientService.updatePatient(id, patientDetails);
            return ResponseEntity.ok(updatedPatient);
        } catch (RuntimeException e) {
            return ResponseEntity.notFound().build();
        }
    }
   
    @DeleteMapping("/{id}")
    public ResponseEntity<Void> deletePatient(@PathVariable Long id) {
        try {
            patientService.deletePatient(id);
            return ResponseEntity.noContent().build();
        } catch (RuntimeException e) {
            return ResponseEntity.notFound().build();
        }
    }
   
    @GetMapping("/search")
    public ResponseEntity<List<Patient>> searchPatients(@RequestParam String term) {
        List<Patient> patients = patientService.searchPatients(term);
        return ResponseEntity.ok(patients);
    }
   
    @GetMapping("/by-name")
    public ResponseEntity<List<Patient>> getPatientsByName(
            @RequestParam(required = false) String firstName,
            @RequestParam(required = false) String lastName) {
        List<Patient> patients = patientService.getPatientsByName(
                firstName != null ? firstName : "",
                lastName != null ? lastName : "");
        return ResponseEntity.ok(patients);
    }
   
    @GetMapping("/by-gender/{gender}")
    public ResponseEntity<List<Patient>> getPatientsByGender(@PathVariable Patient.Gender gender) {
        List<Patient> patients = patientService.getPatientsByGender(gender);
        return ResponseEntity.ok(patients);
    }
   
    @GetMapping("/by-age-range")
    public ResponseEntity<List<Patient>> getPatientsByAgeRange(
            @RequestParam LocalDate startDate,
            @RequestParam LocalDate endDate) {
        List<Patient> patients = patientService.getPatientsByDateOfBirthRange(startDate, endDate);
        return ResponseEntity.ok(patients);
    }
   
    @GetMapping("/exists/email/{email}")
    public ResponseEntity<Boolean> checkEmailExists(@PathVariable String email) {
        boolean exists = patientService.existsByEmail(email);
        return ResponseEntity.ok(exists);
    }
   
    @GetMapping("/exists/phone/{phoneNumber}")
    public ResponseEntity<Boolean> checkPhoneExists(@PathVariable String phoneNumber) {
        boolean exists = patientService.existsByPhoneNumber(phoneNumber);
        return ResponseEntity.ok(exists);
    }
}