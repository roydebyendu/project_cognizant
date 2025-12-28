package com.healthcare.patientmanagement.service;

import com.healthcare.patientmanagement.entity.Patient;
import com.healthcare.patientmanagement.repository.PatientRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.time.LocalDate;
import java.util.List;
import java.util.Optional;

@Service
@Transactional
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
   
    public Patient savePatient(Patient patient) {
        validatePatient(patient);
        return patientRepository.save(patient);
    }
   
    public Patient updatePatient(Long id, Patient patientDetails) {
        Patient patient = patientRepository.findById(id)
                .orElseThrow(() -> new RuntimeException("Patient not found with id: " + id));
       
        patient.setFirstName(patientDetails.getFirstName());
        patient.setLastName(patientDetails.getLastName());
        patient.setEmail(patientDetails.getEmail());
        patient.setPhoneNumber(patientDetails.getPhoneNumber());
        patient.setDateOfBirth(patientDetails.getDateOfBirth());
        patient.setGender(patientDetails.getGender());
        patient.setAddress(patientDetails.getAddress());
        patient.setEmergencyContactName(patientDetails.getEmergencyContactName());
        patient.setEmergencyContactPhone(patientDetails.getEmergencyContactPhone());
       
        return patientRepository.save(patient);
    }
   
    public void deletePatient(Long id) {
        Patient patient = patientRepository.findById(id)
                .orElseThrow(() -> new RuntimeException("Patient not found with id: " + id));
        patientRepository.delete(patient);
    }
   
    public List<Patient> searchPatients(String searchTerm) {
        return patientRepository.searchPatients(searchTerm);
    }
   
    public List<Patient> getPatientsByName(String firstName, String lastName) {
        return patientRepository.findByFirstNameContainingIgnoreCaseOrLastNameContainingIgnoreCase(
                firstName, lastName);
    }
   
    public List<Patient> getPatientsByDateOfBirthRange(LocalDate startDate, LocalDate endDate) {
        return patientRepository.findByDateOfBirthBetween(startDate, endDate);
    }
   
    public List<Patient> getPatientsByGender(Patient.Gender gender) {
        return patientRepository.findByGender(gender);
    }
   
    public boolean existsByEmail(String email) {
        return patientRepository.existsByEmail(email);
    }
   
    public boolean existsByPhoneNumber(String phoneNumber) {
        return patientRepository.existsByPhoneNumber(phoneNumber);
    }
   
    private void validatePatient(Patient patient) {
        if (patient.getId() == null && existsByEmail(patient.getEmail())) {
            throw new RuntimeException("Patient with email " + patient.getEmail() + " already exists");
        }
       
        if (patient.getPhoneNumber() != null &&
            patient.getId() == null &&
            existsByPhoneNumber(patient.getPhoneNumber())) {
            throw new RuntimeException("Patient with phone number " + patient.getPhoneNumber() + " already exists");
        }
    }
}