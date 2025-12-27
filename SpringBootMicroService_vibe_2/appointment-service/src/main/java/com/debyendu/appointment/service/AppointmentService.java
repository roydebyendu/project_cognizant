package com.debyendu.appointment.service;

import com.debyendu.appointment.client.DoctorServiceClient;
import com.debyendu.appointment.client.PatientServiceClient;
import com.debyendu.appointment.model.Appointment;
import com.debyendu.appointment.model.AppointmentStatus;
import com.debyendu.appointment.repository.AppointmentRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.time.LocalDate;
import java.util.List;
import java.util.Optional;

@Service
public class AppointmentService {
   
    @Autowired
    private AppointmentRepository appointmentRepository;
   
    @Autowired
    private PatientServiceClient patientServiceClient;
   
    @Autowired
    private DoctorServiceClient doctorServiceClient;
   
    public List<Appointment> getAllAppointments() {
        return appointmentRepository.findAll();
    }
   
    public Optional<Appointment> getAppointmentById(Long id) {
        return appointmentRepository.findById(id);
    }
   
    public List<Appointment> getAppointmentsByPatient(Long patientId) {
        return appointmentRepository.findByPatientId(patientId);
    }
   
    public List<Appointment> getAppointmentsByDoctor(Long doctorId) {
        return appointmentRepository.findByDoctorId(doctorId);
    }
   
    public List<Appointment> getAppointmentsByStatus(AppointmentStatus status) {
        return appointmentRepository.findByStatus(status);
    }
   
    public List<Appointment> getAppointmentsByDate(LocalDate date) {
        return appointmentRepository.findByAppointmentDate(date);
    }
   
    public List<Appointment> getPatientAppointmentsByStatus(Long patientId, AppointmentStatus status) {
        return appointmentRepository.findByPatientIdAndStatus(patientId, status);
    }
   
    public List<Appointment> getDoctorAppointmentsByStatus(Long doctorId, AppointmentStatus status) {
        return appointmentRepository.findByDoctorIdAndStatus(doctorId, status);
    }
   
    public List<Appointment> getDoctorAppointmentsByDate(Long doctorId, LocalDate date) {
        return appointmentRepository.findDoctorAppointmentsByDate(doctorId, date);
    }
   
    public List<Appointment> getAppointmentsBetweenDates(LocalDate startDate, LocalDate endDate) {
        return appointmentRepository.findAppointmentsBetweenDates(startDate, endDate);
    }
   
    public Appointment createAppointment(Appointment appointment) {
        // Validate patient exists
        try {
            Boolean patientExists = patientServiceClient.patientExists(appointment.getPatientId());
            if (!patientExists) {
                throw new RuntimeException("Patient with ID " + appointment.getPatientId() + " does not exist");
            }
        } catch (Exception e) {
            throw new RuntimeException("Unable to verify patient existence: " + e.getMessage());
        }
       
        // Validate doctor exists
        try {
            Boolean doctorExists = doctorServiceClient.doctorExists(appointment.getDoctorId());
            if (!doctorExists) {
                throw new RuntimeException("Doctor with ID " + appointment.getDoctorId() + " does not exist");
            }
        } catch (Exception e) {
            throw new RuntimeException("Unable to verify doctor existence: " + e.getMessage());
        }
       
        // Check for conflicting appointments
        List<Appointment> conflictingAppointments = appointmentRepository.findConflictingAppointments(
                appointment.getDoctorId(),
                appointment.getAppointmentDate(),
                appointment.getAppointmentTime());
       
        if (!conflictingAppointments.isEmpty()) {
            throw new RuntimeException("Doctor already has an appointment at this time");
        }
       
        // Check if appointment is in the past
        if (appointment.getAppointmentDate().isBefore(LocalDate.now())) {
            throw new RuntimeException("Cannot schedule appointment in the past");
        }
       
        appointment.setStatus(AppointmentStatus.SCHEDULED);
        return appointmentRepository.save(appointment);
    }
   
    public Appointment updateAppointment(Long id, Appointment appointmentDetails) {
        Appointment appointment = appointmentRepository.findById(id)
                .orElseThrow(() -> new RuntimeException("Appointment not found with id: " + id));
       
        // If date or time is being changed, check for conflicts
        if (!appointment.getAppointmentDate().equals(appointmentDetails.getAppointmentDate()) ||
            !appointment.getAppointmentTime().equals(appointmentDetails.getAppointmentTime())) {
           
            List<Appointment> conflictingAppointments = appointmentRepository.findConflictingAppointments(
                    appointmentDetails.getDoctorId(),
                    appointmentDetails.getAppointmentDate(),
                    appointmentDetails.getAppointmentTime());
           
            // Remove current appointment from conflicts (if it's the same appointment)
            conflictingAppointments.removeIf(a -> a.getId().equals(id));
           
            if (!conflictingAppointments.isEmpty()) {
                throw new RuntimeException("Doctor already has an appointment at this time");
            }
        }
       
        // Check if new appointment date is in the past
        if (appointmentDetails.getAppointmentDate().isBefore(LocalDate.now())) {
            throw new RuntimeException("Cannot schedule appointment in the past");
        }
       
        appointment.setPatientId(appointmentDetails.getPatientId());
        appointment.setDoctorId(appointmentDetails.getDoctorId());
        appointment.setAppointmentDate(appointmentDetails.getAppointmentDate());
        appointment.setAppointmentTime(appointmentDetails.getAppointmentTime());
        appointment.setNotes(appointmentDetails.getNotes());
       
        return appointmentRepository.save(appointment);
    }
   
    public Appointment updateAppointmentStatus(Long id, AppointmentStatus status) {
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
   
    public Appointment cancelAppointment(Long id) {
        return updateAppointmentStatus(id, AppointmentStatus.CANCELLED);
    }
   
    public Appointment completeAppointment(Long id) {
        return updateAppointmentStatus(id, AppointmentStatus.COMPLETED);
    }
}