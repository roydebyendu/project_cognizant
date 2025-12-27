package com.debyendu.web.controller;

import com.debyendu.web.client.AppointmentServiceClient;
import com.debyendu.web.client.DoctorServiceClient;
import com.debyendu.web.client.PatientServiceClient;
import com.debyendu.web.model.Appointment;
import com.debyendu.web.model.Doctor;
import com.debyendu.web.model.Patient;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import java.util.List;

@Controller
@RequestMapping("/appointments")
public class AppointmentController {
   
    @Autowired
    private AppointmentServiceClient appointmentServiceClient;
   
    @Autowired
    private PatientServiceClient patientServiceClient;
   
    @Autowired
    private DoctorServiceClient doctorServiceClient;
   
    @GetMapping
    public String listAppointments(Model model) {
        try {
            List<Appointment> appointments = appointmentServiceClient.getAllAppointments();
            // Enrich appointments with patient and doctor names
            for (Appointment appointment : appointments) {
                try {
                    Patient patient = patientServiceClient.getPatientById(appointment.getPatientId());
                    appointment.setPatientName(patient.getFullName());
                } catch (Exception e) {
                    appointment.setPatientName("Unknown Patient");
                }
               
                try {
                    Doctor doctor = doctorServiceClient.getDoctorById(appointment.getDoctorId());
                    appointment.setDoctorName(doctor.getFullName());
                } catch (Exception e) {
                    appointment.setDoctorName("Unknown Doctor");
                }
            }
            model.addAttribute("appointments", appointments);
            model.addAttribute("title", "Appointments");
        } catch (Exception e) {
            model.addAttribute("error", "Unable to fetch appointments: " + e.getMessage());
        }
        return "appointments/list";
    }
   
    @GetMapping("/new")
    public String showCreateForm(Model model) {
        try {
            List<Patient> patients = patientServiceClient.getAllPatients();
            List<Doctor> doctors = doctorServiceClient.getAllDoctors();
            model.addAttribute("appointment", new Appointment());
            model.addAttribute("patients", patients);
            model.addAttribute("doctors", doctors);
            model.addAttribute("title", "Schedule New Appointment");
        } catch (Exception e) {
            model.addAttribute("error", "Unable to load form data: " + e.getMessage());
        }
        return "appointments/form";
    }
   
    @PostMapping
    public String createAppointment(@ModelAttribute Appointment appointment, RedirectAttributes redirectAttributes) {
        try {
            appointmentServiceClient.createAppointment(appointment);
            redirectAttributes.addFlashAttribute("success", "Appointment scheduled successfully!");
        } catch (Exception e) {
            redirectAttributes.addFlashAttribute("error", "Error scheduling appointment: " + e.getMessage());
        }
        return "redirect:/appointments";
    }
   
    @GetMapping("/{id}")
    public String viewAppointment(@PathVariable Long id, Model model) {
        try {
            Appointment appointment = appointmentServiceClient.getAppointmentById(id);
           
            // Get patient and doctor details
            try {
                Patient patient = patientServiceClient.getPatientById(appointment.getPatientId());
                model.addAttribute("patient", patient);
            } catch (Exception e) {
                model.addAttribute("patientError", "Unable to load patient details");
            }
           
            try {
                Doctor doctor = doctorServiceClient.getDoctorById(appointment.getDoctorId());
                model.addAttribute("doctor", doctor);
            } catch (Exception e) {
                model.addAttribute("doctorError", "Unable to load doctor details");
            }
           
            model.addAttribute("appointment", appointment);
            model.addAttribute("title", "Appointment Details");
        } catch (Exception e) {
            model.addAttribute("error", "Appointment not found: " + e.getMessage());
            return "redirect:/appointments";
        }
        return "appointments/view";
    }
   
    @GetMapping("/{id}/edit")
    public String showEditForm(@PathVariable Long id, Model model) {
        try {
            Appointment appointment = appointmentServiceClient.getAppointmentById(id);
            List<Patient> patients = patientServiceClient.getAllPatients();
            List<Doctor> doctors = doctorServiceClient.getAllDoctors();
           
            model.addAttribute("appointment", appointment);
            model.addAttribute("patients", patients);
            model.addAttribute("doctors", doctors);
            model.addAttribute("title", "Edit Appointment");
            return "appointments/form";
        } catch (Exception e) {
            model.addAttribute("error", "Appointment not found: " + e.getMessage());
            return "redirect:/appointments";
        }
    }
   
    @PostMapping("/{id}")
    public String updateAppointment(@PathVariable Long id, @ModelAttribute Appointment appointment,
                                   RedirectAttributes redirectAttributes) {
        try {
            appointment.setId(id);
            appointmentServiceClient.updateAppointment(id, appointment);
            redirectAttributes.addFlashAttribute("success", "Appointment updated successfully!");
        } catch (Exception e) {
            redirectAttributes.addFlashAttribute("error", "Error updating appointment: " + e.getMessage());
        }
        return "redirect:/appointments";
    }
   
    @PostMapping("/{id}/delete")
    public String deleteAppointment(@PathVariable Long id, RedirectAttributes redirectAttributes) {
        try {
            appointmentServiceClient.deleteAppointment(id);
            redirectAttributes.addFlashAttribute("success", "Appointment cancelled successfully!");
        } catch (Exception e) {
            redirectAttributes.addFlashAttribute("error", "Error cancelling appointment: " + e.getMessage());
        }
        return "redirect:/appointments";
    }
   
    @PostMapping("/{id}/status/{status}")
    public String updateAppointmentStatus(@PathVariable Long id, @PathVariable String status,
                                         RedirectAttributes redirectAttributes) {
        try {
            appointmentServiceClient.updateAppointmentStatus(id, status);
            redirectAttributes.addFlashAttribute("success", "Appointment status updated successfully!");
        } catch (Exception e) {
            redirectAttributes.addFlashAttribute("error", "Error updating status: " + e.getMessage());
        }
        return "redirect:/appointments/" + id;
    }
   
    @GetMapping("/patient/{patientId}")
    public String getPatientAppointments(@PathVariable Long patientId, Model model) {
        try {
            List<Appointment> appointments = appointmentServiceClient.getAppointmentsByPatientId(patientId);
            Patient patient = patientServiceClient.getPatientById(patientId);
           
            model.addAttribute("appointments", appointments);
            model.addAttribute("patient", patient);
            model.addAttribute("title", "Appointments for " + patient.getFullName());
        } catch (Exception e) {
            model.addAttribute("error", "Unable to fetch patient appointments: " + e.getMessage());
        }
        return "appointments/patient-appointments";
    }
   
    @GetMapping("/doctor/{doctorId}")
    public String getDoctorAppointments(@PathVariable Long doctorId, Model model) {
        try {
            List<Appointment> appointments = appointmentServiceClient.getAppointmentsByDoctorId(doctorId);
            Doctor doctor = doctorServiceClient.getDoctorById(doctorId);
           
            model.addAttribute("appointments", appointments);
            model.addAttribute("doctor", doctor);
            model.addAttribute("title", "Appointments for " + doctor.getFullName());
        } catch (Exception e) {
            model.addAttribute("error", "Unable to fetch doctor appointments: " + e.getMessage());
        }
        return "appointments/doctor-appointments";
    }
}