package com.debyendu.web.controller;

import com.debyendu.web.client.DoctorServiceClient;
import com.debyendu.web.model.Doctor;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import java.util.List;

@Controller
@RequestMapping("/doctors")
public class DoctorController {
   
    @Autowired
    private DoctorServiceClient doctorServiceClient;
   
    @GetMapping
    public String listDoctors(Model model) {
        try {
            List<Doctor> doctors = doctorServiceClient.getAllDoctors();
            model.addAttribute("doctors", doctors);
            model.addAttribute("title", "Doctors");
        } catch (Exception e) {
            model.addAttribute("error", "Unable to fetch doctors: " + e.getMessage());
        }
        return "doctors/list";
    }
   
    @GetMapping("/new")
    public String showCreateForm(Model model) {
        model.addAttribute("doctor", new Doctor());
        model.addAttribute("title", "Add New Doctor");
        return "doctors/form";
    }
   
    @PostMapping
    public String createDoctor(@ModelAttribute Doctor doctor, RedirectAttributes redirectAttributes) {
        try {
            doctorServiceClient.createDoctor(doctor);
            redirectAttributes.addFlashAttribute("success", "Doctor created successfully!");
        } catch (Exception e) {
            redirectAttributes.addFlashAttribute("error", "Error creating doctor: " + e.getMessage());
        }
        return "redirect:/doctors";
    }
   
    @GetMapping("/{id}")
    public String viewDoctor(@PathVariable Long id, Model model) {
        try {
            Doctor doctor = doctorServiceClient.getDoctorById(id);
            model.addAttribute("doctor", doctor);
            model.addAttribute("title", "Doctor Details");
        } catch (Exception e) {
            model.addAttribute("error", "Doctor not found: " + e.getMessage());
            return "redirect:/doctors";
        }
        return "doctors/view";
    }
   
    @GetMapping("/{id}/edit")
    public String showEditForm(@PathVariable Long id, Model model) {
        try {
            Doctor doctor = doctorServiceClient.getDoctorById(id);
            model.addAttribute("doctor", doctor);
            model.addAttribute("title", "Edit Doctor");
            return "doctors/form";
        } catch (Exception e) {
            model.addAttribute("error", "Doctor not found: " + e.getMessage());
            return "redirect:/doctors";
        }
    }
   
    @PostMapping("/{id}")
    public String updateDoctor(@PathVariable Long id, @ModelAttribute Doctor doctor,
                              RedirectAttributes redirectAttributes) {
        try {
            doctor.setId(id);
            doctorServiceClient.updateDoctor(id, doctor);
            redirectAttributes.addFlashAttribute("success", "Doctor updated successfully!");
        } catch (Exception e) {
            redirectAttributes.addFlashAttribute("error", "Error updating doctor: " + e.getMessage());
        }
        return "redirect:/doctors";
    }
   
    @PostMapping("/{id}/delete")
    public String deleteDoctor(@PathVariable Long id, RedirectAttributes redirectAttributes) {
        try {
            doctorServiceClient.deleteDoctor(id);
            redirectAttributes.addFlashAttribute("success", "Doctor deleted successfully!");
        } catch (Exception e) {
            redirectAttributes.addFlashAttribute("error", "Error deleting doctor: " + e.getMessage());
        }
        return "redirect:/doctors";
    }
   
    @GetMapping("/search")
    public String searchDoctors(@RequestParam(required = false) String firstName,
                               @RequestParam(required = false) String lastName,
                               @RequestParam(required = false) String specialization,
                               @RequestParam(required = false) String department,
                               Model model) {
        try {
            List<Doctor> doctors;
            if (specialization != null && !specialization.isEmpty()) {
                doctors = doctorServiceClient.getDoctorsBySpecialization(specialization);
            } else if (department != null && !department.isEmpty()) {
                doctors = doctorServiceClient.getDoctorsByDepartment(department);
            } else if (firstName != null && lastName != null &&
                      !firstName.isEmpty() && !lastName.isEmpty()) {
                doctors = doctorServiceClient.searchDoctors(firstName, lastName);
            } else {
                doctors = doctorServiceClient.getAllDoctors();
            }
            model.addAttribute("doctors", doctors);
            model.addAttribute("title", "Search Results");
        } catch (Exception e) {
            model.addAttribute("error", "Search failed: " + e.getMessage());
        }
        return "doctors/list";
    }
}