package com.debyendu.web.client;

import com.debyendu.web.model.Doctor;
import org.springframework.cloud.openfeign.FeignClient;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@FeignClient(name = "doctor-service", url = "${api.gateway.url}")
public interface DoctorServiceClient {
   
    @GetMapping("/doctors")
    List<Doctor> getAllDoctors();
   
    @GetMapping("/doctors/{id}")
    Doctor getDoctorById(@PathVariable("id") Long id);
   
    @PostMapping("/doctors")
    Doctor createDoctor(@RequestBody Doctor doctor);
   
    @PutMapping("/doctors/{id}")
    Doctor updateDoctor(@PathVariable("id") Long id, @RequestBody Doctor doctor);
   
    @DeleteMapping("/doctors/{id}")
    void deleteDoctor(@PathVariable("id") Long id);
   
    @GetMapping("/doctors/specialization/{specialization}")
    List<Doctor> getDoctorsBySpecialization(@PathVariable("specialization") String specialization);
   
    @GetMapping("/doctors/department/{department}")
    List<Doctor> getDoctorsByDepartment(@PathVariable("department") String department);
   
    @GetMapping("/doctors/search")
    List<Doctor> searchDoctors(@RequestParam("firstName") String firstName,
                              @RequestParam("lastName") String lastName);
}