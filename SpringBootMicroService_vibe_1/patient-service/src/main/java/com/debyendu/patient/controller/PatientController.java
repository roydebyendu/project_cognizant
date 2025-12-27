package com.debyendu.patient.controller;

import com.debyendu.patient.model.Patient;
import com.debyendu.patient.service.PatientService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import jakarta.validation.Valid;
import java.util.List;
import java.util.Optional;

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
        Optional<Patient> patient = patientService.getPatientById(id);
        return patient.map(ResponseEntity::ok)
                     .orElse(ResponseEntity.notFound().build());
    }
   
    @PostMapping
    public ResponseEntity<Patient> createPatient(@Valid @RequestBody Patient patient) {
        try {
            Patient savedPatient = patientService.savePatient(patient);
            return ResponseEntity.status(HttpStatus.CREATED).body(savedPatient);
        } catch (Exception e) {
            return ResponseEntity.status(HttpStatus.BAD_REQUEST).build();
        }
    }
   
    @PutMapping("/{id}")
    public ResponseEntity<Patient> updatePatient(@PathVariable Long id,
                                               @Valid @RequestBody Patient patientDetails) {
        Patient updatedPatient = patientService.updatePatient(id, patientDetails);
        if (updatedPatient != null) {
            return ResponseEntity.ok(updatedPatient);
        }
        return ResponseEntity.notFound().build();
    }
   
    @DeleteMapping("/{id}")
    public ResponseEntity<Void> deletePatient(@PathVariable Long id) {
        boolean deleted = patientService.deletePatient(id);
        if (deleted) {
            return ResponseEntity.noContent().build();
        }
        return ResponseEntity.notFound().build();
    }
   
    @GetMapping("/email/{email}")
    public ResponseEntity<Patient> getPatientByEmail(@PathVariable String email) {
        Optional<Patient> patient = patientService.getPatientByEmail(email);
        return patient.map(ResponseEntity::ok)
                     .orElse(ResponseEntity.notFound().build());
    }
   
    @GetMapping("/phone/{phoneNumber}")
    public ResponseEntity<Patient> getPatientByPhoneNumber(@PathVariable String phoneNumber) {
        Optional<Patient> patient = patientService.getPatientByPhoneNumber(phoneNumber);
        return patient.map(ResponseEntity::ok)
                     .orElse(ResponseEntity.notFound().build());
    }
   
    @GetMapping("/search")
    public ResponseEntity<List<Patient>> searchPatients(@RequestParam String firstName,
                                                       @RequestParam String lastName) {
        List<Patient> patients = patientService.searchPatients(firstName, lastName);
        return ResponseEntity.ok(patients);
    }
   
    @GetMapping("/blood-type/{bloodType}")
    public ResponseEntity<List<Patient>> getPatientsByBloodType(@PathVariable String bloodType) {
        List<Patient> patients = patientService.getPatientsByBloodType(bloodType);
        return ResponseEntity.ok(patients);
    }
}