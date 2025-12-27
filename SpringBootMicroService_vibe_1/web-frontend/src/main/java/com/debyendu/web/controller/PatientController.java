package com.debyendu.web.controller;

import com.debyendu.web.client.PatientServiceClient;
import com.debyendu.web.model.Patient;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import java.util.List;

@Controller
@RequestMapping("/patients")
public class PatientController {
   
    @Autowired
    private PatientServiceClient patientServiceClient;
   
    @GetMapping
    public String listPatients(Model model) {
        try {
            List<Patient> patients = patientServiceClient.getAllPatients();
            model.addAttribute("patients", patients);
            model.addAttribute("title", "Patients");
        } catch (Exception e) {
            model.addAttribute("error", "Unable to fetch patients: " + e.getMessage());
        }
        return "patients/list";
    }
   
    @GetMapping("/new")
    public String showCreateForm(Model model) {
        model.addAttribute("patient", new Patient());
        model.addAttribute("title", "Add New Patient");
        return "patients/form";
    }
   
    @PostMapping
    public String createPatient(@ModelAttribute Patient patient, RedirectAttributes redirectAttributes) {
        try {
            patientServiceClient.createPatient(patient);
            redirectAttributes.addFlashAttribute("success", "Patient created successfully!");
        } catch (Exception e) {
            redirectAttributes.addFlashAttribute("error", "Error creating patient: " + e.getMessage());
        }
        return "redirect:/patients";
    }
   
    @GetMapping("/{id}")
    public String viewPatient(@PathVariable Long id, Model model) {
        try {
            Patient patient = patientServiceClient.getPatientById(id);
            model.addAttribute("patient", patient);
            model.addAttribute("title", "Patient Details");
        } catch (Exception e) {
            model.addAttribute("error", "Patient not found: " + e.getMessage());
            return "redirect:/patients";
        }
        return "patients/view";
    }
   
    @GetMapping("/{id}/edit")
    public String showEditForm(@PathVariable Long id, Model model) {
        try {
            Patient patient = patientServiceClient.getPatientById(id);
            model.addAttribute("patient", patient);
            model.addAttribute("title", "Edit Patient");
            return "patients/form";
        } catch (Exception e) {
            model.addAttribute("error", "Patient not found: " + e.getMessage());
            return "redirect:/patients";
        }
    }
   
    @PostMapping("/{id}")
    public String updatePatient(@PathVariable Long id, @ModelAttribute Patient patient,
                               RedirectAttributes redirectAttributes) {
        try {
            patient.setId(id);
            patientServiceClient.updatePatient(id, patient);
            redirectAttributes.addFlashAttribute("success", "Patient updated successfully!");
        } catch (Exception e) {
            redirectAttributes.addFlashAttribute("error", "Error updating patient: " + e.getMessage());
        }
        return "redirect:/patients";
    }
   
    @PostMapping("/{id}/delete")
    public String deletePatient(@PathVariable Long id, RedirectAttributes redirectAttributes) {
        try {
            patientServiceClient.deletePatient(id);
            redirectAttributes.addFlashAttribute("success", "Patient deleted successfully!");
        } catch (Exception e) {
            redirectAttributes.addFlashAttribute("error", "Error deleting patient: " + e.getMessage());
        }
        return "redirect:/patients";
    }
   
    @GetMapping("/search")
    public String searchPatients(@RequestParam(required = false) String firstName,
                                @RequestParam(required = false) String lastName,
                                @RequestParam(required = false) String bloodType,
                                Model model) {
        try {
            List<Patient> patients;
            if (bloodType != null && !bloodType.isEmpty()) {
                patients = patientServiceClient.getPatientsByBloodType(bloodType);
            } else if (firstName != null && lastName != null &&
                      !firstName.isEmpty() && !lastName.isEmpty()) {
                patients = patientServiceClient.searchPatients(firstName, lastName);
            } else {
                patients = patientServiceClient.getAllPatients();
            }
            model.addAttribute("patients", patients);
            model.addAttribute("title", "Search Results");
        } catch (Exception e) {
            model.addAttribute("error", "Search failed: " + e.getMessage());
        }
        return "patients/list";
    }
}