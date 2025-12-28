package com.healthcare.patientmanagement.controller;

import com.healthcare.patientmanagement.entity.Patient;
import com.healthcare.patientmanagement.entity.Doctor;
import com.healthcare.patientmanagement.entity.Appointment;
import com.healthcare.patientmanagement.entity.MedicalRecord;
import com.healthcare.patientmanagement.service.PatientService;
import com.healthcare.patientmanagement.service.DoctorService;
import com.healthcare.patientmanagement.service.AppointmentService;
import com.healthcare.patientmanagement.service.MedicalRecordService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import java.util.List;
import java.util.Optional;

@Controller
@RequestMapping("/web")
public class WebController {
   
    @Autowired
    private PatientService patientService;
   
    @Autowired
    private DoctorService doctorService;
   
    @Autowired
    private AppointmentService appointmentService;
   
    @Autowired
    private MedicalRecordService medicalRecordService;
   
    @GetMapping("/")
    public String home() {
        return "redirect:/web/dashboard";
    }
   
    @GetMapping("/dashboard")
    public String dashboard(Model model) {
        model.addAttribute("totalPatients", patientService.getAllPatients().size());
        model.addAttribute("totalDoctors", doctorService.getAllDoctors().size());
        model.addAttribute("totalAppointments", appointmentService.getAllAppointments().size());
        return "dashboard";
    }
   
    // Patient Management Pages
    @GetMapping("/patients")
    public String listPatients(Model model) {
        List<Patient> patients = patientService.getAllPatients();
        model.addAttribute("patients", patients);
        return "patients/list";
    }
   
    @GetMapping("/patients/new")
    public String showPatientForm(Model model) {
        model.addAttribute("patient", new Patient());
        return "patients/form";
    }
   
    @GetMapping("/patients/{id}")
    public String showPatient(@PathVariable Long id, Model model) {
        Optional<Patient> patient = patientService.getPatientById(id);
        if (patient.isPresent()) {
            model.addAttribute("patient", patient.get());
            return "patients/view";
        }
        return "redirect:/web/patients";
    }
   
    @GetMapping("/patients/edit/{id}")
    public String editPatient(@PathVariable Long id, Model model) {
        Optional<Patient> patient = patientService.getPatientById(id);
        if (patient.isPresent()) {
            model.addAttribute("patient", patient.get());
            return "patients/form";
        }
        return "redirect:/web/patients";
    }
   
    @PostMapping("/patients/save")
    public String savePatient(@ModelAttribute Patient patient, RedirectAttributes redirectAttributes) {
        try {
            if (patient.getId() != null) {
                patientService.updatePatient(patient.getId(), patient);
                redirectAttributes.addFlashAttribute("successMessage", "Patient updated successfully!");
            } else {
                patientService.savePatient(patient);
                redirectAttributes.addFlashAttribute("successMessage", "Patient created successfully!");
            }
        } catch (Exception e) {
            redirectAttributes.addFlashAttribute("errorMessage", "Error saving patient: " + e.getMessage());
        }
        return "redirect:/web/patients";
    }
   
    @GetMapping("/patients/delete/{id}")
    public String deletePatient(@PathVariable Long id, RedirectAttributes redirectAttributes) {
        try {
            patientService.deletePatient(id);
            redirectAttributes.addFlashAttribute("successMessage", "Patient deleted successfully!");
        } catch (Exception e) {
            redirectAttributes.addFlashAttribute("errorMessage", "Error deleting patient: " + e.getMessage());
        }
        return "redirect:/web/patients";
    }
   
    // Doctor Management Pages
    @GetMapping("/doctors")
    public String listDoctors(Model model) {
        List<Doctor> doctors = doctorService.getAllDoctors();
        model.addAttribute("doctors", doctors);
        return "doctors/list";
    }
   
    @GetMapping("/doctors/new")
    public String showDoctorForm(Model model) {
        model.addAttribute("doctor", new Doctor());
        return "doctors/form";
    }
   
    @GetMapping("/doctors/{id}")
    public String showDoctor(@PathVariable Long id, Model model) {
        Optional<Doctor> doctor = doctorService.getDoctorById(id);
        if (doctor.isPresent()) {
            model.addAttribute("doctor", doctor.get());
            return "doctors/view";
        }
        return "redirect:/web/doctors";
    }
   
    @GetMapping("/doctors/edit/{id}")
    public String editDoctor(@PathVariable Long id, Model model) {
        Optional<Doctor> doctor = doctorService.getDoctorById(id);
        if (doctor.isPresent()) {
            model.addAttribute("doctor", doctor.get());
            return "doctors/form";
        }
        return "redirect:/web/doctors";
    }
   
