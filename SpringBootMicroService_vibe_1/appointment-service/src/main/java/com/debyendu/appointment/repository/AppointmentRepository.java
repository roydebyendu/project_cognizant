package com.debyendu.appointment.repository;

import com.debyendu.appointment.model.Appointment;
import org.springframework.data.jdbc.repository.query.Query;
import org.springframework.data.repository.CrudRepository;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import java.time.LocalDateTime;
import java.util.List;

@Repository
public interface AppointmentRepository extends CrudRepository<Appointment, Long> {
   
    @Query("SELECT * FROM appointments WHERE patient_id = :patientId")
    List<Appointment> findByPatientId(@Param("patientId") Long patientId);
   
    @Query("SELECT * FROM appointments WHERE doctor_id = :doctorId")
    List<Appointment> findByDoctorId(@Param("doctorId") Long doctorId);
   
    @Query("SELECT * FROM appointments WHERE status = :status")
    List<Appointment> findByStatus(@Param("status") String status);
   
    @Query("SELECT * FROM appointments WHERE appointment_date_time BETWEEN :startDate AND :endDate")
    List<Appointment> findByAppointmentDateTimeBetween(
            @Param("startDate") LocalDateTime startDate,
            @Param("endDate") LocalDateTime endDate);
   
    @Query("SELECT * FROM appointments WHERE doctor_id = :doctorId AND appointment_date_time BETWEEN :startDate AND :endDate")
    List<Appointment> findByDoctorIdAndAppointmentDateTimeBetween(
            @Param("doctorId") Long doctorId,
            @Param("startDate") LocalDateTime startDate,
            @Param("endDate") LocalDateTime endDate);
   
    @Query("SELECT * FROM appointments WHERE patient_id = :patientId AND status = :status")
    List<Appointment> findByPatientIdAndStatus(@Param("patientId") Long patientId, @Param("status") String status);
   
    @Query("SELECT * FROM appointments WHERE doctor_id = :doctorId AND status = :status")
    List<Appointment> findByDoctorIdAndStatus(@Param("doctorId") Long doctorId, @Param("status") String status);
}