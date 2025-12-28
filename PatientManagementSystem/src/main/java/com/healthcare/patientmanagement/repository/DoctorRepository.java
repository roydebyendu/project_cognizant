package com.healthcare.patientmanagement.repository;

import com.healthcare.patientmanagement.entity.Doctor;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import java.util.List;
import java.util.Optional;

@Repository
public interface DoctorRepository extends JpaRepository<Doctor, Long> {
   
    Optional<Doctor> findByEmail(String email);
   
    Optional<Doctor> findByLicenseNumber(String licenseNumber);
   
    List<Doctor> findBySpecializationContainingIgnoreCase(String specialization);
   
    List<Doctor> findByDepartmentContainingIgnoreCase(String department);
   
    List<Doctor> findByIsAvailable(Boolean isAvailable);
   
    @Query("SELECT d FROM Doctor d WHERE d.isAvailable = true AND " +
           "LOWER(d.specialization) LIKE LOWER(CONCAT('%', :specialization, '%'))")
    List<Doctor> findAvailableDoctorsBySpecialization(@Param("specialization") String specialization);
   
    @Query("SELECT d FROM Doctor d WHERE " +
           "LOWER(d.firstName) LIKE LOWER(CONCAT('%', :searchTerm, '%')) OR " +
           "LOWER(d.lastName) LIKE LOWER(CONCAT('%', :searchTerm, '%')) OR " +
           "LOWER(d.specialization) LIKE LOWER(CONCAT('%', :searchTerm, '%')) OR " +
           "LOWER(d.department) LIKE LOWER(CONCAT('%', :searchTerm, '%'))")
    List<Doctor> searchDoctors(@Param("searchTerm") String searchTerm);
   
    boolean existsByEmail(String email);
   
    boolean existsByLicenseNumber(String licenseNumber);
}