    @PostMapping("/doctors/save")
    public String saveDoctor(@ModelAttribute Doctor doctor, RedirectAttributes redirectAttributes) {
        try {
            if (doctor.getId() != null) {
                doctorService.updateDoctor(doctor.getId(), doctor);
                redirectAttributes.addFlashAttribute("successMessage", "Doctor updated successfully!");
            } else {
                doctorService.saveDoctor(doctor);
                redirectAttributes.addFlashAttribute("successMessage", "Doctor created successfully!");
            }
        } catch (Exception e) {
            redirectAttributes.addFlashAttribute("errorMessage", "Error saving doctor: " + e.getMessage());
        }
        return "redirect:/web/doctors";
    }
   
    @GetMapping("/doctors/delete/{id}")
    public String deleteDoctor(@PathVariable Long id, RedirectAttributes redirectAttributes) {
        try {
            doctorService.deleteDoctor(id);
            redirectAttributes.addFlashAttribute("successMessage", "Doctor deleted successfully!");
        } catch (Exception e) {
            redirectAttributes.addFlashAttribute("errorMessage", "Error deleting doctor: " + e.getMessage());
        }
        return "redirect:/web/doctors";
    }
   
    // Appointment Management Pages
    @GetMapping("/appointments")
    public String listAppointments(Model model) {
        List<Appointment> appointments = appointmentService.getAllAppointments();
        model.addAttribute("appointments", appointments);
        return "appointments/list";
    }
   
    @GetMapping("/appointments/new")
    public String showAppointmentForm(Model model) {
        model.addAttribute("appointment", new Appointment());
        model.addAttribute("patients", patientService.getAllPatients());
        model.addAttribute("doctors", doctorService.getAvailableDoctors());
        return "appointments/form";
    }
   
    // Medical Records Management Pages
    @GetMapping("/medical-records")
    public String listMedicalRecords(Model model) {
        List<MedicalRecord> medicalRecords = medicalRecordService.getAllMedicalRecords();
        model.addAttribute("medicalRecords", medicalRecords);
        model.addAttribute("patients", patientService.getAllPatients());
        model.addAttribute("doctors", doctorService.getAllDoctors());
        return "medical-records/list";
    }
   
    @GetMapping("/medical-records/new")
    public String showMedicalRecordForm(Model model, @RequestParam(required = false) Long patientId) {
        MedicalRecord medicalRecord = new MedicalRecord();
        if (patientId != null) {
            patientService.getPatientById(patientId).ifPresent(medicalRecord::setPatient);
        }
        model.addAttribute("medicalRecord", medicalRecord);
        model.addAttribute("patients", patientService.getAllPatients());
        model.addAttribute("doctors", doctorService.getAllDoctors());
        return "medical-records/form";
    }
   
    @GetMapping("/medical-records/{id}")
    public String showMedicalRecord(@PathVariable Long id, Model model) {
        Optional<MedicalRecord> medicalRecord = medicalRecordService.getMedicalRecordById(id);
        if (medicalRecord.isPresent()) {
            model.addAttribute("medicalRecord", medicalRecord.get());
            return "medical-records/view";
        }
        return "redirect:/web/medical-records";
    }
   
    @GetMapping("/medical-records/edit/{id}")
    public String editMedicalRecord(@PathVariable Long id, Model model) {
        Optional<MedicalRecord> medicalRecord = medicalRecordService.getMedicalRecordById(id);
        if (medicalRecord.isPresent()) {
            model.addAttribute("medicalRecord", medicalRecord.get());
            model.addAttribute("patients", patientService.getAllPatients());
            model.addAttribute("doctors", doctorService.getAllDoctors());
            return "medical-records/form";
        }
        return "redirect:/web/medical-records";
    }
   
    @PostMapping("/medical-records/save")
    public String saveMedicalRecord(@ModelAttribute MedicalRecord medicalRecord,
                                   @RequestParam(required = false) boolean print,
                                   RedirectAttributes redirectAttributes) {
        try {
            if (medicalRecord.getId() != null) {
                medicalRecordService.updateMedicalRecord(medicalRecord.getId(), medicalRecord);
                redirectAttributes.addFlashAttribute("successMessage", "Medical record updated successfully!");
            } else {
                medicalRecordService.saveMedicalRecord(medicalRecord);
                redirectAttributes.addFlashAttribute("successMessage", "Medical record created successfully!");
            }
           
            if (print) {
                return "redirect:/web/medical-records/" + medicalRecord.getId() + "?print=true";
            }
        } catch (Exception e) {
            redirectAttributes.addFlashAttribute("errorMessage", "Error saving medical record: " + e.getMessage());
        }
        return "redirect:/web/medical-records";
    }
   
    @GetMapping("/medical-records/delete/{id}")
    public String deleteMedicalRecord(@PathVariable Long id, RedirectAttributes redirectAttributes) {
        try {
            medicalRecordService.deleteMedicalRecord(id);
            redirectAttributes.addFlashAttribute("successMessage", "Medical record deleted successfully!");
        } catch (Exception e) {
            redirectAttributes.addFlashAttribute("errorMessage", "Error deleting medical record: " + e.getMessage());
        }
        return "redirect:/web/medical-records";
    }
}
