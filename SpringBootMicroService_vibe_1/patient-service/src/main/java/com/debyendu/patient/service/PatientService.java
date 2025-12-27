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
        return (List<Patient>) patientRepository.findAll();
    }
   
    public Optional<Patient> getPatientById(Long id) {
        return patientRepository.findById(id);
    }
   
    public Patient savePatient(Patient patient) {
        return patientRepository.save(patient);
    }
   
    public Patient updatePatient(Long id, Patient patientDetails) {
        Optional<Patient> optionalPatient = patientRepository.findById(id);
        if (optionalPatient.isPresent()) {
            Patient patient = optionalPatient.get();
            patient.setFirstName(patientDetails.getFirstName());
            patient.setLastName(patientDetails.getLastName());
            patient.setEmail(patientDetails.getEmail());
            patient.setPhoneNumber(patientDetails.getPhoneNumber());
            patient.setDateOfBirth(patientDetails.getDateOfBirth());
            patient.setAddress(patientDetails.getAddress());
            patient.setGender(patientDetails.getGender());
            patient.setBloodType(patientDetails.getBloodType());
            patient.setEmergencyContact(patientDetails.getEmergencyContact());
            patient.setEmergencyContactPhone(patientDetails.getEmergencyContactPhone());
            return patientRepository.save(patient);
        }
        return null;
    }
   
    public boolean deletePatient(Long id) {
        if (patientRepository.existsById(id)) {
            patientRepository.deleteById(id);
            return true;
        }
        return false;
    }
   
    public Optional<Patient> getPatientByEmail(String email) {
        return patientRepository.findByEmail(email);
    }
   
    public Optional<Patient> getPatientByPhoneNumber(String phoneNumber) {
        return patientRepository.findByPhoneNumber(phoneNumber);
    }
   
    public List<Patient> searchPatients(String firstName, String lastName) {
        return patientRepository.findByFirstNameContainingAndLastNameContaining(firstName, lastName);
    }
   
    public List<Patient> getPatientsByBloodType(String bloodType) {
        return patientRepository.findByBloodType(bloodType);
    }
}