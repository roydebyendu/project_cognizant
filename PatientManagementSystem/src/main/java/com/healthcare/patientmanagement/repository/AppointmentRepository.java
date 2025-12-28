package com.healthcare.patientmanagement.repository;

import com.healthcare.patientmanagement.entity.Appointment;
import com.healthcare.patientmanagement.entity.Doctor;
import com.healthcare.patientmanagement.entity.Patient;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import java.time.LocalDateTime;
import java.util.List;

@Repository
public interface AppointmentRepository extends JpaRepository<Appointment, Long> {
   
    List<Appointment> findByPatient(Patient patient);
   
    List<Appointment> findByDoctor(Doctor doctor);
   
    List<Appointment> findByStatus(Appointment.AppointmentStatus status);
   
    List<Appointment> findByAppointmentDateTimeBetween(LocalDateTime startDate, LocalDateTime endDate);
   
    @Query("SELECT a FROM Appointment a WHERE a.patient.id = :patientId ORDER BY a.appointmentDateTime DESC")
    List<Appointment> findByPatientIdOrderByAppointmentDateTimeDesc(@Param("patientId") Long patientId);
   
    @Query("SELECT a FROM Appointment a WHERE a.doctor.id = :doctorId ORDER BY a.appointmentDateTime ASC")
    List<Appointment> findByDoctorIdOrderByAppointmentDateTimeAsc(@Param("doctorId") Long doctorId);
   
    @Query("SELECT a FROM Appointment a WHERE a.doctor.id = :doctorId AND " +
           "a.appointmentDateTime BETWEEN :startDate AND :endDate")
    List<Appointment> findDoctorAppointmentsInDateRange(
            @Param("doctorId") Long doctorId,
            @Param("startDate") LocalDateTime startDate,
            @Param("endDate") LocalDateTime endDate);
   
    @Query("SELECT COUNT(a) > 0 FROM Appointment a WHERE a.doctor.id = :doctorId AND " +
           "a.appointmentDateTime = :appointmentDateTime AND a.status != 'CANCELLED'")
    boolean existsByDoctorAndDateTime(
            @Param("doctorId") Long doctorId,
            @Param("appointmentDateTime") LocalDateTime appointmentDateTime);
   
    @Query("SELECT a FROM Appointment a WHERE DATE(a.appointmentDateTime) = DATE(:date)")
    List<Appointment> findAppointmentsByDate(@Param("date") LocalDateTime date);
}