package com.debyendu.appointment.service;

import com.debyendu.appointment.model.Appointment;
import com.debyendu.appointment.repository.AppointmentRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.time.LocalDateTime;
import java.util.List;
import java.util.Optional;

@Service
public class AppointmentService {
   
    @Autowired
    private AppointmentRepository appointmentRepository;
   
    public List<Appointment> getAllAppointments() {
        return (List<Appointment>) appointmentRepository.findAll();
    }
   
    public Optional<Appointment> getAppointmentById(Long id) {
        return appointmentRepository.findById(id);
    }
   
    public Appointment saveAppointment(Appointment appointment) {
        appointment.setCreatedAt(LocalDateTime.now());
        appointment.setUpdatedAt(LocalDateTime.now());
        if (appointment.getStatus() == null) {
            appointment.setStatus("SCHEDULED");
        }
        return appointmentRepository.save(appointment);
    }
   
    public Appointment updateAppointment(Long id, Appointment appointmentDetails) {
        Optional<Appointment> optionalAppointment = appointmentRepository.findById(id);
        if (optionalAppointment.isPresent()) {
            Appointment appointment = optionalAppointment.get();
            appointment.setPatientId(appointmentDetails.getPatientId());
            appointment.setDoctorId(appointmentDetails.getDoctorId());
            appointment.setAppointmentDateTime(appointmentDetails.getAppointmentDateTime());
            appointment.setStatus(appointmentDetails.getStatus());
            appointment.setReason(appointmentDetails.getReason());
            appointment.setNotes(appointmentDetails.getNotes());
            appointment.setConsultationFee(appointmentDetails.getConsultationFee());
            appointment.setDuration(appointmentDetails.getDuration());
            appointment.setAppointmentType(appointmentDetails.getAppointmentType());
            appointment.setUpdatedAt(LocalDateTime.now());
            return appointmentRepository.save(appointment);
        }
        return null;
    }
   
    public boolean deleteAppointment(Long id) {
        if (appointmentRepository.existsById(id)) {
            appointmentRepository.deleteById(id);
            return true;
        }
        return false;
    }
   
    public List<Appointment> getAppointmentsByPatientId(Long patientId) {
        return appointmentRepository.findByPatientId(patientId);
    }
   
    public List<Appointment> getAppointmentsByDoctorId(Long doctorId) {
        return appointmentRepository.findByDoctorId(doctorId);
    }
   
    public List<Appointment> getAppointmentsByStatus(String status) {
        return appointmentRepository.findByStatus(status);
    }
   
    public List<Appointment> getAppointmentsBetweenDates(LocalDateTime startDate, LocalDateTime endDate) {
        return appointmentRepository.findByAppointmentDateTimeBetween(startDate, endDate);
    }
   
    public List<Appointment> getDoctorAppointmentsBetweenDates(Long doctorId, LocalDateTime startDate, LocalDateTime endDate) {
        return appointmentRepository.findByDoctorIdAndAppointmentDateTimeBetween(doctorId, startDate, endDate);
    }
   
    public List<Appointment> getPatientAppointmentsByStatus(Long patientId, String status) {
        return appointmentRepository.findByPatientIdAndStatus(patientId, status);
    }
   
    public List<Appointment> getDoctorAppointmentsByStatus(Long doctorId, String status) {
        return appointmentRepository.findByDoctorIdAndStatus(doctorId, status);
    }
   
    public Appointment updateAppointmentStatus(Long id, String status) {
        Optional<Appointment> optionalAppointment = appointmentRepository.findById(id);
        if (optionalAppointment.isPresent()) {
            Appointment appointment = optionalAppointment.get();
            appointment.setStatus(status);
            appointment.setUpdatedAt(LocalDateTime.now());
            return appointmentRepository.save(appointment);
        }
        return null;
    }
}