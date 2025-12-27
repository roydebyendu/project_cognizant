package com.debyendu.appointment.repository;

import com.debyendu.appointment.model.Appointment;
import com.debyendu.appointment.model.AppointmentStatus;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import java.time.LocalDate;
import java.time.LocalTime;
import java.util.List;

@Repository
public interface AppointmentRepository extends JpaRepository<Appointment, Long> {
   
    List<Appointment> findByPatientId(Long patientId);
   
    List<Appointment> findByDoctorId(Long doctorId);
   
    List<Appointment> findByStatus(AppointmentStatus status);
   
    List<Appointment> findByAppointmentDate(LocalDate appointmentDate);
   
    List<Appointment> findByPatientIdAndStatus(Long patientId, AppointmentStatus status);
   
    List<Appointment> findByDoctorIdAndStatus(Long doctorId, AppointmentStatus status);
   
    @Query("SELECT a FROM Appointment a WHERE a.doctorId = :doctorId AND a.appointmentDate = :date AND a.appointmentTime = :time AND a.status = 'SCHEDULED'")
    List<Appointment> findConflictingAppointments(@Param("doctorId") Long doctorId,
                                                 @Param("date") LocalDate date,
                                                 @Param("time") LocalTime time);
   
    @Query("SELECT a FROM Appointment a WHERE a.appointmentDate BETWEEN :startDate AND :endDate")
    List<Appointment> findAppointmentsBetweenDates(@Param("startDate") LocalDate startDate,
                                                  @Param("endDate") LocalDate endDate);
   
    @Query("SELECT a FROM Appointment a WHERE a.doctorId = :doctorId AND a.appointmentDate = :date ORDER BY a.appointmentTime")
    List<Appointment> findDoctorAppointmentsByDate(@Param("doctorId") Long doctorId,
                                                  @Param("date") LocalDate date);
}