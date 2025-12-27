package com.debyendu.doctor.repository;

import com.debyendu.doctor.model.Doctor;
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
   
    List<Doctor> findBySpecialization(String specialization);
   
    @Query("SELECT p FROM Doctor p WHERE p.firstName LIKE %:name% OR p.lastName LIKE %:name%")
    List<Doctor> findByNameContaining(@Param("name") String name);
   
    List<Doctor> findByYearsOfExperienceGreaterThanEqual(Integer years);
   
    boolean existsByEmail(String email);
   
    boolean existsByLicenseNumber(String licenseNumber);
   
    boolean existsByPhone(String phone);
}