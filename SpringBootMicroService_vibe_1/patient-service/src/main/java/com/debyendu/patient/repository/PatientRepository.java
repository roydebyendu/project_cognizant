package com.debyendu.patient.repository;

import com.debyendu.patient.model.Patient;
import org.springframework.data.jdbc.repository.query.Query;
import org.springframework.data.repository.CrudRepository;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import java.util.List;
import java.util.Optional;

@Repository
public interface PatientRepository extends CrudRepository<Patient, Long> {
   
    @Query("SELECT * FROM patients WHERE email = :email")
    Optional<Patient> findByEmail(@Param("email") String email);
   
    @Query("SELECT * FROM patients WHERE phone_number = :phoneNumber")
    Optional<Patient> findByPhoneNumber(@Param("phoneNumber") String phoneNumber);
   
    @Query("SELECT * FROM patients WHERE first_name LIKE %:firstName% AND last_name LIKE %:lastName%")
    List<Patient> findByFirstNameContainingAndLastNameContaining(
            @Param("firstName") String firstName,
            @Param("lastName") String lastName);
   
    @Query("SELECT * FROM patients WHERE blood_type = :bloodType")
    List<Patient> findByBloodType(@Param("bloodType") String bloodType);
}