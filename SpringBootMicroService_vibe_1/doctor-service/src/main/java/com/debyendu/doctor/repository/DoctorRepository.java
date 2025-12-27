package com.debyendu.doctor.repository;

import com.debyendu.doctor.model.Doctor;
import org.springframework.data.jdbc.repository.query.Query;
import org.springframework.data.repository.CrudRepository;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import java.util.List;
import java.util.Optional;

@Repository
public interface DoctorRepository extends CrudRepository<Doctor, Long> {
   
    @Query("SELECT * FROM doctors WHERE email = :email")
    Optional<Doctor> findByEmail(@Param("email") String email);
   
    @Query("SELECT * FROM doctors WHERE license_number = :licenseNumber")
    Optional<Doctor> findByLicenseNumber(@Param("licenseNumber") String licenseNumber);
   
    @Query("SELECT * FROM doctors WHERE specialization = :specialization")
    List<Doctor> findBySpecialization(@Param("specialization") String specialization);
   
    @Query("SELECT * FROM doctors WHERE department = :department")
    List<Doctor> findByDepartment(@Param("department") String department);
   
    @Query("SELECT * FROM doctors WHERE first_name LIKE %:firstName% AND last_name LIKE %:lastName%")
    List<Doctor> findByFirstNameContainingAndLastNameContaining(
            @Param("firstName") String firstName,
            @Param("lastName") String lastName);
   
    @Query("SELECT * FROM doctors WHERE experience_years >= :minYears")
    List<Doctor> findByExperienceYearsGreaterThanEqual(@Param("minYears") Integer minYears);
}