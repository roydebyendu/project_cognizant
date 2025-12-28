package com.healthcare.patientmanagement.service;

import com.healthcare.patientmanagement.entity.Appointment;
import com.healthcare.patientmanagement.entity.Doctor;
import com.healthcare.patientmanagement.entity.Patient;
import com.healthcare.patientmanagement.repository.AppointmentRepository;
import com.healthcare.patientmanagement.repository.DoctorRepository;
import com.healthcare.patientmanagement.repository.PatientRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.time.LocalDateTime;
import java.util.List;
import java.util.Optional;

@Service
@Transactional
public class AppointmentService {
   
    @Autowired
    private AppointmentRepository appointmentRepository;
   
    @Autowired
    private PatientRepository patientRepository;
   
    @Autowired
    private DoctorRepository doctorRepository;
   
    public List<Appointment> getAllAppointments() {
        return appointmentRepository.findAll();
    }
   
    public Optional<Appointment> getAppointmentById(Long id) {
        return appointmentRepository.findById(id);
    }
   
    public Appointment saveAppointment(Appointment appointment) {
        validateAppointment(appointment);
        return appointmentRepository.save(appointment);
    }
   
    public Appointment createAppointment(Long patientId, Long doctorId,
                                       LocalDateTime appointmentDateTime, String reasonForVisit) {
        Patient patient = patientRepository.findById(patientId)
                .orElseThrow(() -> new RuntimeException("Patient not found with id: " + patientId));
       
        Doctor doctor = doctorRepository.findById(doctorId)
                .orElseThrow(() -> new RuntimeException("Doctor not found with id: " + doctorId));
       
        Appointment appointment = new Appointment(patient, doctor, appointmentDateTime, reasonForVisit);
        return saveAppointment(appointment);
    }
   
    public Appointment updateAppointment(Long id, Appointment appointmentDetails) {
        Appointment appointment = appointmentRepository.findById(id)
                .orElseThrow(() -> new RuntimeException("Appointment not found with id: " + id));
       
        appointment.setAppointmentDateTime(appointmentDetails.getAppointmentDateTime());
        appointment.setStatus(appointmentDetails.getStatus());
        appointment.setReasonForVisit(appointmentDetails.getReasonForVisit());
        appointment.setNotes(appointmentDetails.getNotes());
        appointment.setDurationMinutes(appointmentDetails.getDurationMinutes());
       
        return appointmentRepository.save(appointment);
    }
   
    public Appointment updateAppointmentStatus(Long id, Appointment.AppointmentStatus status) {
        Appointment appointment = appointmentRepository.findById(id)
                .orElseThrow(() -> new RuntimeException("Appointment not found with id: " + id));
       
        appointment.setStatus(status);
        return appointmentRepository.save(appointment);
    }
   
    public void deleteAppointment(Long id) {
        Appointment appointment = appointmentRepository.findById(id)
                .orElseThrow(() -> new RuntimeException("Appointment not found with id: " + id));
        appointmentRepository.delete(appointment);
    }
   
    public List<Appointment> getAppointmentsByPatient(Long patientId) {
        return appointmentRepository.findByPatientIdOrderByAppointmentDateTimeDesc(patientId);
    }
   
    public List<Appointment> getAppointmentsByDoctor(Long doctorId) {
        return appointmentRepository.findByDoctorIdOrderByAppointmentDateTimeAsc(doctorId);
    }
   
    public List<Appointment> getAppointmentsByStatus(Appointment.AppointmentStatus status) {
        return appointmentRepository.findByStatus(status);
    }
   
    public List<Appointment> getAppointmentsByDateRange(LocalDateTime startDate, LocalDateTime endDate) {
        return appointmentRepository.findByAppointmentDateTimeBetween(startDate, endDate);
    }
   
    public List<Appointment> getDoctorAppointmentsInDateRange(Long doctorId,
                                                            LocalDateTime startDate,
                                                            LocalDateTime endDate) {
        return appointmentRepository.findDoctorAppointmentsInDateRange(doctorId, startDate, endDate);
    }
   
    public List<Appointment> getAppointmentsByDate(LocalDateTime date) {
        return appointmentRepository.findAppointmentsByDate(date);
    }
   
    public boolean isDoctorAvailable(Long doctorId, LocalDateTime appointmentDateTime) {
        return !appointmentRepository.existsByDoctorAndDateTime(doctorId, appointmentDateTime);
    }
   
    private void validateAppointment(Appointment appointment) {
        // Check if doctor is available
        if (!appointment.getDoctor().getIsAvailable()) {
            throw new RuntimeException("Doctor is not available for appointments");
        }
       
        // Check if appointment time is in the future
        if (appointment.getAppointmentDateTime().isBefore(LocalDateTime.now())) {
            throw new RuntimeException("Appointment cannot be scheduled in the past");
        }
       
        // Check if doctor has conflicting appointments
        if (!isDoctorAvailable(appointment.getDoctor().getId(), appointment.getAppointmentDateTime())) {
            throw new RuntimeException("Doctor is not available at the specified time");
        }
    }
}