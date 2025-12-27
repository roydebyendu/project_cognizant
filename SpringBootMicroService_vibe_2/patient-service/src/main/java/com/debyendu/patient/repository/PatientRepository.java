package com.debyendu.patient.repository;

import com.debyendu.patient.model.Patient;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import java.util.List;
import java.util.Optional;

@Repository
public interface PatientRepository extends JpaRepository<Patient, Long> {
   
    Optional<Patient> findByEmail(String email);
   
    @Query("SELECT p FROM Patient p WHERE p.firstName LIKE %:name% OR p.lastName LIKE %:name%")
    List<Patient> findByNameContaining(@Param("name") String name);
   
    List<Patient> findByPhone(String phone);
   
    boolean existsByEmail(String email);
   
    boolean existsByPhone(String phone);
}