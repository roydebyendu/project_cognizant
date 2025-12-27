package com.debyendu.patient.service;

import com.debyendu.patient.model.Patient;
import com.debyendu.patient.repository.PatientRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Optional;

@Service
public class PatientService {
   
    @Autowired
    private PatientRepository patientRepository;
   
    public List<Patient> getAllPatients() {
        return patientRepository.findAll();
    }
   
    public Optional<Patient> getPatientById(Long id) {
        return patientRepository.findById(id);
    }
   
    public Optional<Patient> getPatientByEmail(String email) {
        return patientRepository.findByEmail(email);
    }
   
    public List<Patient> searchPatientsByName(String name) {
        return patientRepository.findByNameContaining(name);
    }
   
    public Patient createPatient(Patient patient) {
        if (patientRepository.existsByEmail(patient.getEmail())) {
            throw new RuntimeException("Patient with email " + patient.getEmail() + " already exists");
        }
        if (patientRepository.existsByPhone(patient.getPhone())) {
            throw new RuntimeException("Patient with phone " + patient.getPhone() + " already exists");
        }
        return patientRepository.save(patient);
    }
   
    public Patient updatePatient(Long id, Patient patientDetails) {
        Patient patient = patientRepository.findById(id)
                .orElseThrow(() -> new RuntimeException("Patient not found with id: " + id));
       
        // Check if email is being changed and if new email already exists
        if (!patient.getEmail().equals(patientDetails.getEmail()) &&
            patientRepository.existsByEmail(patientDetails.getEmail())) {
            throw new RuntimeException("Patient with email " + patientDetails.getEmail() + " already exists");
        }
       
        // Check if phone is being changed and if new phone already exists
        if (!patient.getPhone().equals(patientDetails.getPhone()) &&
            patientRepository.existsByPhone(patientDetails.getPhone())) {
            throw new RuntimeException("Patient with phone " + patientDetails.getPhone() + " already exists");
        }
       
        patient.setFirstName(patientDetails.getFirstName());
        patient.setLastName(patientDetails.getLastName());
        patient.setEmail(patientDetails.getEmail());
        patient.setPhone(patientDetails.getPhone());
        patient.setDateOfBirth(patientDetails.getDateOfBirth());
        patient.setAddress(patientDetails.getAddress());
        patient.setMedicalHistory(patientDetails.getMedicalHistory());
       
        return patientRepository.save(patient);
    }
   
    public void deletePatient(Long id) {
        Patient patient = patientRepository.findById(id)
                .orElseThrow(() -> new RuntimeException("Patient not found with id: " + id));
        patientRepository.delete(patient);
    }
   
    public boolean existsById(Long id) {
        return patientRepository.existsById(id);
    }
}