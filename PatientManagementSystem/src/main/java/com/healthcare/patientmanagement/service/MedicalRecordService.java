package com.healthcare.patientmanagement.service;

import com.healthcare.patientmanagement.entity.MedicalRecord;
import com.healthcare.patientmanagement.entity.Patient;
import com.healthcare.patientmanagement.entity.Doctor;
import com.healthcare.patientmanagement.repository.MedicalRecordRepository;
import com.healthcare.patientmanagement.repository.PatientRepository;
import com.healthcare.patientmanagement.repository.DoctorRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.time.LocalDateTime;
import java.util.List;
import java.util.Optional;

@Service
@Transactional
public class MedicalRecordService {
   
    @Autowired
    private MedicalRecordRepository medicalRecordRepository;
   
    @Autowired
    private PatientRepository patientRepository;
   
    @Autowired
    private DoctorRepository doctorRepository;
   
    public List<MedicalRecord> getAllMedicalRecords() {
        return medicalRecordRepository.findAll();
    }
   
    public Optional<MedicalRecord> getMedicalRecordById(Long id) {
        return medicalRecordRepository.findById(id);
    }
   
    public MedicalRecord saveMedicalRecord(MedicalRecord medicalRecord) {
        return medicalRecordRepository.save(medicalRecord);
    }
   
    public MedicalRecord createMedicalRecord(Long patientId, Long doctorId, LocalDateTime visitDate) {
        Patient patient = patientRepository.findById(patientId)
                .orElseThrow(() -> new RuntimeException("Patient not found with id: " + patientId));
       
        Doctor doctor = doctorRepository.findById(doctorId)
                .orElseThrow(() -> new RuntimeException("Doctor not found with id: " + doctorId));
       
        MedicalRecord medicalRecord = new MedicalRecord(patient, doctor, visitDate);
        return saveMedicalRecord(medicalRecord);
    }
   
    public MedicalRecord updateMedicalRecord(Long id, MedicalRecord recordDetails) {
        MedicalRecord medicalRecord = medicalRecordRepository.findById(id)
                .orElseThrow(() -> new RuntimeException("Medical record not found with id: " + id));
       
        medicalRecord.setVisitDate(recordDetails.getVisitDate());
        medicalRecord.setDiagnosis(recordDetails.getDiagnosis());
        medicalRecord.setSymptoms(recordDetails.getSymptoms());
        medicalRecord.setTreatment(recordDetails.getTreatment());
        medicalRecord.setPrescription(recordDetails.getPrescription());
        medicalRecord.setTestResults(recordDetails.getTestResults());
        medicalRecord.setFollowUpDate(recordDetails.getFollowUpDate());
        medicalRecord.setNotes(recordDetails.getNotes());
        medicalRecord.setVitalSigns(recordDetails.getVitalSigns());
       
        return medicalRecordRepository.save(medicalRecord);
    }
   
    public void deleteMedicalRecord(Long id) {
        MedicalRecord medicalRecord = medicalRecordRepository.findById(id)
                .orElseThrow(() -> new RuntimeException("Medical record not found with id: " + id));
        medicalRecordRepository.delete(medicalRecord);
    }
   
    public List<MedicalRecord> getMedicalRecordsByPatient(Long patientId) {
        return medicalRecordRepository.findByPatientIdOrderByVisitDateDesc(patientId);
    }
   
    public List<MedicalRecord> getMedicalRecordsByDoctor(Long doctorId) {
        return medicalRecordRepository.findByDoctorIdOrderByVisitDateDesc(doctorId);
    }
   
    public List<MedicalRecord> getMedicalRecordsByDateRange(LocalDateTime startDate, LocalDateTime endDate) {
        return medicalRecordRepository.findByVisitDateBetween(startDate, endDate);
    }
   
    public List<MedicalRecord> getPatientRecordsInDateRange(Long patientId,
                                                          LocalDateTime startDate,
                                                          LocalDateTime endDate) {
        return medicalRecordRepository.findPatientRecordsInDateRange(patientId, startDate, endDate);
    }
   
    public List<MedicalRecord> searchMedicalRecords(String searchTerm) {
        return medicalRecordRepository.searchMedicalRecords(searchTerm);
    }
}