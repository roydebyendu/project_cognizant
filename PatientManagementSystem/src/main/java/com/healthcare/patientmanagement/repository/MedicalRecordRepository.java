package com.healthcare.patientmanagement.repository;

import com.healthcare.patientmanagement.entity.MedicalRecord;
import com.healthcare.patientmanagement.entity.Patient;
import com.healthcare.patientmanagement.entity.Doctor;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import java.time.LocalDateTime;
import java.util.List;

@Repository
public interface MedicalRecordRepository extends JpaRepository<MedicalRecord, Long> {
   
    List<MedicalRecord> findByPatient(Patient patient);
   
    List<MedicalRecord> findByDoctor(Doctor doctor);
   
    List<MedicalRecord> findByVisitDateBetween(LocalDateTime startDate, LocalDateTime endDate);
   
    @Query("SELECT mr FROM MedicalRecord mr WHERE mr.patient.id = :patientId ORDER BY mr.visitDate DESC")
    List<MedicalRecord> findByPatientIdOrderByVisitDateDesc(@Param("patientId") Long patientId);
   
    @Query("SELECT mr FROM MedicalRecord mr WHERE mr.doctor.id = :doctorId ORDER BY mr.visitDate DESC")
    List<MedicalRecord> findByDoctorIdOrderByVisitDateDesc(@Param("doctorId") Long doctorId);
   
    @Query("SELECT mr FROM MedicalRecord mr WHERE " +
           "LOWER(mr.diagnosis) LIKE LOWER(CONCAT('%', :searchTerm, '%')) OR " +
           "LOWER(mr.symptoms) LIKE LOWER(CONCAT('%', :searchTerm, '%')) OR " +
           "LOWER(mr.treatment) LIKE LOWER(CONCAT('%', :searchTerm, '%'))")
    List<MedicalRecord> searchMedicalRecords(@Param("searchTerm") String searchTerm);
   
    @Query("SELECT mr FROM MedicalRecord mr WHERE mr.patient.id = :patientId AND " +
           "mr.visitDate BETWEEN :startDate AND :endDate")
    List<MedicalRecord> findPatientRecordsInDateRange(
            @Param("patientId") Long patientId,
            @Param("startDate") LocalDateTime startDate,
            @Param("endDate") LocalDateTime endDate);
}