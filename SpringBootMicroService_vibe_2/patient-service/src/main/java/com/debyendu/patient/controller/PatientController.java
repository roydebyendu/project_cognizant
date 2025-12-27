package com.debyendu.patient.controller;

import com.debyendu.patient.model.Patient;
import com.debyendu.patient.service.PatientService;
import jakarta.validation.Valid;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;
import java.util.Optional;

@RestController
@RequestMapping("/patients")
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
   
    @GetMapping("/email/{email}")
    public ResponseEntity<Patient> getPatientByEmail(@PathVariable String email) {
        Optional<Patient> patient = patientService.getPatientByEmail(email);
        return patient.map(ResponseEntity::ok)
                     .orElse(ResponseEntity.notFound().build());
    }
   
    @GetMapping("/search")
    public ResponseEntity<List<Patient>> searchPatients(@RequestParam String name) {
        List<Patient> patients = patientService.searchPatientsByName(name);
        return ResponseEntity.ok(patients);
    }
   
    @PostMapping
    public ResponseEntity<?> createPatient(@Valid @RequestBody Patient patient) {
        try {
            Patient createdPatient = patientService.createPatient(patient);
            return ResponseEntity.status(HttpStatus.CREATED).body(createdPatient);
        } catch (RuntimeException e) {
            return ResponseEntity.badRequest().body(e.getMessage());
        }
    }
   
    @PutMapping("/{id}")
    public ResponseEntity<?> updatePatient(@PathVariable Long id, @Valid @RequestBody Patient patientDetails) {
        try {
            Patient updatedPatient = patientService.updatePatient(id, patientDetails);
            return ResponseEntity.ok(updatedPatient);
        } catch (RuntimeException e) {
            return ResponseEntity.badRequest().body(e.getMessage());
        }
    }
   
    @DeleteMapping("/{id}")
    public ResponseEntity<?> deletePatient(@PathVariable Long id) {
        try {
            patientService.deletePatient(id);
            return ResponseEntity.ok().body("Patient deleted successfully");
        } catch (RuntimeException e) {
            return ResponseEntity.badRequest().body(e.getMessage());
        }
    }
   
    @GetMapping("/{id}/exists")
    public ResponseEntity<Boolean> patientExists(@PathVariable Long id) {
        boolean exists = patientService.existsById(id);
        return ResponseEntity.ok(exists);
    }
}